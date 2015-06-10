//
//  YTKRequest+RecativeCocoa.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "YTKRequest+RecativeCocoa.h"

@interface YTKRequest ()

@end

@implementation YTKRequest (RecativeCocoa)

+ (RACSignal *)rac_startRequestWithBuilder:(void(^)(id <NSObjectBuilderProtocol> builder))block {
        
    RACSubject *requestStatusSignal = [[RACSubject alloc] init];
    
    YTKRequest *newRequest = [self createWithBuilder:block];
    
    [requestStatusSignal sendNext:@(YES)];
    
    [newRequest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(NO)];
        
        [requestStatusSignal sendNext:request.responseJSONObject];
        
        [requestStatusSignal sendCompleted];
        
    } failure:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(YES)];
        
        NSError *error = [[NSError alloc] initWithDomain:@"RequestError" code:0 userInfo:@{@"Request": request}];
        
        [requestStatusSignal sendError:error];
        
    }];
    
    return requestStatusSignal;
    
}

- (RACSignal *)rac_restartRequest {
    
    RACSubject *requestStatusSignal = [[RACSubject alloc] init];
    
    [requestStatusSignal sendNext:@(YES)];
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(NO)];
        
        [requestStatusSignal sendNext:request.responseJSONObject];
        
        [requestStatusSignal sendCompleted];
        
    } failure:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(YES)];
        
        NSError *error = [[NSError alloc] initWithDomain:@"RequestError" code:0 userInfo:@{@"Request": request}];
        
        [requestStatusSignal sendError:error];
        
    }];
    
    return requestStatusSignal;
    
}

@end
