//
//  ZKIRootViewController.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIRootViewController.h"
#import "ZKIFooViewModel.h"
#import "UIViewController+RequestStatusView.h"

@interface ZKIRootViewController () <RequestStatusViewProtocol>

@property (strong, nonatomic) ZKIFooViewModel *viewModel;

@end

@implementation ZKIRootViewController

- (instancetype)build {
    
    NSAssert(self.titleText, @"text没有初始化");
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleText;
    
    self.viewModel = [ZKIFooViewModel createWithBuilder:^(id<NSObjectBuilderProtocol> builder) {
        
    }];
    
    [self handleRequestStatus:self.viewModel.requestStatusSiganl scrollView:nil];
    
    [self.viewModel getData];
    
    
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

- (void)showErrorView:(BOOL)show; {
    
    if (show) {
        
        NSLog(@"网络错误");
        
    }else {
        
        
    }
    
}

+ (void)load {
    
    if ([self conformsToProtocol:@protocol(RequestStatusViewProtocol)]) {
        
    }
    
}

@end
