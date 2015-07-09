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

@protocol YTKRequestResponseDataHandleProtocol <NSObject>

@optional

- (id)responseDataHandle:(id)value racSubject:(RACSubject *)subject;

@end

@interface YTKRequest (RecativeCocoa) <YTKRequestResponseDataHandleProtocol>

- (RACSignal *)rac_start;

@end
