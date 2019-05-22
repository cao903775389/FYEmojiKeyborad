//
//  FYEmojiKeyBoardView.h
//  FYEmojiKeyboard
//
//  Created by admin on 2019/5/22.
//

#import <UIKit/UIKit.h>
#import "FYEmojiKeyBoardViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYEmojiKeyBoardView : UIView <FYEmojiInputView>

@property (nonatomic, nullable, copy) UIView <FYEmojiPanelView>* _Nullable(^showPannelBlock)(FYPannelType pannelType);

@property (nonatomic, nullable, readonly, strong) UITextView *textView;
@property (nonatomic, nullable, readonly, strong) UIButton *emojiButton;
@property (nonatomic, readonly, assign) FYPannelType keyboardType;

@end

NS_ASSUME_NONNULL_END
