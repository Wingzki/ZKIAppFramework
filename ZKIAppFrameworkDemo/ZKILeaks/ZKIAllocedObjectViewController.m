//
//  ZKIAllocedObjectViewController.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIAllocedObjectViewController.h"

#import "ZKIAllocedObjectManager.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

@implementation ZKIAllocedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)setupTableView {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_subject"];
    
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Leaks";
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    @weakify(self)
    cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [ZKIAllocedObjectManager shareManager].isCVShow = NO;
        
        return [RACSignal empty];
    }];

    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ZKIAllocedObjectManager shareManager].allocedObjectArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell_subject";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    ZKIAllocedObjectModel *model = [ZKIAllocedObjectManager shareManager].allocedObjectArray[indexPath.row];
    cell.textLabel.font       = [UIFont systemFontOfSize:12];
    cell.textLabel.text       = [NSString stringWithFormat:@"%@ %@", model.allocedObjectName, model.isDealloced ? @"YES" : @"NO"];
    
    if (model.isDealloced) {
        
        cell.backgroundColor = [UIColor greenColor];
        
    }else {
        
        cell.backgroundColor = [UIColor redColor];
        
    }
    
    if ([model.allocedObjectName isEqualToString:[ZKIAllocedObjectManager shareManager].nowVCName]) {
        
        cell.accessoryType   = UITableViewCellAccessoryCheckmark;
        cell.backgroundColor = [UIColor blueColor];
        
    }else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
