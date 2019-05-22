//
//  FYViewController.m
//  FYEmojiKeyboard
//
//  Created by fengyangcao on 05/22/2019.
//  Copyright (c) 2019 fengyangcao. All rights reserved.
//

#import "FYViewController.h"
#import <FYEmojiKeyboard/FYEmojiKeyBoardManager.h>
#import <FYEmojiKeyboard/FYEmojiPageView.h>
#import <FYEmojiKeyboard/FYEmojiKeyBoardView.h>

#import <Masonry/Masonry.h>

@interface FYViewController ()

@property (nonatomic, strong) FYEmojiKeyBoardManager *keyboardManager;

@end

@implementation FYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FYEmojiKeyBoardView *keyboardView = [[FYEmojiKeyBoardView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [keyboardView.emojiButton setImage:[UIImage imageNamed:@"icon_emoji"] forState:UIControlStateNormal];
    [keyboardView.emojiButton setImage:[UIImage imageNamed:@"icon_emoji_keyboard"] forState:UIControlStateSelected];
    keyboardView.backgroundColor = [UIColor blackColor];
    
    FYEmojiPageView *pageView = [[FYEmojiPageView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    pageView.backgroundColor = [UIColor greenColor];
    
    self.keyboardManager = [[FYEmojiKeyBoardManager alloc] initWithInputView:keyboardView pannel:pageView containerView:self.view];
    
    
//    [self.view addSubview:self.keyboardView];
//    [self.keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-34);
//        make.height.mas_equalTo(50);
//    }];
//
	// Do any additional setup after loading the view, typically from a nib.
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}


@end
