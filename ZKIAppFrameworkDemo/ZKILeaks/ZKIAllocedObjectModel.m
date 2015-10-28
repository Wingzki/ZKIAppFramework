//
//  ZKIAllocedObjectModel.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIAllocedObjectModel.h"

@implementation ZKIAllocedObjectModel

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ %@", self.allocedObjectName, self.isDealloced ? @"YES" : @"NO"];
    
}

@end
