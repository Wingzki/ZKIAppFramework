//
//  ZKIAllocedObjectManager.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZKIAllocedObjectModel.h"

@interface ZKIAllocedObjectManager : NSObject

@property (strong, nonatomic, readonly) NSArray  *allocedObjectArray;
@property (strong, nonatomic, readonly) UIButton *mainButton;
@property (strong, nonatomic, readonly) NSString *nowVCName;

+ (instancetype)shareManager;

- (void)moveMainButtonToFront;

- (void)addAllocedObject:(UIViewController *)viewController;
- (void)markAllocedObjectDealloc:(UIViewController *)viewController;

@end
