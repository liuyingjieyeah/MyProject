//
//  StaticClass.m
//  YJNavigationBar
//
//  Created by 刘英杰 on 2017/9/14.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "StaticClass.h"

@implementation StaticClass

static StaticClass *__staticClass;

+(instancetype)sharedStaticClass{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __staticClass = [[StaticClass alloc]init];
    });
    return __staticClass;
}


@end
