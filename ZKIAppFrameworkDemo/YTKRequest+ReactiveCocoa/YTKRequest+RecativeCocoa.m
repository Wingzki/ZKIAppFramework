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

- (RACSignal *)rac_start {
        
    RACSubject *requestStatusSignal = [[RACSubject alloc] init];
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(NO)];
        
        if ([self respondsToSelector:@selector(responseDataHandle:racSubject:)]) {
            
            [requestStatusSignal sendNext:[self responseDataHandle:request.responseJSONObject racSubject:requestStatusSignal]];
            
        }else {
            
            [requestStatusSignal sendNext:request.responseJSONObject];
            
        }
        
        [requestStatusSignal sendCompleted];
        
    } failure:^(YTKBaseRequest *request) {
        
        [requestStatusSignal sendNext:@(NO)];
        
        NSError *error = [[NSError alloc] initWithDomain:@"RequestError" code:request.responseStatusCode userInfo:@{@"Request": request}];
        
        [requestStatusSignal sendError:error];
        
    }];
    
    return [requestStatusSignal startWith:@(YES)];
    
}

@end
