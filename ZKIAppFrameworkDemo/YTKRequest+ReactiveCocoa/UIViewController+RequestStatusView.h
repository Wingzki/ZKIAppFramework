//
//  UIViewController+RequestStatusView.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTKRequest+RecativeCocoa.h"

@protocol RequestStatusViewProtocol <NSObject>

@optional

- (void)showActivity:(BOOL)show;

- (void)showEmptyView:(BOOL)show;

- (void)showErrorView:(BOOL)show;

@end

@interface UIViewController (RequestStatusView)

- (void)handleRequestStatusView:(RACSignal *)signal scrollView:(UIScrollView *)scrollView;

@end
