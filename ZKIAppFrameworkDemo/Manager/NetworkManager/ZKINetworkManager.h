//
//  ZKINetworkManager.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"
#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

@interface ZKINetworkManager : NSObject

@property (assign, nonatomic, readonly) NetworkStatus currentReachabilityStatus;

+ (ZKINetworkManager *)shareManager;

- (RACSignal *)rac_currentReachabilityStatus;

@end
