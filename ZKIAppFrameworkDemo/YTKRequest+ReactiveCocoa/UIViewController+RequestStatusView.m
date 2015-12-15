//
//  UIViewController+RequestStatusView.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "UIViewController+RequestStatusView.h"
#import "YTKRequest+RecativeCocoa.h"

@implementation UIViewController (RequestStatusView)

- (void)handleRequestStatus:(RACSignal *)signal scrollView:(UIScrollView *)scrollView {
    
    [[signal filter:^BOOL(id value) {
        
        return [value isKindOfClass:[NSNumber class]];
        
    }] subscribeNext:^(id x) {
        
        RequestStatus status = [x unsignedIntegerValue];
        
        switch (status) {
            case RequestStatusShowActivity:
                
                if ([self respondsToSelector:@selector(showActivity:)]) {
                    [self showActivity:YES];
                }
                
                break;
                
            case RequestStatusHideActivity:
                
                if ([self respondsToSelector:@selector(showActivity:)]) {
                    [self showActivity:NO];
                }
                
                break;
                
            case RequestStatusShowEmptyView:
                
                if ([self respondsToSelector:@selector(showEmptyView:)]) {
                    [self showEmptyView:YES];
                }
                
                break;
                
            default:
                break;
        }
        
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

#pragma mark - RequestStatusViewProtocol

- (void)showActivity:(BOOL)show; {
    
    if (show) {
        
        NSLog(@"显示菊花");
        
    }else {
        
        NSLog(@"隐藏菊花");
        
    }
    
}

- (void)showEmptyView:(BOOL)show; {
    
    if (show) {
        
        NSLog(@"数据为空");
        
    }else {
        
        NSLog(@"数据不为空");
        
    }
    
}

- (void)showErrorView:(BOOL)show request:(ZKITestRequest *)request; {
    
    if (show) {
        
        NSLog(@"网络错误");
        
    }else {
        
    }
    
}


@end
