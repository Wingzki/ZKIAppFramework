//
//  ZKIFooViewModel.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/21.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Builder.h"
#import "ZKITestRequest.h"

typedef NS_ENUM(NSUInteger, ZKIDataStatus) {
    
    ZKIDataStatusNull,
    ZKIDataStatusA,
    ZKIDataStatusB,
    ZKIDataStatusC
    
};

typedef NS_ENUM(NSUInteger, ZKIViewStatus) {
    
    ZKIViewStatusLoading,
    ZKIViewStatusNormal,
    ZKIViewStatusNothing,
    ZKIViewStatusNetworkError,
    ZKIViewStatusMoreData,
    ZKIViewStatusNoMoreData
    
};

/**
 *  页面刷新协议，页面展现形式的状态机
 */
@protocol ZKIChangeStatusProtocol <NSObject>

@required

- (void)changeStatusWithDataStatus:(ZKIDataStatus)dataStatus
                        viewStatus:(ZKIViewStatus)viewStatus;

@end

@interface ZKIFooViewModel : NSObject <NSObjectBuilderProtocol>

@property (weak, nonatomic) id <ZKIChangeStatusProtocol> delegate;

- (void)getData;

- (void)startRequest:(ZKITestRequest *)request;

@end
