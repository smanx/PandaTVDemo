//
//  MainViewController.m
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "MainViewController.h"
#import "ADView.h"
#import "PandaADModel.h"
#import "PandaADViewModel.h"

#import "ZYBannerView.h"
#import "PandaPlayerController.h"
#import "UIViewController+MMDrawerController.h"
@interface MainViewController () <ZYBannerViewDataSource,ZYBannerViewDelegate>
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,weak)ZYBannerView *bannerView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestADViewNetworking];
    
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)leftButtonClick
{
    [SVProgressHUD showInfoWithStatus:@"leftButtonClick"];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    //[self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

- (void)rightButtonClick
{
    [SVProgressHUD showInfoWithStatus:@"rightButtonClick"];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    //[self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)requestADViewNetworking
{
    PandaADViewModel *viewModel = [PandaADViewModel adViewWithUrlString:kPandaMainViewADViewUrlString];
    
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        _dataSource = returnValue;
        [self bannerView];
        //[self setupADTitleLabel];
        
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    } WithFailureBlock:^{
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
}

- (void)setupADTitleLabel
{
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 2 / 3, self.bannerView.bounds.size.height - 32, kScreenWidth / 3, 32)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        label.text = [NSString stringWithFormat:@"   %@",[obj title]];
        [self.bannerView addSubview:label];
    }];
    
}

-(ZYBannerView *)bannerView
{
    if(!_bannerView)
    {
        ZYBannerView *bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenWidth / 2)];
        bannerView.shouldLoop = YES;
        bannerView.autoScroll = YES;
        bannerView.dataSource = self;
        bannerView.delegate = self;
        [self.view addSubview:bannerView];
        
        bannerView.pageControlFrame = CGRectMake(kScreenWidth * 2 / 3, bannerView.bounds.size.height - 25, kScreenWidth / 3, 25);
        //bannerView.pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        
        _bannerView = bannerView;
    }
    return _bannerView;
}

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return _dataSource.count;
}
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(index * kScreenWidth, 0, kScreenWidth, kScreenWidth / 2);
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_dataSource[index] newimg]] placeholderImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bannerView.bounds.size.height - 25, kScreenWidth, 25)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.text = [NSString stringWithFormat:@"   %@",[_dataSource[index] title]];
    [imageView addSubview:label];
    
    
    return imageView;
    
}
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
    //[SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击了%ld",index]];
    PandaPlayerController *pandaPlayerController = [[PandaPlayerController alloc]initWithPandaADModel:_dataSource[index]];
    [self.navigationController pushViewController:pandaPlayerController animated:YES];
}

@end
