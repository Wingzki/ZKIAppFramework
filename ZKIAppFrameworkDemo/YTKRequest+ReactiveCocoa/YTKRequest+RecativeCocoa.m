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

- (void)subscribeRequestSignalWith:(RACSubject *)subject
                    isShowActivity:(BOOL)isShowActivity
                   isShowErrorView:(BOOL)isShowErrorView
                       emptyHandle:(NSInteger (^)(id value))emptyBlock
                           success:(void (^)(id value))successBlock; {
    
    [[self filter:^BOOL(id value) {
        
        if ([value isKindOfClass:[NSNumber class]]) {
            return isShowActivity;
        }
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            return YES;
        }
        
        return YES;
        
    }] subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSNumber class]]) {
            
            if ([x boolValue]) {
                
                [subject sendNext:@(RequestStatusShowActivity)];
                
            }else {
                
                [subject sendNext:@(RequestStatusHideActivity)];
                
            }
            
        }
        
        if ([x isKindOfClass:[NSDictionary class]] || [x isKindOfClass:[NSArray class]]) {
            
            if (emptyBlock) {
                
                NSInteger count = emptyBlock(x);
                
                if (count == 0) {
                    
                    [subject sendNext:@(RequestStatusShowEmptyView)];
                    
                }
                
            }
            
            successBlock(x);
            
        }
        
        
    } error:^(NSError *error) {
        
        [self.requestStatusSiganl sendNext:@(RequestStatusShowErrorView)];
        
    }];
    
}

@end

