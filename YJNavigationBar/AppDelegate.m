//
//  AppDelegate.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "AppDelegate.h"
#import "YJRootTabBarController.h"

@interface AppDelegate ()

@property (nonatomic, strong)YJRootTabBarController *tabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //判断是否加载引导页亦或是启动广告,此处省略
    
    //添加根控制器
    _tabBarVC = [[YJRootTabBarController alloc]init];
    self.window.rootViewController = _tabBarVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)selectTabbarIndex:(int)index
{
    [self.tabBarVC selectIndex:index];
}

- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}


@end
