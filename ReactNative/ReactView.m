//
//  ReactView.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 16/1/25.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

#import "ReactView.h"

@implementation ReactView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
        
        NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
        
        RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                             moduleName:@"SimpleApp"
                                                      initialProperties:nil
                                                          launchOptions:nil];
        
        [self addSubview:rootView];
        
        rootView.frame = self.bounds;
        
    }
    return self;
}

@end
