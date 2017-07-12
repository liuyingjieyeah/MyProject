//
//  AppDelegate.h
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  选择进入哪一个tabbar控制器
 *
 *  @param index index从0开始
 */
- (void)selectTabbarIndex:(int)index;

@end

