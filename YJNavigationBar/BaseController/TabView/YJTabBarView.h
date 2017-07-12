//
//  YJTabBarView.h
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTabBarView : UIView

@property (nonatomic , copy) void (^btnSelectBlock)(int to);

- (void)selectIndex:(int)index;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
