//
//  NSObject+Builder.h
//  ZKINSObjectBuilder
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSObjectBuilderProtocol <NSObject>

@optional

- (void)chackParameters;

@end

typedef void (^BuilderBlock)(id <NSObjectBuilderProtocol> builder);

@interface NSObject (Builder)

+ (instancetype)createWithBuilder:(BuilderBlock)block;

@end
