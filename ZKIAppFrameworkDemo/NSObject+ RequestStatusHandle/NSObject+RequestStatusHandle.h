//
//  NSObject+RequestStatusHandle.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/10.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

typedef NS_ENUM(NSUInteger, RequestStatus) {
    
    RequestStatusShowActivity,
    RequestStatusHideActivity,
    RequestStatusShowEmptyView,
    RequestStatusShowErrorView
    
};

@interface NSObject (RequestStatusHandle)

@property (strong, nonatomic) RACSubject *requestStatusSiganl;

- (void)registerRequestSignal:(RACSignal *)signal
                showErrorView:(BOOL)isShowError
                 showActivity:(BOOL)isShowActivity
                  emptyHandle:(NSInteger (^)(NSDictionary *dataDic))block;

- (void)registerDataEmptySignal:(RACSignal *)signal handle:(NSInteger (^)(NSDictionary *dataDic))block;

- (void)registerDataErrorSignal:(RACSignal *)signal;

- (void)registerActivitySignal:(RACSignal *)signal;

@end
