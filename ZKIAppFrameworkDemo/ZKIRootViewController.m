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

#import "UIView+RequestStatusView.h"
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
    
    [self setupNavigationBar];
    
    self.interactor = [ZKIFooInteractor createWithBuilder:^(ZKIFooInteractor *builder) {
        
    }];
    
    [RACObserve(self, viewModel) subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
    
    RAC(self.navigationItem, title) = [RACObserve(self, viewModel) map:^id(ZKIFooViewModel *value) {
        
        return value.text;
        
    }];
    
    [[[self.interactor testRequest:self.view] map:^id(id value) {
        
        return [ZKIFooViewModel createWithBuilder:^(ZKIFooViewModel *builder) {
            
            builder.text = @"请求成功";
            
        }];
        
    }] subscribeNext:^(id x) {
        
        self.viewModel = x;
        
    } error:^(NSError *error) {
        
        self.viewModel = [ZKIFooViewModel createWithBuilder:^(ZKIFooViewModel *builder) {
            
            builder.text = @"请求错误";
            
        }];
        
    }];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = self.titleText;
    
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
