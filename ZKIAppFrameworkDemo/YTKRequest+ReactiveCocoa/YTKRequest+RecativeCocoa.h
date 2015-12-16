//
//  YTKRequest+RecativeCocoa.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "YTKRequest.h"
#import "NSObject+Builder.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

typedef NS_ENUM(NSUInteger, RequestStatus) {
    
    RequestStatusShowActivity  = 1,
    RequestStatusHideActivity  = 2,
    RequestStatusShowEmptyView = 3
    
};

@protocol YTKRequestResponseDataHandleProtocol <NSObject>

@optional

- (id)responseDataHandle:(id)value racSubject:(id <RACSubscriber>)subscriber;
- (NSInteger)dataEmptyHandle:(id)value;

@end

@interface YTKRequest (RecativeCocoa) <YTKRequestResponseDataHandleProtocol>

@property (strong, nonatomic, readonly) RACSubject *requestStatusSiganl;

- (RACSignal *)rac_request;

@end

@interface RACSignal (RequestSignal)

- (RACSignal *)filterRequestStatusShowActivity:(BOOL)showActivity
                                 showEmptyView:(BOOL)showEmptyView
                                 showErrorView:(BOOL)showErrorView;

@end

