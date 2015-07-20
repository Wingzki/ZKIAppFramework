//
//  YTKRequest+RecativeCocoa.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "YTKRequest+RecativeCocoa.h"
#import <objc/runtime.h>

@implementation NSObject (RequestStatusHandle)

static const char *varKey = "requestStatusSiganl";

- (RACSubject *)requestStatusSiganl {
    
    RACSubject *temp = (RACSubject *)objc_getAssociatedObject(self, &varKey);
    
    if (!temp) {
        
        self.requestStatusSiganl = [[RACSubject alloc] init];
        
    }
    
    return (RACSubject *)objc_getAssociatedObject(self, &varKey);
}

- (void)setRequestStatusSiganl:(RACSubject *)requestStatusSiganl {
    objc_setAssociatedObject(self, &varKey, requestStatusSiganl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation YTKRequest (RecativeCocoa)

- (RACSignal *)rac_request {
    
    RACSignal *requestSiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@(YES)];
        
        [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            [subscriber sendNext:@(NO)];
            
            if ([request respondsToSelector:@selector(responseDataHandle:racSubject:)]) {
                
                [subscriber sendNext:[self responseDataHandle:request.responseJSONObject racSubject:subscriber]];
                
            }else {
                
                [subscriber sendNext:request.responseJSONObject];
                
            }
            
            [subscriber sendCompleted];
            
        } failure:^(YTKBaseRequest *request) {
            
            [subscriber sendNext:@(NO)];
            
            NSError *error = [[NSError alloc] initWithDomain:@"RequestError" code:request.responseStatusCode userInfo:@{@"Request": request}];
            
            [subscriber sendError:error];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
            [self stop];
            
        }];
        
    }];
    
    return [requestSiganl replay];
    
}

@end


@implementation RACSignal (RequestSignal)

- (RACSignal *)connectRequestSignalWith:(RACSubject *)subject
                         isShowActivity:(BOOL)isShowActivity
                        isShowErrorView:(BOOL)isShowErrorView
                            emptyHandle:(NSInteger (^)(id value))emptyBlock {
    
    RACSignal *tempSignal = [[self filter:^BOOL(id value) {
        
        if ([value isKindOfClass:[NSNumber class]]) {
            
            return isShowActivity;
            
        }
        
        return YES;
        
    }] map:^id(id value) {
        
        if ([value isKindOfClass:[NSNumber class]]) {
            
            if ([value boolValue]) {
                
                return @(RequestStatusShowActivity);
                
            }else {
                
                return @(RequestStatusHideActivity);
                
            }
            
        }
        
        if (emptyBlock) {
            
            if (emptyBlock(value) == 0) {
                return @(RequestStatusShowEmptyView);
            }
            
        }
        
        return nil;
        
    }];
    
    if (isShowErrorView) {
        
        [tempSignal subscribeError:^(NSError *error) {
            
            [subject sendNext:@(RequestStatusShowErrorView)];
            
        }];
        
    }
    
    [[tempSignal multicast:subject] connect];
    
    return self;
    
}

- (void)subscribeResultWithClass:(Class)class
                         success:(void (^)(id value))successBlock {
    
    [[self filter:^BOOL(id value) {
        
        return [value isKindOfClass:class];
        
    }] subscribeNext:^(id x) {
        
        successBlock(x);
        
    } error:^(NSError *error) {
        
    }];
    
}


@end

