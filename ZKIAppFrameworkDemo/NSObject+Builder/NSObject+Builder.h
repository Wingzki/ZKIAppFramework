//
//  NSObject+Builder.h
//  ZKINSObjectBuilder
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSObjectBuilderProtocol <NSObject>

@required

- (instancetype)build;

@end

@interface NSObject (Builder)

+ (instancetype)createWithBuilder:(void(^)(id <NSObjectBuilderProtocol> builder))block;

@end
