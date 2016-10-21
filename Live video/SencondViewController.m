//
//  SencondViewController.m
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "SencondViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "PandaClassCell.h"
#import "ClassListCollectionController.h"
@interface SencondViewController () <UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,weak)UICollectionView *collectionView;
@end

@implementation SencondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requstDataFromeNetworking];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)requstDataFromeNetworking
{
    
    //[SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager]GET:kPandaClassUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataSource = responseObject[@"data"];
        [self collectionView];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumColumnSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.columnCount = 3;
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        collection.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        
        [collection registerNib:[UINib nibWithNibName:@"PandaClassCell" bundle:nil]forCellWithReuseIdentifier:@"PandaClassCell"];

        
        collection.dataSource = self;
        collection.delegate = self;
        collection.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:collection];
        
        _collectionView = collection;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PandaClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PandaClassCell" forIndexPath:indexPath];
    [cell cellWithDataSource:_dataSource cellForItemAtIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(16, 27);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
    layout.minimumInteritemSpacing = 1;
    layout.minimumColumnSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.columnCount = 2;
    

    ClassListCollectionController *vc = [[ClassListCollectionController alloc]initWithCollectionViewLayout:layout andDict:_dataSource[indexPath.item]];
    [self.navigationController pushViewController:vc animated:YES];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
}

-(BOOL)shouldAutorotate{
    return NO;
}


@end
