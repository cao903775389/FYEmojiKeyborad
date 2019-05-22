//
//  FYEmojiKeyBoardManager.h
//  FYEmojiKeyboard
//
//  Created by admin on 2019/5/22.
//

#import <Foundation/Foundation.h>
#import "FYEmojiKeyBoardViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYEmojiKeyBoardManager : NSObject

@property (nonatomic, nullable, readonly, strong) UIView <FYEmojiPanelView> *pannel;
@property (nonatomic, nullable, readonly, weak) UIView <FYEmojiInputView> *inputView;

- (instancetype)initWithInputView:(UIView <FYEmojiInputView> *)inputView
                           pannel:(UIView <FYEmojiPanelView> *)pannel
                    containerView:(UIView *)containerView NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (void)prepare;

@end

NS_ASSUME_NONNULL_END
