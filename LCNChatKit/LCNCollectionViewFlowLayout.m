//
//  LCNCollectionViewLayout.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/9/22.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LCNCollectionViewFlowLayout.h"

@interface LCNCollectionViewFlowLayout()

// 动力行为的容器
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation LCNCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _springDumping = 0.5;
        _springFrequency = 0.8;
        _resistanceFactor = 500;
        
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    if (_springEnable == YES) {
        if (!_animator) {
            _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
            CGSize contentSize = [self collectionViewContentSize];
            NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
            
            for (UICollectionViewLayoutAttributes *item in items) {
                UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
                spring.length = 0;
                spring.damping = _springDumping;
                spring.frequency = _springFrequency;
                
                [_animator addBehavior:spring];
            }
        }
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    if (_springEnable == YES) {
        return [_animator itemsInRect:rect];
    }
    else{
        return [super layoutAttributesForElementsInRect:rect];
    }
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_springEnable == YES) {
        return [_animator layoutAttributesForCellAtIndexPath:indexPath];
    }
    else{
        return [super layoutAttributesForItemAtIndexPath:indexPath];
    }
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    if (_springEnable == YES) {
        UIScrollView *scrollView = self.collectionView;
        CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
        CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
        
        for (UIAttachmentBehavior *spring in _animator.behaviors) {
            CGPoint anchorPoint = spring.anchorPoint;
            CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
            CGFloat scrollResistance = distanceFromTouch / _resistanceFactor;
            
            UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[spring.items firstObject];
            CGPoint center = item.center;
            center.y += (scrollDelta > 0) ? MIN(scrollDelta,scrollDelta * scrollResistance)
            : MAX(scrollDelta, scrollDelta * scrollResistance);
            item.center = center;
            
            [_animator updateItemUsingCurrentState:item];
        }
        return NO;
    }
    else{
        return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    }
    
}

#pragma mark - Setter & Getter
-(void)setSpringDumping:(CGFloat)springDumping{
    if (_springDumping >= 0 && _springDumping != springDumping) {
        _springDumping = springDumping;
        for (UIAttachmentBehavior *spring in _animator.behaviors) {
            spring.damping = _springDumping;
        }
    }
}

-(void)setSpringFrequency:(CGFloat)springFrequency{
    if (_springFrequency >= 0 && _springFrequency != springFrequency) {
        _springFrequency = springFrequency;
        for (UIAttachmentBehavior *spring in _animator.behaviors) {
            spring.frequency = _springFrequency;
        }
    }
}

@end










