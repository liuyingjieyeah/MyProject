//
//  YJRootTabBarController.h
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YJRootTabBarController : UITabBarController

@property (nonatomic, copy) NSString *tabTitle;

/**
 * 导航条标题视图, 用于修改根视图导航条
 */
@property (nonatomic, strong) UIView *titleView;
/**
 * 导航条左边视图, 用于修改根视图导航条
 */
@property (nonatomic, strong) UIView *leftView;
/**
 * 导航条右边视图, 用于修改根视图导航条
 */
@property (nonatomic, strong) UIView *rightView;


- (void)selectIndex:(int)index;

@end
