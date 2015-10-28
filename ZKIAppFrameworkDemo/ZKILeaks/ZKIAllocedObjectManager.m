//
//  ZKIAllocedObjectManager.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIAllocedObjectManager.h"

@interface ZKIAllocedObjectManager ()

@property (strong, nonatomic, readwrite) NSArray *allocedObjectArray;

@end

@implementation ZKIAllocedObjectManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)shareManager {
    
    static ZKIAllocedObjectManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ZKIAllocedObjectManager alloc] init];
        
    });
    
    return manager;
    
}

- (void)addAllocedObject:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        ZKIAllocedObjectModel *model = [[ZKIAllocedObjectModel alloc] init];
        model.allocedObjectName = [NSString stringWithFormat:@"%@", viewController];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.allocedObjectArray];
        [tempArray addObject:model];
        
        self.allocedObjectArray = [tempArray copy];
        
    }
    
}

- (void)markAllocedObjectDealloc:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        NSString *allocedObjectName = [NSString stringWithFormat:@"%@", viewController];
        
        [self.allocedObjectArray enumerateObjectsUsingBlock:^(ZKIAllocedObjectModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([allocedObjectName isEqualToString:obj.allocedObjectName]) {
                
                obj.isDealloced = YES;
                
                *stop = YES;
                
            }
            
        }];
        
    }
    
}

@end
