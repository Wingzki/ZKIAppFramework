//
//  QYTableViewProtocol.h
//  QYTips
//
//  Created by Dai Qinfu on 16/1/21.
//  Copyright © 2016年 QYER-inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYTableViewCellProtocol.h"

#import "ReactiveCocoa.h"
#import "RACEXTScope.h"

typedef BOOL(^CellFilter)(NSIndexPath *indexPath);
typedef id(^CellData)(NSIndexPath *indexPath);

@interface QYTableViewProtocol : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) RACSubject *didSelectRowAtIndexPath;

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
       forIdentifier:(NSString *)identifier
              filter:(CellFilter)block
                data:(CellData)dataBlock;

- (void)registerCell:(Class <QYTableViewCellProtocol> )cellClass
         onTableView:(UITableView *)tableView
       forIdentifier:(NSString *)identifier
              filter:(CellFilter)block;

@end
