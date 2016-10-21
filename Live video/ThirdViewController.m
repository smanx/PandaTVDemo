//
//  ThirdViewController.m
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "ThirdViewController.h"
#import "ClassListCollectionController.h"
#import "WMPageController.h"
#import "CHTCollectionViewWaterfallLayout.h"
@interface ThirdViewController () <WMPageControllerDelegate,WMPageControllerDataSource>

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSMutableArray *dataListSource;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)WMPageController *pageController;
@end

@implementation ThirdViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requstDataFromeNetworking];

}
- (void)setupUI
{
    
    
    NSMutableArray *titles = [NSMutableArray array];
    
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj[@"cname"]];
    }];
    
    _titles = titles;
    
    _pageController = [[WMPageController alloc]init];
    _pageController.dataSource = self;
    _pageController.delegate = self;
    _pageController.menuItemWidth = 100;
    _pageController.view.frame = self.view.frame;
    _pageController.menuViewStyle = WMMenuViewStyleFlood;
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];

}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return _titles.count;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
    layout.minimumInteritemSpacing = 1;
    layout.minimumColumnSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.columnCount = 2;
    __block ClassListCollectionController *vc = nil;
    [_dataListSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"type"][@"cname"] isEqualToString:_titles[index]]) {
            vc = [[ClassListCollectionController alloc]initWithCollectionViewLayout:layout andDict2:_dataListSource[idx][@"type"]];
        }
    }];
    
    vc.view.backgroundColor = kColor;
    return vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    if (index == 2) {
        return @"音乐专区";
    }
    return _titles[index];
}


- (void)requstDataFromeNetworking
{
    
    //[SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager]GET:kRecreationTitleListUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _titles = responseObject[@"data"];

        NSInteger i = 1;
        [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self requstDataFromeNetworking:[NSString stringWithFormat:kPandaClassListUrlString,_titles[idx][@"ename"],i]];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
}

- (void)requstDataFromeNetworking:(NSString *)urlString
{
    
    //[SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.dataListSource addObject:responseObject[@"data"]];
        if (_dataListSource.count == _titles.count) {
            [self setupUI];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
}


-(NSMutableArray *)dataListSource
{
    if (!_dataListSource) {
        _dataListSource = [NSMutableArray array];
    }
    return _dataListSource;
}


@end
