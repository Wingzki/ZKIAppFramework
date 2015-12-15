//
//  ZKIFooInteractor.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/12/15.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIFooInteractor.h"

@implementation ZKIFooInteractor

- (instancetype)build {
    
    return self;
    
}

- (ZKITestRequest *)testRequest {
    
    return [ZKITestRequest createWithBuilder:^(ZKITestRequest *builder) {
        
        builder->_foo2 = @"";
        
    }];
    
}

@end
