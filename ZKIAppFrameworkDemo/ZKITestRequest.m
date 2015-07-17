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

- (instancetype)build {
    return self;
}

- (NSString *)baseUrl {
    
    return @"http://open.qyer.com/qyer/footprint/country_detail?track_device_info=iPhone%25205s&lon=116.4648492205655&track_deviceid=0DEBD997-84BA-41D5-86AC-215FC4940152&country_id=11&count=20&track_os=ios%25208.4&track_app_version=6.5&lat=39.90407779530003&track_app_channel=App%2520Store&client_id=qyer_ios&page=1&client_secret=cd254439208ab658ddf9&v=1";
    
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
