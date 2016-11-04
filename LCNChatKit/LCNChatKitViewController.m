//
//  ViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNChatKitViewController.h"
#import "LCNMessageLayout.h"

@interface LCNChatKitViewController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching
>


//帧率显示器
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

//是否在拖动状态
@property (nonatomic, assign) BOOL isDragging;

@end

@implementation LCNChatKitViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.fpsLabel];
    
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewDidAppear:(BOOL)animated{
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
    
    NSLog(@"XXXXXXXXXXXX");
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    
    LCNCollectionViewCell *cell = nil;
    if (!layout.model.isOutgoing) {
        cell = (LCNCollectionViewIncomingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class]) forIndexPath:indexPath];
    }
    else{
        cell = (LCNCollectionViewOutgoingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class]) forIndexPath:indexPath];
    }
    
    //设置Cell布局
    [cell setLayout:layout];
    
    return cell;
}

//CollectionView Header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    LCNCollectionHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([LCNCollectionHeaderView class]) forIndexPath:indexPath];
    
    return nil;
}

-(NSArray<LCNMessageLayout *> *)collection:(UICollectionView *)collectionView loadMoreItemsCount:(NSInteger)count{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


#pragma mark - LCNCollectionViewDelegate

//CollectionViewCell被点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    
    //语音气泡的动画起停控制
    if([layout.model.mediaBubble isKindOfClass:[LCNAudioMediaBubble class]]){
        LCNAudioMediaBubble *item = (LCNAudioMediaBubble *)layout.model.mediaBubble;
        [item startAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [item stopAnimation];
        });
    }

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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < -20) {
        [UIView setAnimationsEnabled:NO];
        [self showCollectionViewHeader];
        [UIView setAnimationsEnabled:YES];
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [UIView setAnimationsEnabled:NO];

    CGPoint offset = _collectionView.contentOffset;

    NSArray *layouts = [self.collectionView.dataSource collection:self.collectionView loadMoreItemsCount:3];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:layouts.count];
    for (int i = 0; i < layouts.count; i++) {
        LCNMessageLayout *layout = [layouts objectAtIndex:i];
        offset.y += layout.cellHeight;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    [_collectionView performBatchUpdates:^{
        [_dataSource insertObjects:layouts atIndex:0];
        [_collectionView insertItemsAtIndexPaths:indexPaths];
    } completion:^(BOOL finished) {
        ;
    }];
    
    if ([self isShowCollectionViewHeader]) {
        offset.y -= 40;
        [self hideCollectionViewHeader];
    }
    
    [self.collectionView setContentOffset:offset animated:NO];
    
    [UIView setAnimationsEnabled:YES];
    

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isDragging = NO;
}


#pragma mark - Private Method
//隐藏CollectionViewHeader，隐藏加载更多消息视图
- (void)hideCollectionViewHeader{
    LCNCollectionViewFlowLayout *layout = (LCNCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeZero;
}

//显示CollectionViewHeader，显示加载更多消息视图
- (void)showCollectionViewHeader{
    LCNCollectionViewFlowLayout *layout = (LCNCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
}

- (BOOL)isShowCollectionViewHeader{
    LCNCollectionViewFlowLayout *layout = (LCNCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    return layout.headerReferenceSize.height > 0;
}


#pragma mark - Setter & Getter
//CollectionView
-(LCNCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[LCNCollectionView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20)
                                              collectionViewLayout:[UICollectionViewFlowLayout new]];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        
        [_collectionView registerClass:[LCNCollectionViewIncomingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class])];
        [_collectionView registerClass:[LCNCollectionViewOutgoingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class])];
        
        [_collectionView registerClass:[LCNCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([LCNCollectionHeaderView class])];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;


    }
    return _collectionView;
}

//CollectionView流式布局创建
-(LCNCollectionViewFlowLayout *)springCollectionViewLayout{
    if (!_springCollectionViewLayout) {
        _springCollectionViewLayout = [[LCNCollectionViewFlowLayout alloc] init];
        _springCollectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _springCollectionViewLayout.springEnable = NO;
        _springCollectionViewLayout.headerReferenceSize = CGSizeZero;
    }
    return _springCollectionViewLayout;
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

@end













