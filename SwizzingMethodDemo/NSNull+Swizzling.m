//
//  NSNull+Swizzling.m
//  SwizzingMethodDemo
//
//  Created by WeiHu on 2017/1/4.
//  Copyright © 2017年 WeiHu. All rights reserved.
//

#import "NSNull+Swizzling.h"
#import "NSObject+Swizzling.h"

#define NSNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject swizzlingClassString:@"NSNull" methodSwizzlingWithOriginalSelector:@selector(forwardingTargetForSelector:) bySwizzledSelector:@selector(safeForwardingTargetForSelector:)];
        [NSObject swizzlingClassString:@"NSNull" methodSwizzlingWithOriginalSelector:@selector(forwardInvocation:) bySwizzledSelector:@selector(safeForwardInvocation:)];
        [NSObject swizzlingClassString:@"NSNull" methodSwizzlingWithOriginalSelector:@selector(methodSignatureForSelector:) bySwizzledSelector:@selector(safeMethodSignatureForSelector:)];
        
    });
}
- (id)safeForwardingTargetForSelector:(SEL)aSelector{
    if ([self respondsToSelector:aSelector]) {
         return [self safeForwardingTargetForSelector:aSelector];
    }
    return nil;
}
- (void)safeForwardInvocation:(NSInvocation *)anInvocation{
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
    {
        anInvocation.selector = @selector(safe_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in NSNullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self safeForwardInvocation:anInvocation];
}
- (NSMethodSignature *)safeMethodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:aSelector];
            if (!signature) {
                continue;
            }
            if (strcmp(signature.methodReturnType, "@") == 0) {
                signature = [[NSNull null] methodSignatureForSelector:@selector(safe_nil)];
            }
            return signature;
        }
        return [self safeMethodSignatureForSelector:aSelector];
    }
    return signature;
}
- (id)safe_nil
{
    return nil;
}
@end
