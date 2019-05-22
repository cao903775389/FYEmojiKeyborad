//
//  FYEmojiKeyBoardView.m
//  FYEmojiKeyboard
//
//  Created by admin on 2019/5/22.
//

#import "FYEmojiKeyBoardView.h"
#import <Masonry/Masonry.h>

@interface FYEmojiKeyBoardView () <UITextViewDelegate>

@property (nonatomic, nullable, strong) UITextView *textView;
@property (nonatomic, nullable, strong) UIButton *emojiButton;
@property (nonatomic, nullable, strong) UIButton *inputButton;
@property (nonatomic, assign) FYPannelType keyboardType;
@property (nonatomic, nullable, strong) UIView *bottomView;

@end

@implementation FYEmojiKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self commonInit];
    return self;
}

- (BOOL)isFirstResponder {
    return [self.textView isFirstResponder];
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [self changeKeyboardTo:FYPannelTypeNone];
    [self setNeedsLayout];
    return [self.textView resignFirstResponder];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.textView isFirstResponder]) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (!CGRectContainsPoint(self.bounds, touchPoint)) {
        if ([self isFirstResponder]) {
            [self resignFirstResponder];
        }
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)commonInit {
    self.keyboardType = FYPannelTypeNone;
    [self addSubview:self.textView];
    [self addSubview:self.emojiButton];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).inset(10);
        make.right.mas_equalTo(self.emojiButton.mas_left).offset(-10);
    }];
    
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - FYEmojiInputView
- (void)transformFrom:(CGRect)fromRect toRect:(CGRect)toRect userInfo:(NSDictionary *)userInfo {
    
    UIViewAnimationCurve curve = UIViewAnimationCurveEaseInOut;
    NSTimeInterval duration = 0.25;
    if (userInfo) {
        if (userInfo[UIKeyboardAnimationDurationUserInfoKey]) {
            duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        }
        if (userInfo[UIKeyboardAnimationCurveUserInfoKey]) {
            curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        }
    }
    
    [UIView animateWithDuration:duration delay:0.f options:(int)curve animations:^{
        self.frame = toRect;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - event response
- (void)toggleKeyboardDidClick:(UIButton *)sender {
    switch (self.keyboardType) {
        case FYPannelTypeNone:
            [self changeKeyboardTo:FYPannelTypeEmoji];
            [self.textView becomeFirstResponder];
            break;
        case FYPannelTypeSystem:
            [self changeKeyboardTo:FYPannelTypeEmoji];
            break;
        case FYPannelTypeEmoji:
            [self changeKeyboardTo:FYPannelTypeSystem];
            break;
        default:
            break;
    }
}

- (void)changeKeyboardTo:(FYPannelType)type {
    if (self.keyboardType == type) {
        return;
    }
    switch (type) {
        case FYPannelTypeNone:
            self.emojiButton.selected = NO;
            self.textView.inputView = nil;
            break;
        case FYPannelTypeSystem:
            self.emojiButton.selected = NO;
            self.textView.inputView = nil;
            [self.textView reloadInputViews];
            break;
        case FYPannelTypeEmoji:
            self.emojiButton.selected = YES;
            self.textView.inputView = self.showPannelBlock(FYPannelTypeEmoji);
            [self.textView reloadInputViews];
            break;
        default:
            break;
    }
    self.keyboardType = type;
}

#pragma mark - lazy load
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor redColor];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor blackColor];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton *)emojiButton {
    if (!_emojiButton) {
        _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiButton addTarget:self action:@selector(toggleKeyboardDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
