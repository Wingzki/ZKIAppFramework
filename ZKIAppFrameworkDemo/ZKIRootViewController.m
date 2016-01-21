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

#import "QYTableViewProtocol.h"
#import "TestTableViewCell.h"

@interface ZKIRootViewController () <RequestStatusViewProtocol> {
    
}

@property (strong, nonatomic) ZKIFooViewModel  *viewModel;
@property (strong, nonatomic) ZKIFooInteractor *interactor;

@property (strong, nonatomic) QYTableViewProtocol *tableViewProtocol;

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
    
    RAC(self.navigationItem, title) = RACObserve(self, viewModel.text);
    
    RAC(self, viewModel) = [[[self.interactor testRequest:self.view] map:^id(id value) {
        
        return [ZKIFooViewModel createWithBuilder:^(ZKIFooViewModel *builder) {
            
            builder.text = @"请求成功";
            
        }];
        
    }] catch:^RACSignal *(NSError *error) {
        
        return [RACSignal return:[ZKIFooViewModel createWithBuilder:^(ZKIFooViewModel *builder) {
            
            builder.text = @"请求错误";
            
        }]];
        
    }];
    
    NSArray *dataArray = @[@"h",@"f",@"r",@"h",@"f",@"r",@"h",@"f",@"r",@"h",@"f",@"r"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    self.tableViewProtocol = [[QYTableViewProtocol alloc] init];
    
    [self.tableViewProtocol registerCell:[TestTableViewCell class] onTableView:tableView forIdentifier:@"Test" filter:^BOOL(NSIndexPath *indexPath) {
        
        return indexPath.row % 3 == 1;
        
    } data:^id(NSIndexPath *indexPath) {
        
        return dataArray[indexPath.row];
        
    }];
    
    [self.tableViewProtocol registerCell:[UITableViewCell class] onTableView:tableView forIdentifier:@"hello" filter:^BOOL(NSIndexPath *indexPath) {
       
        return indexPath.row % 3 == 2;
        
    }];
    
    [self.tableViewProtocol registerCell:[UITableViewCell class] onTableView:tableView forIdentifier:@"world" filter:^BOOL(NSIndexPath *indexPath) {
        
        return indexPath.row % 3 == 2;
        
    }];
    
    tableView.dataSource = self.tableViewProtocol;
    tableView.delegate   = self.tableViewProtocol;
    
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
