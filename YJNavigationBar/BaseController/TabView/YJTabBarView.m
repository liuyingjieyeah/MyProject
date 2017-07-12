//
//  YJTabBarView.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "YJTabBarView.h"
#import "YJTabBarButton.h"

@interface YJTabBarView()

@property(nonatomic,weak)YJTabBarButton *      selectedButton;
@property (nonatomic , weak) YJTabBarButton *  tabarbutton;

@end

@implementation YJTabBarView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    //创建按钮
    YJTabBarButton *button = [[YJTabBarButton alloc]init];
    [self addSubview:button];
    self.tabarbutton = button;
    
    //设置
    button.item = item;
    
    //监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //默认选中第一个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

- (void)selectIndex:(int)index{
    YJTabBarButton *btn = self.subviews[index];
    btn.tag = index;
    [self buttonClick:btn];
}

- (void)buttonClick:(YJTabBarButton *)btn{
    
    if (self.btnSelectBlock) {
        self.btnSelectBlock((int)btn.tag);
        
#pragma mark - Animation_Replace
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;
        animation.repeatCount = 1;
        animation.removedOnCompletion = YES;
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:-10];
        [btn.layer addAnimation:animation forKey:nil];
#pragma mark - Animation_Replace
    }
    
    //双击通知刷新数据
    if (btn.tag == self.selectedButton.tag) {
        [[NSNotificationCenter defaultCenter]postNotificationName:btn.titleLabel.text object:nil];
    }
    
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
    
    [self setNeedsLayout];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //自定义按钮得大小
    CGFloat  buttonW = self.frame.size.width/self.subviews.count;
    CGFloat  buttonY = 0;
    CGFloat  buttonH = self.frame.size.height;
    
    for (int index = 0; index<self.subviews.count; index++) {
        
        //取出系统原来tabbar上面得按钮
        YJTabBarButton *button = self.subviews[index];
        
        CGFloat  buttonX = index * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //设置按钮得tag值
        button.tag = index;
    }
}



@end
