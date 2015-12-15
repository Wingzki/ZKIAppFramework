//
//  ZKIFooInteractor.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/12/15.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Builder.h"
#import "ZKITestRequest.h"

@interface ZKIFooInteractor : NSObject <NSObjectBuilderProtocol>

- (ZKITestRequest *)testRequest;

@end
