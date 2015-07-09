//
//  ZKIRootViewController.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIRootViewController.h"
#import "ZKITestRequest.h"
#import "NSObject+RequestStatusHandle.h"
#import "UIViewController+RequestStatusView.h"

@interface ZKIRootViewController ()

@end

@implementation ZKIRootViewController

- (instancetype)build {
    
    NSAssert(self.titleText, @"text没有初始化");
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleText;
    
//    发起一个新的请求
    RACSignal *requestSignal = [ZKITestRequest rac_startRequestWithBuilder:^(id<NSObjectBuilderProtocol> builder) {
        
    }];
    
//    注册请求需要被处理的异常状态
    [self registerRequestSignal:requestSignal showErrorView:YES showActivity:YES emptyHandle:^NSInteger(id value) {
        
        return 0;
        
    }];
    
//    注册处理异常状态的对象
    [self handleRequestStatusView:self.requestStatusSiganl scrollView:nil];
    
//    处理请求返回的数据
    [self registerDataSignal:requestSignal class:[NSDictionary class] handle:^(NSDictionary *value) {
        
    }];
    
}

#pragma mark - RequestStatusViewProtocol

- (void)showActivity:(BOOL)show; {
    
    if (show) {
        
        NSLog(@"显示菊花");
        
    }else {
        
        NSLog(@"隐藏菊花");
        
    }
    
}

- (void)showEmptyView:(BOOL)show; {
    
    if (show) {
        
        NSLog(@"数据为空");
        
    }else {
        
        NSLog(@"数据不为空");
        
    }
    
}

- (void)showErrorView:(BOOL)show withRequest:(YTKRequest *)request; {
    
}

@end
