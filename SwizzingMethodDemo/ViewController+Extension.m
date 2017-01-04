//
//  ViewController+Extension.m
//  SwizzingMethodDemo
//
//  Created by WeiHu on 2016/12/29.
//  Copyright © 2016年 WeiHu. All rights reserved.
//

#import "ViewController+Extension.h"
#import <objc/runtime.h>

@implementation ViewController (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originalMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzled_viewDidLoad));
        BOOL didAddMethod = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod([self class], @selector(swizzled_viewDidLoad), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });

}
//2 imp
- (void)swizzled_viewDidLoad {
    NSLog(@"%s  1",object_getClassName(self));
    [self swizzled_viewDidLoad];
    NSLog(@"%s  2",object_getClassName(self));
    //    self.view.backgroundColor = WXGGlobalBackgroundColor;
}
//3 imp
- (void)swizzled_viewDidLoad2 {
    NSLog(@"%s  3",object_getClassName(self));
    [self swizzled_viewDidLoad2];
    NSLog(@"%s  4",object_getClassName(self));
    
}
@end
