//
//  QYTableViewProtocol.m
//  QYTips
//
//  Created by Dai Qinfu on 16/1/21.
//  Copyright © 2016年 QYER-inc. All rights reserved.
//

#import "QYTableViewProtocol.h"

static NSString * const kNormalCell = @"kNormalCell";

@interface QYTableViewProtocol ()

@property (strong, nonatomic) NSMutableArray      *cellFilterArray;
@property (strong, nonatomic) NSMutableDictionary *cellStyleDic;
@property (strong, nonatomic) NSMutableDictionary *cellDataDic;

@end

@implementation QYTableViewProtocol

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _cellFilterArray = [NSMutableArray array];
        _cellStyleDic    = [NSMutableDictionary dictionary];
        _cellDataDic     = [NSMutableDictionary dictionary];
        
        _didSelectRowAtIndexPath = [RACSubject subject];
        
    }
    return self;
}

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
       forIdentifier:(NSString *)identifier
              filter:(CellFilter)block
                data:(CellData)dataBlock; {
    
    [self registerCell:cellClass
           onTableView:tableView
         forIdentifier:identifier
                filter:block];
    
    [self.cellDataDic setObject:[dataBlock copy] forKey:identifier];
    
}

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
       forIdentifier:(NSString *)identifier
              filter:(CellFilter)block; {
    
    [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalCell];
    
    [self.cellFilterArray addObject:[block copy]];
    [self.cellStyleDic setObject:identifier forKey:block];
    
}

#pragma mark - private

- (UITableViewCell *)getCell:(NSString *)identifier form:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell <QYTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ([cell respondsToSelector:@selector(bindingData:)]) {
        
        CellData block = self.cellDataDic[identifier];
        
        [cell bindingData:block(indexPath)];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (CellFilter block in self.cellFilterArray) {
        
        BOOL shouldReturnCell = block(indexPath);
        
        if (shouldReturnCell) {
            
            return [self getCell:[self.cellStyleDic objectForKey:block]
                            form:tableView
                       indexPath:indexPath];
            
        }
        
    }
    
    return [tableView dequeueReusableCellWithIdentifier:kNormalCell];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.didSelectRowAtIndexPath sendNext:indexPath];
    
}

@end
