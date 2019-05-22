//
//  FYEmojiKeyBoardViewProtocol.h
//  FYEmojiKeyboard
//
//  Created by admin on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, FYPannelType) {
    FYPannelTypeNone = 0,  //不显示
    FYPannelTypeSystem,    //系统键盘
    FYPannelTypeEmoji      //Emoji面板
};

//面板
@protocol FYEmojiPanelView <NSObject>


@end

//输入框
@protocol FYEmojiInputView <NSObject>

//展示面板回调
@property (nonatomic, nullable, copy) UIView <FYEmojiPanelView>* _Nullable(^showPannelBlock)(FYPannelType pannelType);

- (void)transformFrom:(CGRect)fromRect toRect:(CGRect)toRect userInfo:(NSDictionary * _Nullable)userInfo;

@end

NS_ASSUME_NONNULL_END
