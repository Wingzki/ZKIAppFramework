//
//  QYTableViewCellProtocol.h
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 16/1/21.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QYTableViewCellProtocol <NSObject>

- (void)bindingData:(id)dataModel;

@end