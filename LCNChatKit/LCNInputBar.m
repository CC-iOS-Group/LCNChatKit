//
//  LCNInputBar.m
//  LCNChatKit
//
//  Created by 黄春涛 on 2016/11/9.
//  Copyright © 2016年 enrecul. All rights reserved.
//

#import "LCNInputBar.h"
#import "LCNInputBarFaceView.h"
#import "LCNInputBarMoreView.h"
#import "LCNAudioManager.h"

#define kLCNInputBarButtonWH 30

typedef NS_ENUM(NSUInteger, INPUTBARBUTTON_TAG) {
    INPUTBARBUTTON_TAG_VOICE = 10000,
    INPUTBARBUTTON_TAG_EMOJI,
    INPUTBARBUTTON_TAG_MORE,
};

@interface LCNInputBar()<YYTextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UIButton *emojiButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) LCNInputBarFaceView *inputBarFaceView;
@property (nonatomic, strong) LCNInputBarMoreView *inputBarMoreView;

@property (nonatomic, strong) UIEvent *recordEvent;
@property (nonatomic, assign) BOOL recordPermissionGranted;//麦克风权限是否获取


@end

@implementation LCNInputBar{
    CFTimeInterval touchDownTime;
    dispatch_block_t block;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(kScreenWidth, kInputBarHeight);
        self.backgroundColor = [UIColor colorWithHexString:@"edf1f6"];
        
        _voiceButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.size = CGSizeMake(kLCNInputBarButtonWH, kLCNInputBarButtonWH);
            button.left = 5;
            button.top = 10;
            [button setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
            button.tag = INPUTBARBUTTON_TAG_VOICE;
            [button addTarget:self action:@selector(inputBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        
        _emojiButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.size = CGSizeMake(kLCNInputBarButtonWH, kLCNInputBarButtonWH);
            button.left = kScreenWidth - 5 - 10 - 2*kLCNInputBarButtonWH;
            button.top = 10;
            [button setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
            button.tag = INPUTBARBUTTON_TAG_EMOJI;
            [button addTarget:self action:@selector(inputBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        
        _moreButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.size = CGSizeMake(kLCNInputBarButtonWH, kLCNInputBarButtonWH);
            button.left = kScreenWidth - 5 - kLCNInputBarButtonWH;
            button.top = 10;
            [button setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"more"] forState:UIControlStateSelected];
            button.tag = INPUTBARBUTTON_TAG_MORE;
            [button addTarget:self action:@selector(inputBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        
        _textView = ({
            YYTextView *textView = [YYTextView new];
            YYTextLinePositionSimpleModifier *lineModeify = [YYTextLinePositionSimpleModifier new];
            lineModeify.fixedLineHeight = 20;
            textView.linePositionModifier = lineModeify;
            textView.returnKeyType = UIReturnKeySend;
            textView.enablesReturnKeyAutomatically = YES;
            textView.font = [UIFont systemFontOfSize:17];
            textView.backgroundColor = [UIColor whiteColor];
            textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            textView.size = CGSizeMake(kScreenWidth - 40 - 3 *kLCNInputBarButtonWH, 50 - 16);
            textView.top = 8;
            textView.left = kLCNInputBarButtonWH + 15;
            textView.layer.borderWidth = 0.5;
            textView.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
            textView.clipsToBounds = YES;
            textView.layer.cornerRadius = 5;
            textView.showsVerticalScrollIndicator = NO;
            textView.delegate = self;
            textView;
        });
        
        _recordButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"按住 说话" forState:UIControlStateNormal];
            [button setTitle:@"松开 结束" forState:UIControlStateHighlighted];
            [button setBackgroundColor:[UIColor colorWithHexString:@"edf1f6"]];
            [button setTitleColor:[UIColor colorWithHexString:@"7f8389"] forState:UIControlStateNormal];
            button.size = CGSizeMake(kScreenWidth - 40 - 3 *kLCNInputBarButtonWH, 50 - 16);
            button.top = 8;
            button.left = kLCNInputBarButtonWH + 15;
//            button.frame = _textView.frame;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
            button.clipsToBounds = YES;
            button.layer.cornerRadius = 5;
            button.hidden = YES;
            [button addTarget:self action:@selector(recordButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(recordButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(recordButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
            [button addTarget:self action:@selector(recordButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
            [button addTarget:self action:@selector(recordButtonTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
            [button addTarget:self action:@selector(recordButtonTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
            
            button;
        });
        
        [self addSubview:_voiceButton];
        [self addSubview:_emojiButton];
        [self addSubview:_moreButton];
        [self addSubview:_textView];
        [self addSubview:_recordButton];
        
    }
    return self;
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView{
    //监听换行
    CGFloat textViewHeight = textView.contentSize.height;
    
    //调整自身控件位置
    self.height = textViewHeight + 2*8;
    self.textView.height = textViewHeight;
    self.recordButton.height = self.textView.height;
    self.voiceButton.top = (self.height - kLCNInputBarButtonWH)/2;
    self.emojiButton.top =(self.height - kLCNInputBarButtonWH)/2;
    self.moreButton.top = (self.height - kLCNInputBarButtonWH)/2;
    
    
    
    //回调通知VC输入框高度发生变化
    if ([self.delegate respondsToSelector:@selector(LCNInpuBatHeightChanged:)]) {
        [self.delegate LCNInpuBatHeightChanged:self.height];
    }
    
}

#pragma mark - Target & Action
- (void)inputBarButtonClicked:(UIButton *)sender{
    sender.enabled = NO;
    
    //控制输入框几个按钮的显示与隐藏，同时切换键盘
    if (sender.isSelected == NO) {//点击选中某Button
        switch (sender.tag) {
            case INPUTBARBUTTON_TAG_VOICE:{
                [self.textView resignFirstResponder];
                break;}
            case INPUTBARBUTTON_TAG_EMOJI:{
                self.textView.inputView = self.inputBarFaceView;
                [self.textView reloadInputViews];
                [self textViewHideCursorAndBecomeFirstResponser];
                break;}
            case INPUTBARBUTTON_TAG_MORE:{
                self.textView.inputView = self.inputBarMoreView;
                [self.textView reloadInputViews];
                [self textViewHideCursorAndBecomeFirstResponser];
                break;}
            default:
                break;
        }
        [self setButtonSelected:sender.tag];

    }
    else{//点击取消选中某Button
        switch (sender.tag) {
            case INPUTBARBUTTON_TAG_VOICE:{
                self.textView.inputView = nil;
                [self.textView reloadInputViews];
                [self textViewShowCursorAndBecomeFirstResponser];
                break;}
            case INPUTBARBUTTON_TAG_EMOJI:{
                self.textView.inputView = nil;
                [self.textView reloadInputViews];
                [self textViewShowCursorAndBecomeFirstResponser];
                break;}
            case INPUTBARBUTTON_TAG_MORE:{
                self.textView.inputView = nil;
                [self.textView reloadInputViews];
                [self textViewShowCursorAndBecomeFirstResponser];
                break;}
            default:
                break;
        }
        [self resetAllButton];
    }
    
    sender.enabled = YES;
}

//YYTextView响应点击事件
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(_textView.frame, point)) {
        if (_recordButton.hidden == YES) {
            [self textViewTapped];
        }
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self.recordButton) {
        self.recordEvent = event;
    }
    
    return [super hitTest:point withEvent:event];
}

//点击了Textview，回复textView输入状态
- (void)textViewTapped{
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    [self resetAllButton];
    [self textViewShowCursorAndBecomeFirstResponser];
}

#pragma mark - RecordButton TouchAction

- (BOOL)recordButtonTouchEventEnded {
    UITouch *touch = [self.recordEvent.allTouches anyObject];
    if (touch == nil || touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
        return YES;
    }
    
    return NO;
}

- (void)recordActionEnd {
    self.recordEvent = nil;
}

- (void)recordButtonTouchDown:(UIButton *)sender{
    NSLog(@"%s",__func__);
    @weakify(self);

    self.recordPermissionGranted = NO;
    __block BOOL firstUseMicrophone = NO;
    
    [[LCNAudioManager sharedManager] requestRecordPermission:^(AVAudioSessionRecordPermission recordPermission) {
        if (recordPermission == AVAudioSessionRecordPermissionUndetermined) {
            firstUseMicrophone = YES;
        }
        else if (recordPermission == AVAudioSessionRecordPermissionGranted){
            //第一次录音时，会请求麦克风权限。
            //1、用户抬离手指后同意访问麦克风，这种情况不继续录音，因为用户已经离开录音按钮了
            //2、用户保持手指按压录音按钮，用其他手指同意访问麦克风，则从获取授权的时间点开始录音
            if (!firstUseMicrophone || ![weak_self recordButtonTouchEventEnded]) {
                weak_self.recordPermissionGranted = YES;
                @strongify(self);
                
                self->touchDownTime = CACurrentMediaTime();
                if ([weak_self.delegate respondsToSelector:@selector(voiceRecordingShouldStart)]) {
                    self->block = dispatch_block_create(0, ^{
                        [weak_self.delegate voiceRecordingShouldStart];
                    });
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), self->block);
                }
            }

        }
    }];
    
    
}

- (void)recordButtonTouchUpInside:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (!self.recordPermissionGranted)
        return;
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    if (currentTime - touchDownTime < MIN_RECORD_TIME_REQUIRED + 0.25) {
        self.recordButton.enabled = NO;
        self.textView.userInteractionEnabled = NO;
        if (!dispatch_block_testcancel(block))
            dispatch_block_cancel(block);
        block = nil;
        
        if ([self.delegate respondsToSelector:@selector(voiceRecordingTooShort)]) {
            [self.delegate voiceRecordingTooShort];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MIN_RECORD_TIME_REQUIRED * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.recordButton.enabled = YES;
            self.textView.userInteractionEnabled = YES;
            [self recordActionEnd];
        });
        
    }else {
        [self recordActionEnd];
        if ([self.delegate respondsToSelector:@selector(voicRecordingShouldFinish)]) {
            [self.delegate voicRecordingShouldFinish];
        }
    }
}

- (void)recordButtonTouchUpOutside:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (!self.recordPermissionGranted)
        return;
    
    [self recordActionEnd];
    
    if (!dispatch_block_testcancel(block))
        dispatch_block_cancel(block);
    block = nil;
    
    if ([self.delegate respondsToSelector:@selector(voiceRecordingShouldCancel)]) {
        [self.delegate voiceRecordingShouldCancel];
    }
}

- (void)recordButtonTouchCancel:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (!self.recordPermissionGranted)
        return;
    
    [self recordButtonTouchUpInside:sender];
}

- (void)recordButtonTouchDragEnter:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (!self.recordPermissionGranted)
        return;
    
    if ([self.delegate respondsToSelector:@selector(voiceRecordingDidDraginside)]) {
        [self.delegate voiceRecordingDidDraginside];
    }
}

- (void)recordButtonTouchDragExit:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (!self.recordPermissionGranted)
        return;
    
    if ([self.delegate respondsToSelector:@selector(voiceRecordingDidDragoutside)]) {
        [self.delegate voiceRecordingDidDragoutside];
    }
}

- (void)cancelRecordButtonTouchEvent {
    NSLog(@"%s",__func__);
    [self.recordButton cancelTrackingWithEvent:nil];
    [self recordActionEnd];
}

#pragma mark - Private Method
//点击表情及更多时，隐藏光标同时textview仍然是焦点
- (void)textViewHideCursorAndBecomeFirstResponser{
    [UIView setAnimationsEnabled:NO];
    
    self.textView.tintColor = [UIColor clearColor];
    if (![YYTextKeyboardManager defaultManager].isKeyboardVisible) {
        [self.textView becomeFirstResponder];
    }
    
    [UIView setAnimationsEnabled:YES];
}

- (void)textViewShowCursorAndBecomeFirstResponser{
    [UIView setAnimationsEnabled:NO];
    
    self.textView.tintColor = nil;
    if (![YYTextKeyboardManager defaultManager].isKeyboardVisible) {
        [self.textView becomeFirstResponder];
    }
    [UIView setAnimationsEnabled:YES];
}

//设置输入框内按钮的选中状态
- (void)setButtonSelected:(INPUTBARBUTTON_TAG)tag{
    switch (tag) {
        case INPUTBARBUTTON_TAG_VOICE:{
            _voiceButton.selected = YES;
            _recordButton.hidden = NO;
            _emojiButton.selected = NO;
            _moreButton.selected = NO;
            break;}
        case INPUTBARBUTTON_TAG_EMOJI:{
            _voiceButton.selected = NO;
            _recordButton.hidden = YES;
            _emojiButton.selected = YES;
            _moreButton.selected = NO;
            break;}
        case INPUTBARBUTTON_TAG_MORE:{
            _voiceButton.selected = NO;
            _recordButton.hidden = YES;
            _emojiButton.selected = NO;
            _moreButton.selected = YES;
            break;}
        default:
            break;
    }
    
    [_textView hideMenu];
}

//重置输入框内按钮的选中状态
- (void)resetAllButton{
    _voiceButton.selected = NO;
    _recordButton.hidden = YES;
    _emojiButton.selected = NO;
    _moreButton.selected = NO;
}

#pragma mark - Setter & Getter
-(LCNInputBarFaceView *)inputBarFaceView{
    if (!_inputBarFaceView) {
        _inputBarFaceView = [LCNInputBarFaceView new];
    }
    return _inputBarFaceView;
}

-(LCNInputBarMoreView *)inputBarMoreView{
    if (!_inputBarMoreView) {
        _inputBarMoreView = [LCNInputBarMoreView new];
    }
    return _inputBarMoreView;
}



@end
