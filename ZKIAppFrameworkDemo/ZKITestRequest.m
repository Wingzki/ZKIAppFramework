//
//  ZKITestRequest.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKITestRequest.h"

@implementation ZKITestRequest

- (void)dealloc
{
    NSLog(@"%@ Dealloc", [self class]);
}

- (NSString *)baseUrl {
    
    return @"http://www.baidu.com";
    
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

@end
