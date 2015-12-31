//
//  YTKRequest+RecativeCocoa.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "YTKRequest+RecativeCocoa.h"
#import <objc/runtime.h>

@implementation YTKRequest (RecativeCocoa)

- (RACSignal *)rac_request {
    
    RACSignal *requestSiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self.requestStatusSiganl sendNext:@(RequestStatusShowActivity)];
        
        [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            [self.requestStatusSiganl sendNext:@(RequestStatusHideActivity)];
            
            id value = request.responseJSONObject;
            
            if ([request respondsToSelector:@selector(responseDataHandle:racSubject:)]) {
                
                value = [self responseDataHandle:request.responseJSONObject racSubject:subscriber];
                
                if ([request respondsToSelector:@selector(dataEmptyHandle:)]) {
                    
                    NSInteger count = [self dataEmptyHandle:value];
                    
                    if (count == 0) {
                        
                        [self.requestStatusSiganl sendNext:@(RequestStatusShowEmptyView)];
                        
                    }
                    
                }
                
            }
            
            [subscriber sendNext:value];
            [subscriber sendCompleted];
            
            [self.requestStatusSiganl sendCompleted];
            
        } failure:^(YTKBaseRequest *request) {
            
            [self.requestStatusSiganl sendNext:@(RequestStatusHideActivity)];
            
            NSError *error;
            
            if ([self respondsToSelector:@selector(creatError:)]) {
                
                error = [self creatError:request];
                
            }else {
                
                error = [[NSError alloc] initWithDomain:@"RequestError"
                                                   code:request.responseStatusCode
                                               userInfo:@{@"Request": request}];
                
            }
            
            [self.requestStatusSiganl sendError:error];
            [subscriber sendError:error];
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
            [self stop];
            
        }];
        
    }];
    
    return requestSiganl;
    
}

#pragma mark - Getter Setter

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

@implementation RACSignal (RequestSignal)

- (RACSignal *)filterRequestStatusShowActivity:(BOOL)showActivity
                                 showEmptyView:(BOOL)showEmptyView
                                 showErrorView:(BOOL)showErrorView {
    
    return [[[self filter:^BOOL(id value) {
        
        return [value isKindOfClass:[NSNumber class]];
        
    }] filter:^BOOL(id value) {
        
        RequestStatus status = (RequestStatus)[value integerValue];
        
        if (status == RequestStatusShowActivity || status == RequestStatusHideActivity) {
            
            return showActivity;
            
        }
        
        if (status == RequestStatusShowEmptyView) {
            
            return showEmptyView;
            
        }
        
        return NO;
        
    }] catch:^RACSignal *(NSError *error) {
        
        return showErrorView ? [RACSignal return:error] : [RACSignal empty];
        
    }];
    
}

@end

