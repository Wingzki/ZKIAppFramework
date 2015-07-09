//
//  UIViewController+RequestStatusView.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+RequestStatusHandle.h"
#import "YTKRequest.h"

@protocol RequestStatusViewProtocol <NSObject>

@optional

- (void)showActivity:(BOOL)show;

- (void)showEmptyView:(BOOL)show;

- (void)showErrorView:(BOOL)show withRequest:(YTKRequest *)request;

@end

@interface UIViewController (RequestStatusView) <RequestStatusViewProtocol>

- (void)handleRequestStatusView:(RACSignal *)signal scrollView:(UIScrollView *)scrollView;

@end
