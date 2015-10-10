//
//  ZKINetworkManager.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKINetworkManager.h"

#define NetworkHostName @"www.baidu.com"

@interface ZKINetworkManager ()

@property (strong, nonatomic, readwrite) RACSubject *currentReachabilityStatusSignal;
@property (assign, nonatomic, readwrite) AFNetworkReachabilityStatus currentReachabilityStatus;

@end

@implementation ZKINetworkManager

+ (ZKINetworkManager *)shareManager {
    
    static dispatch_once_t once;
    
    static ZKINetworkManager *shareManager;
    
    dispatch_once(&once, ^{
        shareManager = [[ZKINetworkManager alloc] init];
    });
    
    return shareManager;
    
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
    }
    return self;
}

- (RACSignal *)rac_currentReachabilityStatus {
    
    @weakify(self)
    if (!self.currentReachabilityStatusSignal) {
        @strongify(self)
        
        self.currentReachabilityStatusSignal = [RACSubject subject];
        [self.currentReachabilityStatusSignal takeUntil:self.rac_willDeallocSignal];
        
        self.currentReachabilityStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:AFNetworkingReachabilityDidChangeNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *x) {
            @strongify(self)
            
            AFNetworkReachabilityStatus status = [x.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
            
            if (self.currentReachabilityStatus != status) {
                
                self.currentReachabilityStatus = status;
                
                [self.currentReachabilityStatusSignal sendNext:@(status)];
                
            }
            
        }];
        
    }
    
    return self.currentReachabilityStatusSignal;
    
}

- (void)start {
    
    [self rac_currentReachabilityStatus];
    
}

@end
