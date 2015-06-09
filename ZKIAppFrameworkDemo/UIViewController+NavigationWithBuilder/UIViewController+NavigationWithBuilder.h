//
//  UIViewController+NavigationWithBuilder.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Builder.h"

@interface UIViewController (NavigationWithBuilder)

+ (instancetype)pushBasedViewControll:(UIViewController *)baseViewController
                              builder:(void(^)(id <NSObjectBuilderProtocol> builder))block;

+ (instancetype)presentBasedViewControll:(UIViewController *)baseViewController
                                 builder:(void(^)(id <NSObjectBuilderProtocol> builder))block;


@end
