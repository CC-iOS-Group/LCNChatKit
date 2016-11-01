//
//  ViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/18.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNChatKitViewController.h"
#import "LCNChatKit.h"
#import "LCNMessageLayout.h"

@interface LCNChatKitViewController ()<LCNCollectionViewDataSource,LCNCollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) LCNCollectionView *collectionView;
@property (nonatomic, strong) LCNCollectionViewFlowLayout *springCollectionViewLayout;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LCNChatKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.fpsLabel];
    
    [self makeFakeData];
}

- (void)makeFakeData{
    _dataSource = [NSMutableArray array];
    
    //测试数据制作
    
    int count = 10000;
    for (int i = 0; i < count ; i ++) {
        LCNMessageModel *model = [LCNMessageModel new];
        model.isOutgoing = NO; //arc4random()%2;
        model.messageID = @"messageID";
        model.senderID = @"15158114486";
        model.senderDisplayName = @"XXXX";
        model.senderAvatarImageUrl = @"https://img3.doubanio.com/icon/ul21552107-31.jpg";
        model.receiveID = @"18867103612";
        model.receiveDisplayName = @"yyyy";
        model.date = [NSDate date];
        LCNMediaType type = arc4random()%2;
        model.mediaType = type;
        switch (type) {
            case LCNMediaType_Text:{
                LCNTextMediaItem *textMediaItem = [[LCNTextMediaItem alloc] initWithContent:@"123131231231231sdfas fasdf asdf a a dfa fa  dfsdfafasdfasdfaf"];
                textMediaItem.isOutgoing = model.isOutgoing;
                model.mediaItem = textMediaItem;
                break;
            }
            case LCNMediaType_Image:{
                LCNImageMediaItem *imageMediaItem = [[LCNImageMediaItem alloc] initWithImage:[UIImage imageNamed:@"test.jpg"] width:200 height:100];
                imageMediaItem.isOutgoing = model.isOutgoing;
                model.mediaItem = imageMediaItem;
                break;
            }
            default:
                break;
        }
        
        
        LCNMessageLayout *layout = [[LCNMessageLayout alloc] initWithLCNMessageModel:model];
        [_dataSource addObject:layout];
        
    }
    
    [self.collectionView reloadData];
    
}


#pragma mark - LCNCollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    
    LCNCollectionViewCell *cell = nil;
    if (!layout.model.isOutgoing) {
        cell = (LCNCollectionViewIncomingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class]) forIndexPath:indexPath];
    }
    else{
        cell = (LCNCollectionViewOutgoingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class]) forIndexPath:indexPath];
    }
    
    [cell setLayout:layout];
    
    return cell;
}

#pragma mark - LCNCollectionViewDelegate



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LCNMessageLayout *layout = [_dataSource objectAtIndex:indexPath.row];
    CGFloat cellHeight = layout.cellHeight;
    
    return CGSizeMake(kScreenWidth, cellHeight);
}


#pragma mark - Setter & Getter

-(LCNCollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[LCNCollectionView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)
                                              collectionViewLayout:self.springCollectionViewLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LCNCollectionViewIncomingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewIncomingCell class])];
        [_collectionView registerClass:[LCNCollectionViewOutgoingCell class]
            forCellWithReuseIdentifier:NSStringFromClass([LCNCollectionViewOutgoingCell class])];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;

    }
    return _collectionView;
}

-(LCNCollectionViewFlowLayout *)springCollectionViewLayout{
    if (!_springCollectionViewLayout) {
        _springCollectionViewLayout = [[LCNCollectionViewFlowLayout alloc] init];
        _springCollectionViewLayout.springEnable = NO;
    }
    return _springCollectionViewLayout;
}

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













