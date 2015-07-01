//
//  NSObject+RequestStatusHandle.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/10.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

typedef NS_ENUM(NSUInteger, RequestStatus) {
    
    RequestStatusShowActivity,
    RequestStatusHideActivity,
    RequestStatusShowEmptyView,
    RequestStatusShowErrorView
    
};

@protocol RequestStatusHandleProtocol <NSObject>

@property (strong, nonatomic) RACSubject *requestStatusSiganl;

@end

@interface NSObject (RequestStatusHandle)

@property (strong, nonatomic) RACSubject *requestStatusSiganl;

- (void)registerRequestSignal:(RACSignal *)signal
                showErrorView:(BOOL)isShowError
                 showActivity:(BOOL)isShowActivity
                  emptyHandle:(NSInteger (^)(id value))block;

- (void)registerDataEmptySignal:(RACSignal *)signal
                         handle:(NSInteger (^)(id value))block;

- (void)registerDataErrorSignal:(RACSignal *)signal;

- (void)registerActivitySignal:(RACSignal *)signal;

@end
