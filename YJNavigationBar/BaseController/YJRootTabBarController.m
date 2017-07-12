//
//  YJRootTabBarController.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "YJRootTabBarController.h"
#import "YJNavigationController.h"
#import "WRNavigationBar.h"
#import "YJTabBarView.h"

#import "ViewController.h"
//#import "SecondViewController.h"
#import "NormalListController.h"


@interface YJRootTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger indexFlag;
@property (nonatomic , strong) YJTabBarView *tabBarView;


@end

@implementation YJRootTabBarController

//Clean_TabBar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if([child isKindOfClass:[UIControl class]]){
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置TabBar背景图片
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBar.png"]];
//    [UITabBar appearance].translucent = NO;
    
    //TabBar背景颜色
//    UIView *bgView = [[UIView alloc]init];
//    bgView.backgroundColor = TabBar_T_Color;
//    bgView.frame = self.tabBar.bounds;
//    [[UITabBar appearance]insertSubview:bgView atIndex:0];

    
    [self creatTabBarView];
    
    [self initChildViewControllers];

    [self setNavBarAppearence];

    _indexFlag = 0;

    //通知以切换主题
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleThemeChanged) name:Notice_Theme_Changed object:nil];
}


//Custom_TabBar
- (void)creatTabBarView {
    
    IMP_BLOCK_SELF(YJRootTabBarController);
    YJTabBarView *tabBarV = [[YJTabBarView alloc]init];
    tabBarV.frame = self.tabBar.bounds;
    tabBarV.btnSelectBlock = ^(int to){
        block_self.selectedIndex = to;
    };
    self.tabBarView = tabBarV;
    
    [self.tabBar addSubview:tabBarV];
    
    [self handleThemeChanged];
}



#pragma mark - Change_Theme

-(void)handleThemeChanged{
    //Config...
}

- (void)selectIndex:(int)index{
    [self.tabBarView selectIndex:index];
}


#pragma mark -- 添加控制器

- (void)initChildViewControllers{

    ViewController *firstVC = [[ViewController alloc]init];
    [self setupChildViewController:firstVC title:@"新闻" imageName:@"btn_home_normal" selectedImage:@"btn_home_selected"];

//    SecondViewController *secondVC = [[SecondViewController alloc]init];
//    [self setupChildViewController:secondVC title:@"图片" imageName:@"btn_hero_normal" selectedImage:@"btn_hero_selected"];
    
    NormalListController *normalVC = [[NormalListController alloc]init];
    [self setupChildViewController:normalVC title:@"Navc" imageName:@"btn_hero_normal" selectedImage:@"btn_hero_selected"];
    
    ViewController *thirdVC = [[ViewController alloc]init];
    [self setupChildViewController:thirdVC title:@"我的" imageName:@"btn_user_normal" selectedImage:@"btn_user_selected"];
}


-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage{
    
    //设置控制器属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个导航控制器
    YJNavigationController *nav = [[YJNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.tabBarView addTabBarButtonWithItem:childVc.tabBarItem];
}




#pragma mark -- 配置控制器

- (void)setNavBarAppearence{
    
    
    // 设置导航栏默认的背景颜色
    [UIColor wr_setDefaultNavBarBarTintColor:MainNavBarColor];
    // 设置导航栏所有按钮的默认颜色
    [UIColor wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [UIColor wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [UIColor wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    // [UIColor wr_setDefaultNavBarShadowImageHidden:YES];
}



@end



/**
 *  动画效果替换代码
 */

/*
 //放大效果，并回到原位
 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
 //速度控制函数，控制动画运行的节奏
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 animation.duration = 0.2;       //执行时间
 animation.repeatCount = 1;      //执行次数
 animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
 animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
 animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
 [[arry[index] layer] addAnimation:animation forKey:nil];
 
 
 //z轴旋转180度
 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
 //速度控制函数，控制动画运行的节奏
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 animation.duration = 0.2;       //执行时间
 animation.repeatCount = 1;      //执行次数
 animation.removedOnCompletion = YES;
 animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
 animation.toValue = [NSNumber numberWithFloat:M_PI];     //结束伸缩倍数
 [[arry[index] layer] addAnimation:animation forKey:nil];
 
 
 //向上移动
 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
 //速度控制函数，控制动画运行的节奏
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 animation.duration = 0.2;       //执行时间
 animation.repeatCount = 1;      //执行次数
 animation.removedOnCompletion = YES;
 animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
 animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
 [[arry[index] layer] addAnimation:animation forKey:nil];
 

 //放大效果(保持)
 CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
 //速度控制函数，控制动画运行的节奏
 animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 animation.duration = 0.2;       //执行时间
 animation.repeatCount = 1;      //执行次数
 animation.removedOnCompletion = NO;
 animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
 animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
 animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
 [[arry[index] layer] addAnimation:animation forKey:nil];
 //移除其他tabbar的动画
 for (int i = 0; i<arry.count; i++) {
 if (i != index) {
 [[arry[i] layer] removeAllAnimations];
 }
 }
 
 */

