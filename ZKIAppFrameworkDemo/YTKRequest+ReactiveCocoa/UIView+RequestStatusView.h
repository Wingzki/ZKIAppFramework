//
//  UIViewController+RequestStatusView.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKITestRequest.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

@protocol RequestStatusViewProtocol <NSObject>

@optional

- (void)showActivity:(BOOL)show;

- (void)showEmptyView:(BOOL)show;

- (void)showErrorView:(BOOL)show request:(ZKITestRequest *)request;

@end

@interface UIView (RequestStatusView) <RequestStatusViewProtocol>

- (void)handleRequestStatus:(RACSignal *)signal;

@end
