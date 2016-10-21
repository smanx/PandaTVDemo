//
//  MainViewController.m
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "MainViewController.h"
#import "PandaADModel.h"
#import "PandaADViewModel.h"
#import "UIImageView+WebCache.h"
#import "ZYBannerView.h"
#import "PandaPlayerController.h"
#import "PandaMainCollectionCell.h"
#import "PandaMainCollectionReusableView.h"
#import "PandaHeaderReusable.h"
#import "PandaFooterReusableView.h"
#import "BaseTabBarViewController.h"
#import "UIImage+GIF.h"
#import "SDImageCache.h"
@interface MainViewController () <ZYBannerViewDataSource,ZYBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *dataListSource;
@property (nonatomic,strong)ZYBannerView *bannerView;
@property (nonatomic,weak)UICollectionView *collectionView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestADViewNetworkingWithUrlString:kPandaMainViewADViewUrlString];
    [self requestADViewNetworkingWithUrlString:kPandaMainListUrlString];
    
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    //[self requestADViewNetworkingWithUrlString:kPandaMainViewADViewUrlString];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        collection.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        [collection registerNib:[UINib nibWithNibName:@"PandaMainCollectionCell" bundle:nil]forCellWithReuseIdentifier:@"PandaMainCollectionCell"];
        [collection registerNib:[UINib nibWithNibName:@"PandaMainCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:kCollectionElementKindSectionHeader withReuseIdentifier:@"PandaMainCollectionReusableView"];
        [collection registerNib:[UINib nibWithNibName:@"PandaHeaderReusable" bundle:nil] forSupplementaryViewOfKind:kCollectionElementKindSectionHeader withReuseIdentifier:kCollectionElementKindSectionHeader];
        [collection registerNib:[UINib nibWithNibName:@"PandaFooterReusableView" bundle:nil] forSupplementaryViewOfKind:kCollectionElementKindSectionFooter withReuseIdentifier:kCollectionElementKindSectionFooter];
        
        collection.dataSource = self;
        collection.delegate = self;
        collection.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:collection];
        
        _collectionView = collection;
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataListSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataListSource[section] items].count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PandaMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PandaMainCollectionCell" forIndexPath:indexPath];
    [cell cellWithModel:_dataListSource[indexPath.section] cellForItemAtIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:kCollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *reusable  = nil;
        if (indexPath.section == 0) {
            PandaMainCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PandaMainCollectionReusableView" forIndexPath:indexPath];
            [headerView cellWithDataSource:_dataListSource indexPath:indexPath];
            [headerView addSubview:self.bannerView];
            reusable = headerView;
        }
        else
        {
            PandaHeaderReusable *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionElementKindSectionHeader forIndexPath:indexPath];
            [headerView cellWithDataSource:_dataListSource indexPath:indexPath];
            reusable = headerView;
        }
        
        reusableView = reusable;
    }
    if ([kind isEqualToString:kCollectionElementKindSectionFooter]) {
        PandaFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionElementKindSectionFooter forIndexPath:indexPath];
        if (indexPath.section == _dataListSource.count - 1) {
            footerView.frame = CGRectZero;
        }
        reusableView = footerView;
    }
    
    
    
    
    return reusableView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PandaADModel *model = _dataListSource[indexPath.section];
    PandaPlayerController *player = [[PandaPlayerController alloc]initWithPandaADModel:model indexPath:indexPath];
    //[self presentViewController:player animated:YES completion:nil];
    [self.navigationController pushViewController:player animated:YES];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 2, kScreenWidth / 2 * 3 / 4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, kScreenWidth / 2 + 40);
    }else
    {
        return CGSizeMake(0, 40);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == _dataListSource.count - 1) {
        return CGSizeZero;
    }else
    {
        return CGSizeMake(0, 5);
    }
}




- (void)leftButtonClick
{

    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    
    CATransition *anim = [CATransition animation];
    
    anim.type = @"rippleEffect";
    
    anim.duration = 1.5f;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseTabBarViewController alloc]init];
    
    [SVProgressHUD showSuccessWithStatus:@"缓存清理，界面重载"];
    
    

    
}

- (void)rightButtonClick
{
    [SVProgressHUD showSuccessWithStatus:@"点10下有惊喜"];
    
}




- (void)requestADViewNetworkingWithUrlString:(NSString *)urlString
{
    PandaADViewModel *viewModel = [PandaADViewModel adViewWithUrlString:urlString];
    
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([urlString isEqualToString:kPandaMainViewADViewUrlString]) {
            _dataSource = returnValue;
            [_bannerView reloadData];
        }
        if ([urlString isEqualToString:kPandaMainListUrlString]) {
            _dataListSource = returnValue;
            [self collectionView];
        }
        
        
        
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    } WithFailureBlock:^{
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
}


-(ZYBannerView *)bannerView
{
    if(!_bannerView)
    {
        ZYBannerView *bannerView = [[ZYBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth / 2)];
        bannerView.shouldLoop = YES;
        bannerView.autoScroll = YES;
        bannerView.dataSource = self;
        bannerView.delegate = self;
        //[self.view addSubview:bannerView];
        
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
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(index * kScreenWidth, 0, kScreenWidth, kScreenWidth / 2);
    imageView.contentMode = UIViewContentModeScaleToFill;
    //[imageView sd_setImageWithURL:[NSURL URLWithString:[_dataSource[index] newimg]] placeholderImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_dataSource[index] newimg]] placeholderImage:[UIImage sd_animatedGIFNamed:@"loading"]];
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
    //[self presentViewController:pandaPlayerController animated:YES completion:nil];
}


-(BOOL)shouldAutorotate{
    
    return YES;
}
@end
