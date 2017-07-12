//
//  YJNavigationController.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UIViewController *currentShowVC;
@end

@implementation YJNavigationController


//TabBar标题字体颜色
+(void)initialize {
    UINavigationBar *nav = [UINavigationBar appearance];
    nav.translucent = YES;
    NSDictionary *navAttrDict = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:18],
                                  NSForegroundColorAttributeName:[UIColor whiteColor]
                                  };
    [[UINavigationBar appearance] setTitleTextAttributes:navAttrDict];
}



-(id)initWithRootViewController:(UIViewController *)rootViewController{
//    self = [super initWithRootViewController:rootViewController];
    
    YJNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}







- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationBar.translucent = NO;      //半透明
    
//    self.navigationBar.barTintColor = NavgationBar_Color;
//    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //去除NavigationBar下方阴影
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

//状态栏字体颜色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  状态栏
 - (BOOL)prefersStatusBarHidden {
 return YES;
 }
*/

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}



-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

-(BOOL)shouldAutorotate{ return self.topViewController.shouldAutorotate; }

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}



@end
