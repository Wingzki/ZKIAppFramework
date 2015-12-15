//
//  ZKIRootViewController.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/6/9.
//  Copyright (c) 2015年 Wingzki. All rights reserved.
//

#import "ZKIRootViewController.h"

#import "ZKIFooViewModel.h"
#import "ZKIFooInteractor.h"

#import "UIViewController+RequestStatusView.h"
#import "UIViewController+Leaks.h"

#import "FMDB.h"
#import <objc/runtime.h>

@interface ZKIRootViewController () <RequestStatusViewProtocol> {
    
}

@property (strong, nonatomic) ZKIFooViewModel  *viewModel;
@property (strong, nonatomic) ZKIFooInteractor *interactor;

@end

@implementation ZKIRootViewController

- (void)dealloc
{
    NSLog(@"Dealloc");
}

- (instancetype)build {
    
    NSAssert(self.titleText, @"text没有初始化");
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleText;
    
    [self setupNavigationBar];
    
    self.interactor = [ZKIFooInteractor createWithBuilder:^(ZKIFooInteractor *builder) {
        
    }];
    
    [RACObserve(self, viewModel) subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
    
    ZKITestRequest *request = self.interactor.testRequest;
    
    [self handleRequestStatus:[request.requestStatusSiganl takeUntil:request.rac_willDeallocSignal] scrollView:nil];
    
    [[request.rac_request map:^id(id value) {
        
        return [ZKIFooViewModel createWithBuilder:^(ZKIFooViewModel *builder) {
            
        }];
        
    }] subscribeNext:^(id x) {
        
        self.viewModel = x;
        
    } error:^(NSError *error) {
        
    }];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setupNavigationBar {
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 100)];
    [cancelButton setTitle:@"next" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    @weakify(self)
    cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        
        ZKIRootViewController *tempVC = [[ZKIRootViewController alloc] init];
        
        [self.navigationController pushViewController:tempVC animated:YES];
        
        return [RACSignal empty];
    }];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

@end
