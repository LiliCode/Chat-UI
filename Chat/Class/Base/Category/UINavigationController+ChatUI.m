//
//  UINavigationController+ChatUI.m
//  Chat
//
//  Created by 唯赢 on 2018/8/3.
//  Copyright © 2018年 李立. All rights reserved.
//

#import "UINavigationController+ChatUI.h"
#import <objc/runtime.h>

@implementation UINavigationController (ChatUI)

+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(chatUI_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)chatUI_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) {
        return;
    }
    
    viewController.hidesBottomBarWhenPushed = YES;
    [self chatUI_pushViewController:viewController animated:YES];
}

@end
