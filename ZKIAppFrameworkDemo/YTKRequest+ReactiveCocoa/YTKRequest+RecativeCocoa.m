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
        
        [subscriber sendNext:@(RequestStatusShowActivity)];
        
        [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            [subscriber sendNext:@(RequestStatusHideActivity)];
            
            id value = request.responseJSONObject;
            
            if ([request respondsToSelector:@selector(responseDataHandle:racSubject:)]) {
                
                value = [self responseDataHandle:request.responseJSONObject racSubject:subscriber];
                
                if ([request respondsToSelector:@selector(dataEmptyHandle:)]) {
                    
                    NSInteger count = [self dataEmptyHandle:value];
                    
                    if (count == 0) {
                        
                        [subscriber sendNext:@(RequestStatusShowEmptyView)];
                        
                    }
                    
                }
                
            }
            
            [subscriber sendNext:value];
            [subscriber sendCompleted];
            
        } failure:^(YTKBaseRequest *request) {
            
            [subscriber sendNext:@(RequestStatusHideActivity)];
            
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
                        isShowEmptyView:(BOOL)isShowEmptyView {
    
    [[[self filter:^BOOL(id value) {
        
        if ([value isKindOfClass:[NSNumber class]]) {
            
            if ([value integerValue] == 0 && [value integerValue] == 1) {
                
                return isShowActivity;
                
            }
            
            if ([value integerValue] == 2) {
                
                return isShowEmptyView;
                
            }
            
            return YES;
            
        }
        
        return NO;
        
    }] multicast:subject] connect];
    
    
    if (isShowErrorView) {
        
        [[[[[self materialize] filter:^BOOL(RACEvent *value) {
            
            return (value.eventType == RACEventTypeError);
            
        }] map:^id(id value) {
            
            return @(RequestStatusShowErrorView);
            
        }] multicast:subject] connect];
        
    }
    
    return self;
    
}

- (void)subscribeResponseWithClass:(Class)responseClass
                           success:(void (^)(id value))successBlock
                             error:(void (^)(NSError *error))errorBlock {
    
    [[self filter:^BOOL(id value) {
        
        return [value isKindOfClass:responseClass];
        
    }] subscribeNext:^(id x) {
        
        if (successBlock) {
            
            successBlock(x);
            
        }
        
    } error:^(NSError *error) {
        
        if (errorBlock) {
            
            errorBlock(error);
            
        }
        
    }];
    
}


@end

