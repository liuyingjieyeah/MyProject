//
//  TestViewController.m
//  YJNavigationBar
//
//  Created by 刘英杰 on 2017/9/14.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //单例操作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    
    
    
    
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
