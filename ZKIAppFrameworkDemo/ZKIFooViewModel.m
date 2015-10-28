//
//  ZKIFooViewModel.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/21.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIFooViewModel.h"
#import <objc/runtime.h>

@implementation ZKIFooViewModel

- (instancetype)build {
    
    return self;
    
}

- (void)getData {
    
    [self.delegate changeStatusWithDataStatus:ZKIDataStatusNull viewStatus:ZKIViewStatusLoading];
    
    ZKITestRequest *testRequest = [ZKITestRequest createWithBuilder:^(ZKITestRequest *builder) {
        
    }];
    
    [[testRequest.rac_request connectRequestSignalWith:self.requestStatusSiganl
                                        isShowActivity:YES
                                       isShowErrorView:YES
                                       isShowEmptyView:YES]
     subscribeResponseWithClass:[NSDictionary class] success:^(id value) {
         
         [self.delegate changeStatusWithDataStatus:ZKIDataStatusA viewStatus:ZKIViewStatusNothing];
         
     } error:^(NSError *error) {
         
         [self.delegate changeStatusWithDataStatus:ZKIDataStatusNull viewStatus:ZKIViewStatusNetworkError];
         
     }];
    
}

@end
