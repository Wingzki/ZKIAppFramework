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

@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) RACSubject   *currentReachabilityStatusSignal;

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
        
        _reachability = [Reachability reachabilityWithHostName:NetworkHostName];
        
    }
    return self;
}

- (RACSubject *)start {
    
    @weakify(self)
    if (!self.currentReachabilityStatusSignal) {
        @strongify(self)
        
        self.currentReachabilityStatusSignal = [RACSubject subject];
        [self.currentReachabilityStatusSignal takeUntil:self.rac_willDeallocSignal];
        
        self.reachability.reachableBlock = ^(Reachability *reach) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               @strongify(self)
                
                _currentReachabilityStatus = reach.currentReachabilityStatus;
                
                [self.currentReachabilityStatusSignal sendNext:@(reach.currentReachabilityStatus)];
                
            });
            
        };
        
        self.reachability.unreachableBlock = ^(Reachability *reach) {
            @strongify(self)
            
            _currentReachabilityStatus = reach.currentReachabilityStatus;
            
            [self.currentReachabilityStatusSignal sendNext:@(reach.currentReachabilityStatus)];
            
        };
        
        [self.reachability startNotifier];
        
    }
    
    return self.currentReachabilityStatusSignal;
    
}

- (void)stop {
    
    [self.reachability stopNotifier];
    
    [self.currentReachabilityStatusSignal sendCompleted];
    
}

@end
