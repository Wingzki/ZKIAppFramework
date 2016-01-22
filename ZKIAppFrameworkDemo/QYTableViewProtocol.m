//
//  QYTableViewProtocol.m
//  QYTips
//
//  Created by Dai Qinfu on 16/1/21.
//  Copyright © 2016年 QYER-inc. All rights reserved.
//

#import "QYTableViewProtocol.h"

static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
static NSString * const kNormalCell    = @"kNormalCell";

@interface QYTableViewProtocol ()

@property (strong, nonatomic) NSMutableArray      *cellFilterArray;
@property (strong, nonatomic) NSMutableDictionary *cellStyleDic;
@property (strong, nonatomic) NSMutableDictionary *cellDataDic;

@property (copy  , nonatomic) NumberOfRows numberOfRows;

@end

@implementation QYTableViewProtocol

- (void)chackParameters {
    
}

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

- (void)registerNumberOfRows:(NumberOfRows)block; {
    
    if (block) {
        
        self.numberOfRows = [block copy];
        
    }
    
}

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
              filter:(CellFilter)block
                data:(CellData)dataBlock; {
    
    NSString *randomIdentifier = [self randomString];
    
    while ([self isIdentifierExist:randomIdentifier]) {
        
        randomIdentifier = [self randomString];
        
    }
    
    [tableView registerClass:cellClass forCellReuseIdentifier:randomIdentifier];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalCell];
    
    [self.cellFilterArray addObject:[block copy]];
    [self.cellStyleDic setObject:randomIdentifier forKey:block];
    [self.cellDataDic setObject:[dataBlock copy] forKey:randomIdentifier];
    
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

- (NSString *)randomString {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:10];
    
    for (int i = 0; i < 10; i++) {
        
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
        
    }
    
    return randomString;
}

- (BOOL)isIdentifierExist:(NSString *)identifier {
    
    for (NSString *temp in [self.cellStyleDic allValues]) {
        
        if ([temp isEqualToString:identifier]) {
            return  YES;
        }
        
    }
    
    return NO;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.numberOfSections;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.numberOfRows) {
        
        return self.numberOfRows(section);
        
    }
    
    return 0;
    
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
