//
//  ZKIRootViewController.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIRootViewController.h"
#import "ZKITestRequest.h"

typedef NS_ENUM(NSUInteger, RequestStatus) {
    
    RequestStatusShowActivity,
    RequestStatusHideActivity,
    RequestStatusShowEmptyView
    
};

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
    
    [self registerSignal:requestSignal showErrorView:YES showActivity:YES emptyHandle:^NSInteger(NSDictionary *dataDic) {
        
        return 0;
        
    }];
    
}

- (void)registerSignal:(RACSignal *)signal
         showErrorView:(BOOL)isShowError
          showActivity:(BOOL)isShowActivity
           emptyHandle:(NSInteger (^)(NSDictionary *dataDic))block {
    
    if (isShowError) {
        
        [self registerDataErrorSignal:signal];
        
    }
    
    if (isShowActivity) {
        
        [self registerActivitySignal:signal];
        
    }
    
    if (block) {
        
        [self registerDataEmptySignal:signal handle:block];
    }
    
}

- (void)registerDataEmptySignal:(RACSignal *)signal handle:(NSInteger (^)(NSDictionary *dataDic))block {
    
    [[signal filter:^BOOL(id value) {
        
        return [value isKindOfClass:[NSDictionary class]];
        
    }] subscribeNext:^(id x) {
        
        NSInteger count = block(x);
        
        if (count == 0) {
            
        }
        
    }];

}

- (void)registerDataErrorSignal:(RACSignal *)signal {
    
    [signal subscribeError:^(NSError *error) {
        
    }];
    
}

- (void)registerActivitySignal:(RACSignal *)signal {
    
    [[signal filter:^BOOL(id value) {
        
        return [value isKindOfClass:[NSNumber class]];
        
    }] subscribeNext:^(id x) {
        
        
        
    }];
    
}

@end
