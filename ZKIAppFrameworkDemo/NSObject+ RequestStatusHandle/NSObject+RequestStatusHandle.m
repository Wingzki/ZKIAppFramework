//
//  NSObject+RequestStatusHandle.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/10.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "NSObject+RequestStatusHandle.h"
#import <objc/runtime.h>

@implementation NSObject (RequestStatusHandle)

static const char *varKey = "requestStatusSiganl";

- (RACSubject *)requestStatusSiganl {
    
    RACSubject *temp = (RACSubject *)objc_getAssociatedObject(self, &varKey);
    
    if (!temp) {
        
        self.requestStatusSiganl = (RACSubject *)[[[RACSubject alloc] init] replay];
        
    }
    
    return (RACSubject *)objc_getAssociatedObject(self, &varKey);
}

- (void)setRequestStatusSiganl:(RACSubject *)requestStatusSiganl {
    objc_setAssociatedObject(self, &varKey, requestStatusSiganl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)registerRequestSignal:(RACSignal *)signal
                showErrorView:(BOOL)isShowError
                 showActivity:(BOOL)isShowActivity
                  emptyHandle:(NSInteger (^)(id value))block {
    
    if (isShowError) {
        
        [self registerNetworkErrorSignal:signal];
        
    }
    
    if (isShowActivity) {
        
        [self registerActivitySignal:signal];
        
    }
    
    if (block) {
        
        [self registerDataEmptySignal:signal handle:block];
        
    }
    
}

- (void)registerDataEmptySignal:(RACSignal *)signal
                         handle:(NSInteger (^)(id value))block {
    
    if (!block) {
        return;
    }
    
    if (!self.requestStatusSiganl) {
        
        self.requestStatusSiganl = [[RACSubject alloc] init];
        
    }
    
    [[signal filter:^BOOL(id value) {
        
        return ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]);
        
    }] subscribeNext:^(id x) {
        
        NSInteger count = block(x);
        
        if (count == 0) {
            
            [self.requestStatusSiganl sendNext:@(RequestStatusShowEmptyView)];
            
        }
        
    }];
    
}

- (void)registerNetworkErrorSignal:(RACSignal *)signal {
    
    if (!self.requestStatusSiganl) {
        
        self.requestStatusSiganl = [[RACSubject alloc] init];
        
    }
    
    [signal subscribeError:^(NSError *error) {
        
        if (error.code == 0) {
            
            YTKRequest *request = error.userInfo[@"Request"];
            
            [self.requestStatusSiganl sendNext:@(RequestStatusShowErrorView)];
            [self.requestStatusSiganl sendNext:request];
            
        }
        
    }];
    
}

- (void)registerActivitySignal:(RACSignal *)signal {
    
    if (!self.requestStatusSiganl) {
        
        self.requestStatusSiganl = [[RACSubject alloc] init];
        
    }
    
    [[signal filter:^BOOL(id value) {
        
        return [value isKindOfClass:[NSNumber class]];
        
    }] subscribeNext:^(id x) {
        
        if ([x boolValue]) {
            
            [self.requestStatusSiganl sendNext:@(RequestStatusShowActivity)];
            
        }else {
            
            [self.requestStatusSiganl sendNext:@(RequestStatusHideActivity)];
            
        }
        
    }];
    
}

- (RACSignal *)filterSignal:(RACSignal *)signal class:(Class)class {
    
    return [signal filter:^BOOL(id value) {
        
        return [value isKindOfClass:class];
        
    }];
    
}

@end
