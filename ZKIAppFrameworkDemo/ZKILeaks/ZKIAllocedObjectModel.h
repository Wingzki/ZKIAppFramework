//
//  ZKIAllocedObjectModel.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKIAllocedObjectModel : NSObject

@property (copy  , nonatomic) NSString *allocedObjectName;
@property (assign, nonatomic) BOOL isDealloced;

@end
