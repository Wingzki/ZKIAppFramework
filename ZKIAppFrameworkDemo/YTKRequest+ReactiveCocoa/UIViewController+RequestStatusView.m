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

- (void)showErrorView:(BOOL)show request:(ZKITestRequest *)request;

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
                    
                case RequestStatusShowEmptyView:
                    
                    if ([self respondsToSelector:@selector(showEmptyView:)]) {
                        [self showEmptyView:YES];
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
        }else if ([x isKindOfClass:[NSError class]]) {
            
            if ([self respondsToSelector:@selector(showErrorView:request:)]) {
                [self showErrorView:YES request:nil];
            }
            
        }
        
    }];
    
}

@end
