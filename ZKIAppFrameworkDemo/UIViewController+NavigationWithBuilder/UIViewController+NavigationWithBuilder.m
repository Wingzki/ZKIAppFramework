//
//  UIViewController+NavigationWithBuilder.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "UIViewController+NavigationWithBuilder.h"

@implementation UIViewController (NavigationWithBuilder)

+ (instancetype)pushBasedViewController:(UIViewController *)baseViewController
                                builder:(BuilderBlock)block {
    
    UIViewController *vc = [self createWithBuilder:block];
    
    [baseViewController.navigationController pushViewController:vc animated:YES];
    
    return vc;
    
}

+ (instancetype)presentBasedViewController:(UIViewController *)baseViewController
                                   builder:(BuilderBlock)block {
    
    UIViewController *vc = [self createWithBuilder:block];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [baseViewController presentViewController:nav animated:YES completion:nil];
    
    return vc;
    
}


@end
