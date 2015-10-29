//
//  ZKIAllocedObjectManager.m
//  ZKIAppFrameworkDemo
//
//  Created by Dai Qinfu on 15/10/28.
//  Copyright © 2015年 Wingzki. All rights reserved.
//

#import "ZKIAllocedObjectManager.h"
#import "ZKIAllocedObjectViewController.h"
#import "AppDelegate.h"

@interface ZKIAllocedObjectManager ()

@property (strong, nonatomic) UINavigationController *objectNavigationController;

@property (strong, nonatomic, readwrite) NSArray  *allocedObjectArray;
@property (strong, nonatomic, readwrite) UIButton *mainButton;
@property (strong, nonatomic, readwrite) NSString *nowVCName;

@end

@implementation ZKIAllocedObjectManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)shareManager {
    
    static ZKIAllocedObjectManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ZKIAllocedObjectManager alloc] init];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        manager.mainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, 50, 50)];
        manager.mainButton.layer.masksToBounds = YES;
        manager.mainButton.layer.cornerRadius  = 25;
        manager.mainButton.layer.borderColor   = [UIColor greenColor].CGColor;
        manager.mainButton.layer.borderWidth   = 2;
        [manager.mainButton setTitle:@"D" forState:UIControlStateNormal];
        [manager.mainButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [manager.mainButton addTarget:manager action:@selector(buttonDrag:event:) forControlEvents:UIControlEventTouchDragInside];
        [manager.mainButton addTarget:manager action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        manager.mainButton.backgroundColor = [UIColor whiteColor];
        
        [delegate.window addSubview:manager.mainButton];
        
    });
    
    return manager;
    
}

- (void)moveMainButtonToFront {
 
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.window bringSubviewToFront:self.mainButton];
    
}

- (IBAction)buttonDrag:(UIButton *)sender event:(UIEvent *)event {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    for (UITouch *touch in [[event allTouches] allObjects]) {
        
        CGPoint point = [touch locationInView:delegate.window];
        
        sender.center = CGPointMake(point.x, point.y);
        
    }
    
}

- (IBAction)buttonClicked:(id)sender {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    UINavigationController *rootVC = (UINavigationController *)delegate.window.rootViewController;
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        
        self.nowVCName = [NSString stringWithFormat:@"%@", rootVC.visibleViewController];
        
    }
    
    if (!self.objectNavigationController) {
        
        ZKIAllocedObjectViewController *tempVC = [[ZKIAllocedObjectViewController alloc] init];
        
        self.objectNavigationController = [[UINavigationController alloc] initWithRootViewController:tempVC];
        
    }
    
    [rootVC presentViewController:self.objectNavigationController animated:YES completion:nil];
    
}

- (void)addAllocedObject:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        ZKIAllocedObjectModel *model = [[ZKIAllocedObjectModel alloc] init];
        model.allocedObjectName = [NSString stringWithFormat:@"%@", viewController];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.allocedObjectArray];
        [tempArray addObject:model];
        
        self.allocedObjectArray = [tempArray copy];
        
    }
    
}

- (void)markAllocedObjectDealloc:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        NSString *allocedObjectName = [NSString stringWithFormat:@"%@", viewController];
        
        [self.allocedObjectArray enumerateObjectsUsingBlock:^(ZKIAllocedObjectModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([allocedObjectName isEqualToString:obj.allocedObjectName]) {
                
                obj.isDealloced = YES;
                
                *stop = YES;
                
            }
            
        }];
        
    }
    
}

@end
