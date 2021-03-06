//
//  ZKIFooInteractor.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/12/15.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIFooInteractor.h"

@implementation ZKIFooInteractor

- (RACSignal *)testRequest:(UIView<RequestStatusViewProtocol> *)view {
    
    ZKITestRequest *request = [ZKITestRequest createWithBuilder:^(ZKITestRequest *builder) {
        
        builder->_foo2 = @"";
        
    }];
    
    [view handleRequestStatus:[request.requestStatusSiganl filterRequestStatusShowActivity:YES showEmptyView:NO showErrorView:YES]];
    
    return request.rac_request;
    
}

@end
