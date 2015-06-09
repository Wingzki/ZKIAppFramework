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
    
    return @"http://open.qyer.com";
    
}

- (NSString *)requestUrl {
    
    return @"/qyer/recommands/entry?track_device_info=iPhone%25205s&lon=116.4646963477692&track_deviceid=0DEBD997-84BA-41D5-86AC-215FC4940152&track_user_id=5140531&count=20&track_os=ios%25208.3&track_app_version=6.4&lat=39.90432121602964&track_app_channel=App%2520Store&oauth_token=9137071f026ef90dd7c22edba095d7cb&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&page=1&v=1";
    
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

@end
