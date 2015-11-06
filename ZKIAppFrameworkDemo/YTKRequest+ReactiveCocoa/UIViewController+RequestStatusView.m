//
//  UIViewController+RequestStatusView.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "UIViewController+RequestStatusView.h"
#import "YTKRequest+RecativeCocoa.h"

@interface UIViewController ()

- (void)showActivity:(BOOL)show;

- (void)showEmptyView:(BOOL)show;

- (void)showErrorView:(BOOL)show;

@end

@implementation UIViewController (RequestStatusView)

- (void)handleRequestStatus:(RACSignal *)signal scrollView:(UIScrollView *)scrollView {
    
    [signal subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSNumber class]]) {
           
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
                    
                case RequestStatusShowErrorView:
                    
                    if ([self respondsToSelector:@selector(showErrorView:)]) {
                        [self showErrorView:YES];
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
            
        }
        
    }];

    [signal subscribeError:^(NSError *error) {
        
        if ([self respondsToSelector:@selector(showErrorView:)]) {
            [self showErrorView:YES];
        }
        
    }];
    
}

@end
