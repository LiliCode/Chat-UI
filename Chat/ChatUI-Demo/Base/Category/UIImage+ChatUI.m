//
//  UIImage+ChatUI.m
//  Chat
//
//  Created by 唯赢 on 2018/12/4.
//  Copyright © 2018 李立. All rights reserved.
//

#import "UIImage+ChatUI.h"

@implementation UIImage (ChatUI)

+ (nullable UIImage *)chat_imageNamed:(NSString *)name {
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"Chat.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (bundle == nil) {
        bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"Frameworks/Chat.framework/Chat.bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:nil]];
    }
}

@end
