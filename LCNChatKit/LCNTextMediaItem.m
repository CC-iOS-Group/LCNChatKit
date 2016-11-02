//
//  LCNTextMediaItem.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/10/21.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNTextMediaItem.h"
#import "LCNMsgContentHelper.h"
#import "LCNMsgBubbleMaskMaker.h"
#import "LCNCollectionViewCell.h"

@interface LCNTextMediaItem()

@property (nonatomic, strong) UIImageView *cachedTextMediaView;

@end

@implementation LCNTextMediaItem

- (instancetype)initWithContent:(NSString *)content
{
    self = [super init];
    if (self) {
        _content = content;
        [self _layout:content];
    }
    return self;
}

#pragma mark - LCNMediaItemProtocol
- (UIView *)mediaView{
    
    if (!_cachedTextMediaView) {
    
        UIImageView *bubbleView = [UIImageView new];
        bubbleView.size = CGSizeMake(5+kCellMiddleGap+_layout.textBoundingRect.size.width+kCellMiddleGap, 2*kCellMiddleGap+_layout.textBoundingRect.size.height);
        bubbleView.contentMode = UIViewContentModeScaleToFill;
        UIImage *bubbleImage = [LCNMsgBubbleMaskMaker bubbleImageIsOutgoing:self.isOutgoing];
        [bubbleView setImage:bubbleImage];
        
        YYLabel *textLabel = ({
            YYLabel *label = [YYLabel new];
            label.displaysAsynchronously = YES;
            label.ignoreCommonProperties = NO;
            label.fadeOnAsynchronouslyDisplay = YES;
            label.fadeOnHighlight = YES;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            label.size = _layout.textBoundingRect.size;
            label.textLayout = _layout;//设置文本
            label.font = [UIFont systemFontOfSize:18.0f];
            label;
        });
        [bubbleView addSubview:textLabel];
        
        if (!self.isOutgoing) {
            //左气泡
            textLabel.top = kCellMiddleGap;
            textLabel.left = 5+kCellMiddleGap;
        }
        else{
            //右气泡
            textLabel.top = kCellMiddleGap;
            textLabel.left = kCellMiddleGap;
        }
        
        _cachedTextMediaView = bubbleView;
        return _cachedTextMediaView;
        
    }
    
    return _cachedTextMediaView;
}

- (CGSize)mediaViewDisplaySize{
    return CGSizeMake(5+kCellMiddleGap+_layout.textBoundingRect.size.width+kCellMiddleGap, 2*kCellMiddleGap+_layout.textBoundingRect.size.height);
}

#pragma mark - Private Method

/**
 计算所需的TextLayout，并对文本进行处理

 @param content 文本内容
 */
- (void)_layout:(NSString *)content{
    
    CGFloat fontSize = 18.0f;
    UIColor *fontColor = [UIColor blackColor];
    
    //对文本进行处理、链接处理、高亮处理、表情处理等。
    NSMutableAttributedString *attrText = [self _attrStrWithContent:content fontSize:fontSize fontColor:fontColor];
    if (attrText.length == 0) return;
    
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kMediaContainerrView_Max_W, MAXFLOAT);
//    YYTextLinePositionSimpleModifier *lineModifier = [YYTextLinePositionSimpleModifier new];
//    self.container.linePositionModifier = lineModifier;
    container.maximumNumberOfRows  = 10;
    
    self.layout = [YYTextLayout layoutWithContainer:container text:attrText];
    
}


/**
 对文本进行处理，链接转换、@用户名、表情替换等

 @param content   文本内容
 @param fontSize  字体大小
 @param fontColor 文本颜色

 @return 处理过后的AttributeString
 */
- (NSMutableAttributedString *)_attrStrWithContent:(NSString *)content
                                          fontSize:(CGFloat)fontSize
                                         fontColor:(UIColor *)fontColor{
    if (!content) return nil;
    
    NSMutableString *string = content.mutableCopy;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    //文字高亮背景设置
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = UIColorHex(bfdffe);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = fontColor;
    
    // 匹配 @用户名
    NSArray *atResults = [[LCNMsgContentHelper regexAt] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1) continue;
        if ([text attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [text setColor:UIColorHex(527ead) range:at.range];
            
            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{};
            [text setTextHighlight:highlight range:at.range];
        }
    }
    
    // 匹配 [表情]
    NSArray<NSTextCheckingResult *> *emoticonResults = [[LCNMsgContentHelper regexEmoticon] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([text attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        //Todo:[哈哈] -> emoji
        UIImage *image = nil;//替换的表情图片
        if (!image) continue;
        
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:fontSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    // 匹配链接 TODO：
    
    return text;
}

@end
