//
//  FYEmojiKeyBoardManager.m
//  FYEmojiKeyboard
//
//  Created by admin on 2019/5/22.
//

#import "FYEmojiKeyBoardManager.h"
#import <Masonry/Masonry.h>

@interface FYEmojiKeyBoardManager ()

@property (nonatomic, nullable, strong) UIView <FYEmojiPanelView> *pannel;
@property (nonatomic, nullable, weak) UIView <FYEmojiInputView> *inputView;
@property (nonatomic, nullable, weak) UIView *containerView;

@end

@implementation FYEmojiKeyBoardManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithInputView:(UIView <FYEmojiInputView> *)inputView
                           pannel:(UIView <FYEmojiPanelView> *)pannel
                    containerView:(UIView *)containerView {
    self = [super init];
    self.inputView = inputView;
    self.pannel = pannel;
    self.containerView = containerView;
    [self prepare];
    return self;
}

- (void)prepare {
    if (!_containerView) {
        return;
    }
//    [self.containerView addSubview:self.pannel];
//    CGFloat pannelHeight = self.pannel.frame.size.height;
//    CGFloat pannelOffset = 34;
//    [self.pannel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.containerView);
//        make.bottom.equalTo(self.containerView.mas_bottom).inset(pannelOffset);
//        make.height.mas_equalTo(pannelHeight);
//    }];
    
    [self.containerView addSubview:self.inputView];
    CGFloat inputHeight = self.inputView.frame.size.height;
    CGFloat inputOffset = 34;
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView.mas_bottom).inset(inputOffset);
        make.height.mas_equalTo(inputHeight);
    }];
    
    __weak typeof(self)weakSelf = self;
    self.inputView.showPannelBlock = ^UIView<FYEmojiPanelView> * _Nullable(FYPannelType pannelType) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        UIView<FYEmojiPanelView> *pannel = nil;
        switch (pannelType) {
            case FYPannelTypeEmoji:
                pannel = strongSelf.pannel;
                break;
            default:
                break;
        }
        return pannel;
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (!self.containerView) {
        return;
    }
    
    //    if (!self.bottomBGView.superview) {
    //        [self.superview insertSubview:self.bottomBGView belowSubview:self];
    //    }
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect convertFrame = [self.containerView convertRect:keyboardFrame fromView:nil];

    CGRect toFrame = self.inputView.frame;
    CGFloat inputViewHeight = self.inputView.frame.size.height;
    
    toFrame.origin.y = CGRectGetHeight(self.containerView.bounds) - CGRectGetHeight(convertFrame) - inputViewHeight;
    
    [self.inputView transformFrom:self.inputView.frame toRect:toFrame userInfo:userInfo];
    
//    [self.inputView keyboardWillShow:userInfo];
    
//    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect inputViewFrame = self.frame;
//    CGFloat textViewHeight = self.frame.size.height;
//    inputViewFrame.origin.y = CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(keyboardFrame) - self.frame.size.height;
//    inputViewFrame.size.height = textViewHeight;
    
    //    [UIView anim]
    
//    [UIView animateWithDuration:duration animations:^{
//        self.frame = inputViewFrame;
//    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (!self.containerView) {
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect toFrame = self.inputView.frame;
    CGFloat inputViewHeight = self.inputView.frame.size.height;
    
    toFrame.origin.y = CGRectGetHeight(self.containerView.bounds) - inputViewHeight;
    
    [self.inputView transformFrom:self.inputView.frame toRect:toFrame userInfo:userInfo];
}

@end
