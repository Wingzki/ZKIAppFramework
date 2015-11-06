//
//  ZKITestRequest.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKITestRequest.h"

@interface ZKITestRequest ()

@end

@implementation ZKITestRequest

- (void)dealloc
{
    NSLog(@"%@ Dealloc", [self class]);
}

- (instancetype)build {
    return self;
}

- (NSString *)baseUrl {
    
    return @"www.baidu.com";
    
}

- (NSString *)requestUrl {
    
    return @"/";
    
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)responseDataHandle:(id)value racSubject:(RACSubject *)subject {
    
    return value;
    
}

- (NSInteger)dataEmptyHandle:(id)value {
    
    return 0;
    
}

@end
