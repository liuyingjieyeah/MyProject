//
//  ViewController.m
//  YJNavigationBar
//
//  Created by liuyingjie on 2017/7/6.
//  Copyright © 2017年 liuyingjieyeah. All rights reserved.
//

#import "ViewController.h"
#import "TopAdViewController.h"
#import "SDCycleScrollView.h"

//#import "SecondViewController.h"

#import "TopAdData.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 44
#define IMAGE_HEIGHT SCREEN_WIDTH * 0.55
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic , strong) NSMutableArray *totalArray;
@property (nonatomic , strong) NSMutableArray *topArray;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic , strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.myTitle = @"常用";
    
    [self creatTableView];
    [self initBannerView];
    [self getTopAdData];


    
    //监听刷新事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mynotification) name:self.title object:nil];
    
    //监听夜间模式的改变
    //...
}

- (void)mynotification{
    [self.tableView.mj_header beginRefreshing];
}


- (void)creatTableView{
    
    [self.view addSubview:self.tableView];
    
    //添加刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getAllData];
    }];
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)initBannerView{
    SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IMAGE_HEIGHT)];
    bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    bannerView.delegate = self;
    bannerView.pageDotColor = [UIColor grayColor];
    bannerView.currentPageDotColor = [UIColor whiteColor];
    bannerView.placeholderImage = [UIImage imageNamed:@"shadow.png"];
    //Custom
    bannerView.titleLabelHeight = IMAGE_HEIGHT * 0.25;
    bannerView.titleLabelTextColor = [UIColor whiteColor];
    bannerView.titleLabelTextFont = [UIFont systemFontOfSize:18];
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    
    self.tableView.tableHeaderView = bannerView;
    self.bannerView = bannerView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TopAdData *data = self.topArray[index];
    NSString *url1 = [data.url substringFromIndex:4];
    url1 = [url1 substringToIndex:4];
    NSString *url2 = [data.url substringFromIndex:9];
    
    url2 = [NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/%@/%@.json",url1,url2];
    TopAdViewController *topVC = [[TopAdViewController alloc]init];
    topVC.url = url2;
    [self.navigationController pushViewController:topVC animated:YES];
}



#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"firstTabViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数据%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}





#pragma mark - NetWork

- (void)getTopAdData{
    NSString *url = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";
    [PPNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        [self setBannerViewWithData:responseCache];
    } success:^(id responseObject) {
        [self setBannerViewWithData:responseObject];
    } failure:^(NSError *error) {}];
}

- (void)setBannerViewWithData:(id)responseObject{

    NSDictionary *rootDic = responseObject[@"T1348647853363"][0][@"ads"];
    NSArray *dataArray = [TopAdData mj_objectArrayWithKeyValuesArray:rootDic];
    NSMutableArray *topArray = [NSMutableArray array];
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    NSMutableArray *titleArray = [NSMutableArray array];
    for (TopAdData *data in dataArray) {
        [topArray addObject:data];
        [statusFrameArray addObject:data.imgsrc];
        [titleArray addObject:data.title];
    }
//    [self.topArray addObjectsFromArray:topArray];
//    [self.imagesArray addObjectsFromArray:statusFrameArray];
//    [self.titleArray addObjectsFromArray:titleArray];
    
    self.topArray = topArray;
    self.imagesArray = statusFrameArray;
    self.titleArray = titleArray;
    
    self.bannerView.imageURLStringsGroup = self.imagesArray;
    self.bannerView.titlesGroup = self.titleArray;
}


- (void)getAllData{
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];

}



#pragma mark - Scroll_Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


}







#pragma mark - Set&Get

-(NSMutableArray *)totalArray{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)topArray{
    if (!_topArray) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tabRect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40);
        _tableView = [[UITableView alloc]initWithFrame:tabRect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        //_tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(CGSizeMake(newSize.width*2, newSize.height*2));
    [image drawInRect:CGRectMake (0, 0, newSize.width*2, newSize.height*2)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.tableView.delegate = nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
