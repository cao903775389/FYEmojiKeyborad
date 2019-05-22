#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FYEmojiKeyBoardManager.h"
#import "FYEmojiKeyBoardView.h"
#import "FYEmojiKeyBoardViewProtocol.h"
#import "FYEmojiPageView.h"
#import "FYEmojiTextView.h"

FOUNDATION_EXPORT double FYEmojiKeyboardVersionNumber;
FOUNDATION_EXPORT const unsigned char FYEmojiKeyboardVersionString[];

