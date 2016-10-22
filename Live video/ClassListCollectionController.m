//
//  ClassListCollectionController.m
//  Live video
//
//  Created by ZC on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "ClassListCollectionController.h"
#import "PandaMainCollectionCell.h"
#import "PandaPlayerController.h"
@interface ClassListCollectionController () <CHTCollectionViewDelegateWaterfallLayout>
{
    NSInteger _currentPage;
}
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL allPlayer;
@end

@implementation ClassListCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict:(NSDictionary *)dict;
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
        self.title = dict[@"cname"];
        _currentPage = 1;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"PandaMainCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPage = 1;
            [_dataArray removeAllObjects];
            [self requstDataFromeNetworking:dict];
        }];
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage ++;
            
            [self requstDataFromeNetworking:dict];
        }];
        
        [self requstDataFromeNetworking:dict];
    }
    return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict2:(NSDictionary *)dict
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _currentPage = 1;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"PandaMainCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPage = 1;
            [_dataArray removeAllObjects];
            [self requstDataFromeNetworking:dict];
        }];
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage ++;
            
            [self requstDataFromeNetworking:dict];
        }];
        [self requstDataFromeNetworking:dict];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(64 + 30, 0, 49, 0);
    }
    

    return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andString:(NSString *)urlString andDict:(NSDictionary *)dict
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _currentPage = 1;
        //_allPlayer = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"PandaMainCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPage = 1;
            [_dataArray removeAllObjects];
            [self requstDataFromeNetworking2:urlString];
        }];
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage ++;
            
            [self requstDataFromeNetworking2:urlString];
        }];
        _dataSource = dict[@"data"][@"items"];
        [self.dataArray addObjectsFromArray:_dataSource];
        [self.collectionView reloadData];
        if (_dataSource.count < 1) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:@"到底啦"];
            [self.collectionView.mj_footer endRefreshing];
        }
        
        self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    }
    
    
    return self;
}


- (void)requstDataFromeNetworking2:(NSString *)urlsting
{
    NSString *urlString = [NSString stringWithFormat:urlsting,_currentPage];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }
    else
    {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        _dataSource = responseObject[@"data"][@"items"];
        [self.dataArray addObjectsFromArray:_dataSource];
        [self.collectionView reloadData];
        if (_dataSource.count < 1) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:@"到底啦"];
            [self.collectionView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _currentPage = 1;
        _allPlayer = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"PandaMainCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage ++;
            
            [self requstDataFromeNetworking];
        }];
        [self requstDataFromeNetworking];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(kScreenWidth * 9.0f/16.0f - 10, 0, 49, 0);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"全部直播";
        label.textColor = kColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, kScreenWidth, 30);

        [self.collectionView addSubview:label];
        
        
        
    }
    
    
    return self;
}

- (void)requstDataFromeNetworking:(NSDictionary *)dict
{
    
    NSString *string = dict[@"ename"];
    if ([string isEqualToString:@"pets"]) {
        string = @"music";
    }
    
    [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:kPandaClassListUrlString,string,_currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        _dataSource = responseObject[@"data"][@"items"];
        [self.dataArray addObjectsFromArray:_dataSource];
        [self.collectionView reloadData];
        if (_dataSource.count < 1) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:@"到底啦"];
            [self.collectionView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)requstDataFromeNetworking
{

    NSString *urlString = [NSString stringWithFormat:kPandaAllUrlString,_currentPage];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }
    else
    {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        _dataSource = responseObject[@"data"][@"items"];
        [self.dataArray addObjectsFromArray:_dataSource];
        [self.collectionView reloadData];
        if (_dataSource.count < 1) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:@"到底啦"];
            [self.collectionView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    

    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PandaMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell cellWithWithDict:_dataArray[indexPath.item] cellForItemAtIndexPath:indexPath];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(4, 3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!_allPlayer) {
        PandaPlayerController *player = [[PandaPlayerController alloc]initWithPandaWithDict:_dataArray[indexPath.item]];
        [SVProgressHUD showWithStatus:@"正在加载"];
        //[self presentViewController:player animated:YES completion:nil];
        if (_backSearchController) {
            _backSearchController(player);
        }
        else{
            [self.navigationController pushViewController:player animated:YES];
        }
        
    }
    else
    {
        if (_backToPlayerController) {
            _backToPlayerController(_dataArray[indexPath.item]);
        }
        
    }
    
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_allPlayer) {
        
        if (_backBlock) {
            _backBlock(scrollView);
        }  
        
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
