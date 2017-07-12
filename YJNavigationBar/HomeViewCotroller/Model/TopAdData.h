//
//  TopAdData.h
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/7.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopAdData : NSObject

/**
 *  滚动条标题
 */
@property (nonatomic , copy) NSString *title;

/**
 *  滚动条图片
 */
@property (nonatomic , copy) NSString *imgsrc;

/**
 *  链接
 */
@property (nonatomic , copy) NSString *url;



/**
 *  imgurl  详细图片
 */
@property (nonatomic , copy) NSString *imgurl;
/**
 *  详细内容
 */
@property (nonatomic , copy) NSString *note;
/**
 *  标题
 */
@property (nonatomic , copy) NSString *setname;



@property (nonatomic , copy) NSString *imgtitle;



@end
