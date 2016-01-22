//
//  NSObject+Builder.m
//  ZKINSObjectBuilder
//
//  Created by Dai Qinfu on 15/6/4.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "NSObject+Builder.h"

@implementation NSObject (Builder)

+ (instancetype)createWithBuilder:(BuilderBlock)block {
    
    id objc = [[self alloc] init];
    
    block(objc);
    
    if ([objc respondsToSelector:@selector(chackParameters)]) {
        [objc performSelector:@selector(chackParameters)];
    }
    
    return objc;
    
}

@end
