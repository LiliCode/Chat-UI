//
//  ViewController.m
//  Chat
//
//  Created by 李立 on 2017/9/30.
//  Copyright © 2017年 李立. All rights reserved.
//

#import "ViewController.h"
#import "ConversationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)chat:(UIButton *)sender
{
    ConversationViewController *chat = [[ConversationViewController alloc] init];
    
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
