//
//  ViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNChatKitViewController.h"
#import "LCNMessageLayout.h"
#import "LCNRefreshView.h"
#import "YYPhotoGroupView.h"
#import "LCNAudioRecordDelegate.h"
#import "LCNAudioPlayDelegate.h"
#import "AudioRecordIndicatorView.h"
#import "LCNAudioManager.h"


@interface LCNChatKitViewController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching,
LCNAudioRecordDelegate,
LCNAudioPlayDelegate
>

//帧率显示器
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

//输入框
@property (nonatomic, strong) LCNInputBar *inputbar;

//录音指示器
@property (nonatomic, strong) AudioRecordIndicatorView *recordIndicatorView;
@property (nonatomic, strong) LCNMessageLayout *currentAudioRecordingLayout;

@end

@implementation LCNChatKitViewController{
    BOOL _isPulling;
    BOOL _isLoading;
    BOOL _isLoadMoreCompleted;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化参数
    _isPulling = NO;
    _isLoading = NO;
    _isLoadMoreCompleted = YES;

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.fpsLabel];
    [self.view addSubview:self.inputbar];
    
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    
    //自动调整CollectionView的WrapperView
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewDidAppear:(BOOL)animated{
    [_collectionView scrollToBottomAnimated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}

-(void)dealloc{
}

#pragma mark - LCNCollectionViewDataSource
//seciton数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//section内item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.chatMessagesManager.messagesCount;
}

//CollectionView Header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LCNRefreshView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([LCNRefreshView class]) forIndexPath:indexPath];
    
    //默认一直让他转
    [headView startAnimation];
    
    return headView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (_isLoadMoreCompleted == YES && _isLoading == NO) {
        return CGSizeMake(kScreenWidth, 0);
    }
    else{
        return CGSizeMake(kScreenWidth, 40);
    }
}



//cellForItem
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [self.chatMessagesManager messageLayoutAtIndexPath:indexPath];
    LCNCollectionViewCell *cell = nil;
    if (!layout.model.isOutgoing) {
        cell = (LCNCollectionViewIncomingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class]) forIndexPath:indexPath];
    }
    else{
        cell = (LCNCollectionViewOutgoingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class]) forIndexPath:indexPath];
    }
    
    //设置Cell布局
    cell.delegate = self;
    [cell setLayout:layout];
    
    return cell;
}

-(NSArray<LCNMessageLayout *> *)collection:(UICollectionView *)collectionView loadMoreItemsCount:(NSInteger)count{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


#pragma mark - LCNCollectionViewDelegate

//CollectionViewCell被点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

//CollectionViewCell 将要被用于展示
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [self.chatMessagesManager messageLayoutAtIndexPath:indexPath];
    
    //表情气泡即将展示时，开启动画
    if (layout.model.mediaType == LCNMediaType_Emoji) {
        LCNEmojiMedaiBubble *emojiBubble = (LCNEmojiMedaiBubble*)layout.model.mediaBubble;
        [emojiBubble.imageView startAnimating];
    }
    
}

//CollectionViewCell 离开展示区
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //表情气泡离开展示区时，关闭动画
    LCNMessageLayout *layout = [self.chatMessagesManager messageLayoutAtIndexPath:indexPath];
    if (layout.model.mediaType == LCNMediaType_Emoji && layout) {
        LCNEmojiMedaiBubble *emojiBubble = (LCNEmojiMedaiBubble*)layout.model.mediaBubble;
        [emojiBubble.imageView stopAnimating];
    }
}

#pragma mark - LCNCollectionViewCellDelegate
- (void)cellDidClickAvatar:(LCNCollectionViewCell *)cell{
//    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);

}

- (void)cellDidClickNameLabel:(LCNCollectionViewCell *)cell{
//    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);

}

- (void)cellDidClickBubbleView:(LCNCollectionViewCell *)cell{
//    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    
    LCNMediaType mediaType = cell.layout.model.mediaType;
    switch (mediaType) {
        case LCNMediaType_Image:
        case LCNMediaType_Emoji:
        {
            [self showPhotoBrowserWithCell:cell];
        }
            break;
        case LCNMediaType_Audio:
        {
            //语音气泡的动画起停控制
            if([cell.layout.model.mediaBubble isKindOfClass:[LCNAudioMediaBubble class]]){
                LCNAudioMediaBubble *item = (LCNAudioMediaBubble *)cell.layout.model.mediaBubble;
                [item startAnimation];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [item stopAnimation];
                });
            }
        }
            break;
        case LCNMediaType_Video:
        {}
            break;
        case LCNMediaType_Location:
        {}
            break;
        default:
            break;
    }

}

- (void)cellDidLongPressBubbleView:(LCNCollectionViewCell *)cell{
    [self handleLongPressBubbleView:cell];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//CollectionViewCell高度设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [self.chatMessagesManager messageLayoutAtIndexPath:indexPath];;
    CGFloat cellHeight = layout.cellHeight;
    
    return CGSizeMake(kScreenWidth, cellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_isLoading &&!_isPulling
        && (scrollView.isDragging || scrollView.isDecelerating)
        && scrollView.contentOffset.y <= 20 - scrollView.contentInset.top
        && [self.chatMessagesManager messagesCount] > 0) {
        _isPulling = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!_isLoading && _isPulling) {
        [self pullToRefresh];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isPulling) {
        [self pullToRefresh];
    }
}

#pragma mark - YYTextKeyboardObserver
#pragma mark 键盘管理类，调整布局回调
/// 键盘事件监听处理
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition{
    
    YYTextKeyboardManager *manager = [YYTextKeyboardManager defaultManager];
    CGRect toFrame =  [manager convertRect:transition.toFrame toView:self.view];
    
    NSTimeInterval animationDuration = transition.animationDuration;
    
    if (transition.toVisible == YES) {
        //升起inputBar
        [UIView animateWithDuration:animationDuration animations:^{
            _collectionView.height = kScreenHeight - toFrame.size.height - _inputbar.height;
            _inputbar.top = toFrame.origin.y - _inputbar.height;
            [_collectionView scrollToBottomAnimated:YES];
        } completion:^(BOOL finished) {
            //collection下滑到最新一条消息
        }];
    }
    else{
        //降下inputBar
        [UIView animateWithDuration:animationDuration animations:^{
            [_inputbar resetAllButton];
            _collectionView.height = kScreenHeight - _inputbar.height;
            _inputbar.top = kScreenHeight - _inputbar.height;
        }];
    }
}

#pragma mark - LCNInputBarDelegate
#pragma mark 输入框高度发生变化，调整布局回调
-(void)LCNInpuBatHeightChanged:(CGFloat)currentTextviewHeight{
    CGRect keyboardFrame = [YYTextKeyboardManager defaultManager].keyboardFrame;
    _collectionView.height = kScreenHeight - keyboardFrame.size.height - currentTextviewHeight;
    _inputbar.top = keyboardFrame.origin.y - currentTextviewHeight;
    
}

#pragma mark - 语音输入相关回调
- (void)voiceRecordingShouldStart{
    //显示录音指示试图
    [self.recordIndicatorView setCurrentRecordIndicatorStatus:AudioRecordIndicatorStatus_Recording];
    [self.recordIndicatorView show];
    
    [[LCNAudioManager sharedManager] stopPlaying];
    
    if (![[LCNAudioManager sharedManager] isRecording]) {
        [[LCNAudioManager sharedManager] startRecordingWithDelegate:self];
    }
}

- (void)voiceRecordingShouldCancel{
    [self.recordIndicatorView hide];
    
    [[LCNAudioManager sharedManager] cancelRecording];
}

- (void)voicRecordingShouldFinish{
    [self.recordIndicatorView hide];
    
    [[LCNAudioManager sharedManager] stopRecording];
}

- (void)voiceRecordingDidDraginside{
    [self.recordIndicatorView setCurrentRecordIndicatorStatus:AudioRecordIndicatorStatus_Recording];

}

- (void)voiceRecordingDidDragoutside{
    [self.recordIndicatorView setCurrentRecordIndicatorStatus:AudioRecordIndicatorStatus_Canel];
    
}

- (void)voiceRecordingTooShort{
    [self.recordIndicatorView hide];
    
    [HUD showInfoWithStatus:RECORD_TIME_TOOSHORT delay:1];
    
    [[LCNAudioManager sharedManager] cancelRecording];
    
}

#pragma mark - LCNAudioRecordDelegate
//检查录音权限成功
- (void)audioRecordAuthorizationDidGranted{

}

//录音成功开始
- (void)audioRecordDidStartRecordingWithError:(NSError *)error{
    if (error) {
        [self.recordIndicatorView hide];
        return;
    }
    
    //制作录音气泡
    LCNMessageModel *recordingMsgModel = [LCNMessageModel getRecordingMessageModel];
    _currentAudioRecordingLayout = [[LCNMessageLayout alloc] initWithLCNMessageModel:recordingMsgModel
                                                                             preMessageModel:[self.chatMessagesManager lastestMessageLayout].model];
    [self.chatMessagesManager insertMessagesIntoDataSource:@[_currentAudioRecordingLayout] atIndex:[self.chatMessagesManager messagesCount]];
    [self.collectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView scrollToBottomAnimated:YES];
    });
}

//录音音量发生变化
- (void)audioRecordDidUpdateVoiceMeter:(double)averagePower{
    [self.recordIndicatorView setCurrentVoiceVolume:averagePower];
}

//录音时长发生变化，以秒为单位
- (void)audioRecordDurationDidChanged:(NSTimeInterval)duration{
    
}

//录音最长时间
- (NSTimeInterval)audioRecordMaxRecordTime{
    return 0;
}

//录音成功，返回音频文件路径及时长
- (void)audioRecordDidFinishSuccessed:(NSString *)voiceFilePath duration:(CFTimeInterval)duration{
    
    if (_currentAudioRecordingLayout != nil) {
        [self.chatMessagesManager deleteMessageFromDataSourceWithMessageLayout:_currentAudioRecordingLayout];
        [self.collectionView reloadData];
        _currentAudioRecordingLayout = nil;
    }
    
}

- (void)audioRecordDidFailed{
    
}

- (void)audioRecordDidCancelled{
    
    if (_currentAudioRecordingLayout != nil) {
        [self.chatMessagesManager deleteMessageFromDataSourceWithMessageLayout:_currentAudioRecordingLayout];
        [self.collectionView reloadData];
        _currentAudioRecordingLayout = nil;
    }
    
}

//- (void)audioRecordDurationTooShort{
//    
//}

- (void)audioRecordDurationTooLong{
    
}

#pragma mark - LCNAudioPlayDelegate
- (void)audioPlayDidStarted:(id)userinfo{
    
}

//播放录音时，系统声音太小
- (void)audioPlayVolumeTooLow{
    
}

//发生播放错误时，播放Session同时结束
- (void)audioPlayDidFailed:(id)userinfo{
    
}

//播放结束时考虑到连续播放的需求，仅仅停止了当前播放，没有停止播放session
- (void)audioPlayDidStopped:(id)userinfo{
    
}

//播放结束，停止播放session
- (void)audioPlayDidFinished:(id)userinfo{
    
}

#pragma mark - Gesture Method
//配置MenuController
- (void)handleLongPressBubbleView:(LCNCollectionViewCell *)cell{
    LCNMessageLayout *layout = cell.layout;
    LCNMessageModel *model = layout.model;
    
    UIMenuItem *menu_copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menu_copy:)];
    UIMenuItem *menu_sendToOther=[[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(menu_sendToOther:)];
    UIMenuItem *menu_collect=[[UIMenuItem alloc]initWithTitle:@"收藏" action:@selector(menu_collect:)];
    UIMenuItem *menu_removeItem=[[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menu_removeItem:)];
    UIMenuItem *menu_more=[[UIMenuItem alloc]initWithTitle:@"更多" action:@selector(menu_more:)];
    
    UIMenuController *menu=[UIMenuController sharedMenuController];
    [menu setMenuItems:@[menu_copy, menu_sendToOther, menu_collect,menu_removeItem,menu_more]];
    [menu setTargetRect:cell.mediaContainerrView.bounds inView:cell.mediaContainerrView];
    [menu setMenuVisible:YES animated:YES];
}

// 用于UIMenuController显示，缺一不可
-(BOOL)canBecomeFirstResponder{
    return YES;
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action == @selector(menu_copy:)){
        return YES;
    }
    else if(action == @selector(menu_sendToOther:)){
        return YES;
    }
    else if(action == @selector(menu_collect:)){
        return YES;
    }
    else if(action == @selector(menu_removeItem:)){
        return YES;
    }
    else if(action == @selector(menu_more:)){
        return YES;
    }
    else{
        
    }
    return NO;//隐藏系统默认的菜单项
}

#pragma mark - Private Method


/**
 触发刷新
 */
- (void)pullToRefresh {
    _isPulling = NO;
    _isLoading = YES;
    
    NSLog(@"开始下拉刷新");
    [self loadMoreMessage:5];
    
}


/**
 加载消息，获取更多数据

 @param count 加载消息数量
 */
- (void)loadMoreMessage:(int)count{
    
    [UIView setAnimationsEnabled:NO];
    
    _isLoadMoreCompleted = NO;
    
    CGPoint offset = _collectionView.contentOffset;
    //从数据库获取更多数据
    NSArray *layouts = [self.collectionView.dataSource collection:self.collectionView loadMoreItemsCount:count];
    if (layouts.count > 0) {
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:layouts.count];
        for (int i = 0; i < layouts.count; i++) {
            LCNMessageLayout *layout = [layouts objectAtIndex:i];
            offset.y += layout.cellHeight;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPaths addObject:indexPath];
        }
        
        //插入数据源
        [_collectionView performBatchUpdates:^{
            [self.chatMessagesManager insertMessagesIntoDataSource:layouts atIndex:0];
            [_collectionView insertItemsAtIndexPaths:indexPaths];
        } completion:^(BOOL finished) {
            _isLoadMoreCompleted = YES;
            _isLoading = NO;
        }];
    }

    _collectionView.contentOffset = offset;
    
    [UIView setAnimationsEnabled:YES];
}

//图片浏览器
- (void)showPhotoBrowserWithCell:(LCNCollectionViewCell *)cell{
    
    //Todo: 图片消息数量巨大的话，会引起CPU峰值，限制图片浏览数量。
    
    //组装图片浏览Items
    UIView *fromView = nil;
    NSMutableArray *itemArray = [NSMutableArray new];
    for (LCNMessageLayout *layout in [self.chatMessagesManager dataSource]) {
        if (layout.model.mediaType == LCNMediaType_Image) {
            
            LCNImageMediaBubble *imageBubble = (LCNImageMediaBubble *)layout.model.mediaBubble;
            YYPhotoGroupItem *item = [YYPhotoGroupItem new];
            item.thumbView = imageBubble.mediaView;
            item.largeImageURL = [NSURL URLWithString: imageBubble.imageUrl];
            item.largeImageSize = CGSizeMake(imageBubble.image_Width, imageBubble.image_Height);
            [itemArray addObject:item];
            if (cell.layout.model.mediaBubble.mediaView == item.thumbView) {
                fromView = item.thumbView;
            }
        }
        else if(layout.model.mediaType == LCNMediaType_Emoji){
            LCNEmojiMedaiBubble *emojiBubble = (LCNEmojiMedaiBubble *)layout.model.mediaBubble;
            YYPhotoGroupItem *item = [YYPhotoGroupItem new];
            item.thumbView = emojiBubble.mediaView;
            item.largeImageURL = [NSURL URLWithString: emojiBubble.animatedImageUrl];
            item.largeImageSize = emojiBubble.imageSize;
            [itemArray addObject:item];
            if (cell.layout.model.mediaBubble.mediaView == item.thumbView) {
                fromView = item.thumbView;
            }
        }
    }

    //弹出图片浏览控件
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:itemArray];
    [v presentFromImageView:fromView toContainer:self.view animated:YES completion:nil];
}

#pragma mark - UIMenuController Action
- (void)menu_copy:(LCNMessageModel *)mdoel{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (void)menu_sendToOther:(LCNMessageModel *)mdoel{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (void)menu_collect:(LCNMessageModel *)mdoel{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (void)menu_removeItem:(LCNMessageModel *)mdoel{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (void)menu_more:(LCNMessageModel *)mdoel{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}


#pragma mark - Setter & Getter

//ChatMessagesManager
-(LCNChatMessagesManager *)chatMessagesManager{
    if (nil == _chatMessagesManager) {
        _chatMessagesManager = [LCNChatMessagesManager new];
    }
    return _chatMessagesManager;
}


//CollectionView
-(LCNCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[LCNCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kInputBarHeight)
                                              collectionViewLayout:[UICollectionViewFlowLayout new]];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        
        [_collectionView registerClass:[LCNRefreshView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([LCNRefreshView class])];
        [_collectionView registerClass:[LCNCollectionViewIncomingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class])];
        [_collectionView registerClass:[LCNCollectionViewOutgoingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class])];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    }
    return _collectionView;
}

//帧率显示器
-(YYFPSLabel *)fpsLabel{
    if (!_fpsLabel) {
        _fpsLabel = [YYFPSLabel new];
        [_fpsLabel sizeToFit];
        _fpsLabel.left = 80;
        _fpsLabel.top = 0;
    }
    return _fpsLabel;
}

//输入框
-(LCNInputBar *)inputbar{
    if (!_inputbar) {
        _inputbar = [LCNInputBar new];
        _inputbar.top = kScreenHeight - kInputBarHeight;
        _inputbar.delegate = self;
    }
    return _inputbar;
}

//录音指示器
-(AudioRecordIndicatorView *)recordIndicatorView{
    if (nil == _recordIndicatorView) {
        _recordIndicatorView = [[AudioRecordIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
        _recordIndicatorView.center = _collectionView.center;
        [self.view addSubview:_recordIndicatorView];
    }
    return _recordIndicatorView;
}

@end
