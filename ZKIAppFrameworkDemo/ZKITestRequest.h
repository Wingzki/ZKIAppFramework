//
//  ZKITestRequest.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "YTKRequest.h"
#import "YTKRequest+RecativeCocoa.h"

@interface ZKITestRequest : YTKRequest <NSObjectBuilderProtocol> {
    
@private   NSString *_foo1;
@public    NSString *_foo2;
@protected NSString *_foo3;
    
}


@end
