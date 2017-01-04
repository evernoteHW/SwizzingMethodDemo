//
//  NSArray+Swizzling.m
//  SwizzingMethodDemo
//
//  Created by WeiHu on 2017/1/4.
//  Copyright © 2017年 WeiHu. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <UIKit/UIKit.h>

@implementation NSArray (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //判断系统
        if ([UIDevice currentDevice].systemVersion.floatValue > 9.0){
            [NSObject swizzlingClassString:@"__NSSingleObjectArrayI" methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(safeObjectAtIndex:)];
        }else{
            [NSObject swizzlingClassString:@"__NSArrayI" methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(safeObjectAtIndex:)];
        }
    });
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count - 1) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndex:index];
}

@end
