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
    
    RequestStatusShowActivity,
    RequestStatusHideActivity,
    RequestStatusShowEmptyView,
    RequestStatusShowErrorView
    
};

@protocol RequestStatusHandleProtocol <NSObject>

@property (strong, nonatomic) RACSubject *requestStatusSiganl;

@end

@interface NSObject (RequestStatusHandle) <RequestStatusHandleProtocol>

@end

@protocol YTKRequestResponseDataHandleProtocol <NSObject>

@optional

- (id)responseDataHandle:(id)value racSubject:(id <RACSubscriber>)subscriber;
- (NSInteger)dataEmptyHandle:(id)value;

@end

@interface YTKRequest (RecativeCocoa) <YTKRequestResponseDataHandleProtocol>

- (RACSignal *)rac_request;

@end

@interface RACSignal (RequestSignal)

- (RACSignal *)connectRequestSignalWith:(RACSubject *)subject
                         isShowActivity:(BOOL)isShowActivity
                        isShowErrorView:(BOOL)isShowErrorView
                        isShowEmptyView:(BOOL)isShowEmptyView;

- (void)subscribeResponseWithClass:(Class)responseClass
                           success:(void (^)(id value))successBlock
                             error:(void (^)(NSError *error))errorBlock;


@end

