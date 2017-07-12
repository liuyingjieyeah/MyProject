//
//  YJBaseViewController.h
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+LYJ.h"
#import "MJRefresh.h"
#import "WRNavigationBar.h"
#import "PPNetworkHelper.h"
#import "MJExtension.h"


@interface YJBaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UINavigationBar *myNavigationBar;
@property (nonatomic, strong) UINavigationItem *myNavigationItem;
@property (nonatomic, copy) NSString *myTitle;

/**
 *  布局方法,在这里面初始化控件
 */
- (void)layoutSubViewMethods;
- (void)backBtnPress;

@end
