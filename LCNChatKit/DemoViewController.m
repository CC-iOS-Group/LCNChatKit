//
//  DemoViewController.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/3.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()<LCNCollectionViewCellDelegate>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [self makeFakeDataWithCount:10];
    [self.collectionView reloadData];
}

#pragma mark - LCNCollectionViewDataSource
//加载更多数据源
- (NSArray<LCNMessageLayout *> *)collection:(UICollectionView *)collectionView loadMoreItemsCount:(NSInteger)count{
    NSArray *array = [self makeFakeDataWithCount:count];
    return array;
}

#pragma mark - LCNCollectionViewCellDelegate
//- (void)cellDidClickAvatarImageView:(LCNCollectionViewCell *)cell{
//    
//}
//
//- (void)cellDidClickNameLabel:(LCNCollectionViewCell *)cell{
//    
//}
//
//- (void)cellDidClickBubbleView:(LCNCollectionViewCell *)cell{
//    
//}

#pragma mark - 假数据制作
- (NSMutableArray *)makeFakeDataWithCount:(NSInteger)count{
    NSMutableArray *array = [NSMutableArray array];
    
    //测试数据制作
    
    for (int i = 0; i < count ; i ++) {
        LCNMessageModel *model = [LCNMessageModel new];
        model.isOutgoing = arc4random()%2;
        model.messageID = @"messageID";
        model.senderID = @"15158114486";
        model.senderDisplayName = @"XXXX";
        model.senderAvatarImageUrl = @"https://img3.doubanio.com/icon/ul21552107-31.jpg";
        model.receiveID = @"18867103612";
        model.receiveDisplayName = @"yyyy";
        model.date = [NSDate date];
        LCNMediaType type = arc4random()%4;
        model.mediaType = type;
        switch (type) {
            case LCNMediaType_Text:{
                LCNTextMediaBubble *textMediaItem = [[LCNTextMediaBubble alloc] initWithContent:@"123131231231231sdfas fasdf asdf a a dfa fa  dfsdfafasdfasdfaf"];
                textMediaItem.isOutgoing = model.isOutgoing;
                model.mediaBubble = textMediaItem;
                break;
            }
            case LCNMediaType_Image:{
                LCNImageMediaBubble *imageMediaItem = [[LCNImageMediaBubble alloc] initWithImage:[UIImage imageNamed:@"test.jpg"] width:200 height:100];
                imageMediaItem.isOutgoing = model.isOutgoing;
                model.mediaBubble = imageMediaItem;
                break;
            }
            case LCNMediaType_Emoji:{
                //                YYImage *image = [YYImage imageNamed:@"dots22"];
                //                LCNEmojiMedaiBubble *emojiItem = [[LCNEmojiMedaiBubble alloc]initWithEmojiImage:[YYImage imageNamed:@"dots22"] size:CGSizeMake(200, 100)];
                
                NSArray *links = @[
                                   // animated gif: https://dribbble.com/markpear
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                                   
                                   // animaged gif: https://dribbble.com/jonadinges
                                   @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                                   @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                                   ];
                
                NSString *url = links[(arc4random()%links.count)];
                LCNEmojiMedaiBubble *emojiItem = [[LCNEmojiMedaiBubble alloc] initWithEmojiImageUrl:url size:CGSizeMake(100, 100)];
                
                emojiItem.isOutgoing = model.isOutgoing;
                model.mediaBubble = emojiItem;
                break;
            }
                //            case LCNMediaType_Emoji:
            case LCNMediaType_Audio:{
                LCNAudioMediaBubble *audioItem = [[LCNAudioMediaBubble alloc] initWithNSData:nil duration:100*1000];
                audioItem.isOutgoing = model.isOutgoing;
                model.mediaBubble = audioItem;
                break;
            }
            default:
                break;
        }
        
        
        LCNMessageLayout *layout = [[LCNMessageLayout alloc] initWithLCNMessageModel:model];
        [array addObject:layout];
        
    }
    
    return array;
}

@end
