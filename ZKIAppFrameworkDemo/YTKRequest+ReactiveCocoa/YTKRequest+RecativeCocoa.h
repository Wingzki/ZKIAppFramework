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

@interface YTKRequest (RecativeCocoa)

+ (RACSignal *)rac_startRequestWithBuilder:(void(^)(id <NSObjectBuilderProtocol> builder))block;

- (RACSignal *)rac_restartRequest;

@end
