//
//  NSDictionary+Swizzling.m
//  SwizzingMethodDemo
//
//  Created by WeiHu on 2017/1/4.
//  Copyright © 2017年 WeiHu. All rights reserved.
//

#import "NSDictionary+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSDictionary (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject swizzlingClassString:@"__NSDictionaryI" methodSwizzlingWithOriginalSelector:@selector(objectForKey:) bySwizzledSelector:@selector(safeObjectForKey:)];
        NSLog(@"__NSArrayI");
    });
}
- (id)safeObjectForKey:(id)aKey{
    return  [self safeObjectForKey:aKey];
}

@end
