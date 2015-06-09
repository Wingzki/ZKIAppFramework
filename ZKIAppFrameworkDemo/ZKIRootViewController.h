//
//  ZKIRootViewController.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavigationWithBuilder.h"

@interface ZKIRootViewController : UIViewController <NSObjectBuilderProtocol>

@property (strong, nonatomic) NSString *titleText;

@end
