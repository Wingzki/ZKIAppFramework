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

@implementation ZKIRootViewController

- (instancetype)build {
    
    NSAssert(self.titleText, @"text没有初始化");
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleText;
    
    RACSignal *requestSignal = [ZKITestRequest rac_startRequestWithBuilder:^(id<NSObjectBuilderProtocol> builder) {
        
    }];
    
    [self registerRequestSignal:requestSignal showErrorView:YES showActivity:YES emptyHandle:^NSInteger(id value) {
        
        return 0;
        
    }];
    
    [self registerDataErrorSignal:requestSignal class:[NSDictionary class] handle:^(NSDictionary *value) {
        
    }];
    
    
}

@end
