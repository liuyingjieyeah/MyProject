//
//  YJBaseViewController.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "YJBaseViewController.h"
#import "YJToolClass.h"

@interface YJBaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YJBaseViewController

///*

//Custom_Title
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = self.titleLabel;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //？？？？？？？？？？
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    if ([self.navigationController.viewControllers count] >= 2) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.bounds = CGRectMake(0, 0, 12, 20);
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_white"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
}


- (void)setMyTitle:(NSString *)myTitle{
    CGSize size = [[YJToolClass createToolClass] sizeWithString:myTitle andFont:[UIFont systemFontOfSize:18] andMaxWidth:200.0f andMaxHeight:20000.0f];
    self.titleLabel.bounds = CGRectMake(0, 0, size.width, 30);
    self.titleLabel.text = myTitle;
}


- (void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (void)layoutSubViewMethods{}

//*/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
