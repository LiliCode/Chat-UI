//
//  PluginItem.m
//  Chat
//
//  Created by 李立 on 2017/10/24.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "PluginItem.h"

@implementation PluginItem

+ (instancetype)pluginItemWithTitle:(NSString *)title image:(NSString *)image callback:(PluginItemCallback)callback
{
    return [[self alloc] initWithTitle:title image:image callback:callback];
}

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image callback:(PluginItemCallback)callback
{
    if (self = [super init])
    {
        self.title = title;
        self.image = image;
        self.callback = callback;
    }
    
    return self;
}

@end
