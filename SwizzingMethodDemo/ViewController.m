//
//  ViewController.m
//  SwizzingMethodDemo
//
//  Created by WeiHu on 2016/12/29.
//  Copyright © 2016年 WeiHu. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Extension.h"
#import "NSMutableArray+Swizzling.h"
#import "NSArray+Swizzling.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1111", nil];
    NSLog(@"%@",[arr objectAtIndex:1]);
    [arr removeObjectAtIndex:2];
    
    NSArray *arr2 = @[@"9999",[NSNull null]];
    NSLog(@"%.2f",[((NSString *)[arr2 objectAtIndex:1]) floatValue]);
    
    NSDictionary *dic1 = @{@"222":@""};
    NSLog(@"%@",[dic1 objectForKey:@"oooo"]);
    NSSetUncaughtExceptionHandler(nil);
//    [NSNull test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
