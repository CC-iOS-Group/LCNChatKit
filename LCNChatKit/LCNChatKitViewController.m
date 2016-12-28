//
//  ViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNChatKitViewController.h"
#import "LCNMessageLayout.h"

//Third Part
#import "SVPullToRefresh.h"

@interface LCNChatKitViewController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching
>

//帧率显示器
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

//输入框
@property (nonatomic, strong) LCNInputBar *inputbar;

@end

@implementation LCNChatKitViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.fpsLabel];
    [self.view addSubview:self.inputbar];
    
    //增加上滑加载
    @weakify(self);
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weak_self loadMoreMessage:3];
    } forPosition:SVInfiniteScrollingPositionTop];
    
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    
    //自动调整CollectionView的WrapperView
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)viewDidAppear:(BOOL)animated{
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
    return _dataSource.count;
}

//cellForItem
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    
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
    
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    
    //表情气泡即将展示时，开启动画
    if (layout.model.mediaType == LCNMediaType_Emoji) {
        LCNEmojiMedaiBubble *emojiBubble = (LCNEmojiMedaiBubble*)layout.model.mediaBubble;
        [emojiBubble.imageView startAnimating];
    }
    
}

//CollectionViewCell 离开展示区
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //表情气泡离开展示区时，关闭动画
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    if (layout.model.mediaType == LCNMediaType_Emoji) {
        LCNEmojiMedaiBubble *emojiBubble = (LCNEmojiMedaiBubble*)layout.model.mediaBubble;
        [emojiBubble.imageView stopAnimating];
    }
}

#pragma mark - LCNCollectionViewCellDelegate
- (void)cellDidClickAvatar:(LCNCollectionViewCell *)cell{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);

}

- (void)cellDidClickNameLabel:(LCNCollectionViewCell *)cell{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);

}

- (void)cellDidClickBubbleView:(LCNCollectionViewCell *)cell{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);

}

- (void)cellDidLongPressBubbleView:(LCNCollectionViewCell *)cell{
    [self handleLongPressBubbleView:cell];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//CollectionViewCell高度设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    CGFloat cellHeight = layout.cellHeight;
    
    return CGSizeMake(kScreenWidth, cellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - ScrollViewDelegate


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
    [_collectionView scrollToBottomAnimated:YES];
}


#pragma mark - Private Method

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

- (void)loadMoreMessage:(int)count{
    
    [UIView setAnimationsEnabled:NO];
    
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
            [_dataSource insertObjects:layouts atIndex:0];
            [_collectionView insertItemsAtIndexPaths:indexPaths];
        } completion:^(BOOL finished) {
            ;
        }];
    }
    
    [[_collectionView infiniteScrollingViewForPosition:SVInfiniteScrollingPositionTop] stopAnimating];
    
    _collectionView.contentOffset = offset;
    
    [UIView setAnimationsEnabled:YES];
    
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
//CollectionView
-(LCNCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[LCNCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kInputBarHeight)
                                              collectionViewLayout:[UICollectionViewFlowLayout new]];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        
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

@end













