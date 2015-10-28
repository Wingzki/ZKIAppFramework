//
//  UIViewController+IsDealloc.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "UIViewController+IsDealloc.h"
#import <objc/runtime.h>

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

#import "ZKIAllocedObjectManager.h"

@implementation UIViewController (IsDealloc)

+ (void)swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

+(void)load {
#ifdef DEBUG
    [self swizzleInstanceSelector:@selector(init) withNewSelector:@selector(zkiInit)];
#endif
}

- (instancetype)zkiInit {
    
    [[ZKIAllocedObjectManager shareManager] addAllocedObject:self];
    
    return [self zkiInit];
}

- (void)zkiViewDidLoad {
    
    [[ZKIAllocedObjectManager shareManager] addAllocedObject:self];
    
    [self.rac_willDeallocSignal subscribeNext:^(id x) {
        
        [[ZKIAllocedObjectManager shareManager] markAllocedObjectDealloc:self];
        
    }];
    
    [self zkiViewDidLoad];
    
}

@end
