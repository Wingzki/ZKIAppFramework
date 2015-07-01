//
//  UIViewController+RequestStatusView.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/7/1.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "UIViewController+RequestStatusView.h"


@implementation UIViewController (RequestStatusView)

- (void)handleRequestStatusView:(NSObject <RequestStatusHandleProtocol> *)object {
    
    [object.requestStatusSiganl subscribeNext:^(id x) {
        
        
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
                    
                    if ([self respondsToSelector:@selector(showErrorView:withRequest:)]) {
                        [self showErrorView:YES withRequest:nil];
                    }
                    
                    break;
                    
                case RequestStatusShowEmptyView:
                    
                    if ([self respondsToSelector:@selector(showEmptyView:)]) {
                        [self showEmptyView:NO];
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
            
        }else if ([x isKindOfClass:[YTKRequest class]]) {
            
            YTKRequest *request = x;
            
            if ([self respondsToSelector:@selector(showErrorView:withRequest:)]) {
                [self showErrorView:YES withRequest:request];
            }
            
        }
        
    }];
    
}

@end
