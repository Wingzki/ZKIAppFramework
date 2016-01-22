//
//  QYTableViewProtocol.h
//  QYTips
//
//  Created by Dai Qinfu on 16/1/21.
//  Copyright © 2016年 QYER-inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Builder.h"
#import "QYTableViewCellProtocol.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

typedef NSInteger(^NumberOfRows)(NSInteger section);
typedef BOOL(^CellFilter)(NSIndexPath *indexPath);
typedef id(^CellData)(NSIndexPath *indexPath);

@interface QYTableViewProtocol : NSObject <UITableViewDelegate, UITableViewDataSource, NSObjectBuilderProtocol>

@property (strong, nonatomic) RACSubject *didSelectRowAtIndexPath;

@property (assign, nonatomic) NSInteger  numberOfSections;

- (void)registerNumberOfRows:(NumberOfRows)block;

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
              filter:(CellFilter)block
                data:(CellData)dataBlock;

@end
