//
//  SearchViewController.m
//  PandaTVDemo
//
//  Created by ZC on 16/10/20.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "SearchViewController.h"
#import "ClassListCollectionController.h"
@interface SearchViewController () <UISearchBarDelegate>

{
    NSInteger _currentPage;
}

@property (nonatomic,weak) UISearchBar *searchBar;

@end

@implementation SearchViewController

-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        UISearchBar *searchBar = [[UISearchBar alloc]init];
        searchBar.placeholder = @"搜索房间ID,主播名称";
        self.navigationItem.titleView = searchBar;
        searchBar.delegate = self;
        _searchBar = searchBar;
    }
    return _searchBar;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.searchBar becomeFirstResponder];

    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, 22, 22);
    [rightButton setImage:[UIImage imageNamed:@"shouye_icon_search_2"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightButtonClick
{
    if (_searchBar.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入要搜索的内容"];
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *string = searchBar.text;
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    string = [NSString stringWithFormat:kSearchOnlineUrlString,string];
    string = [string stringByAppendingString:@"&pageno=%ld"];
    
    _currentPage = 1;
    
    [self requstDataFromeNetworking:string];
    
    [self.searchBar resignFirstResponder];
}

- (void)requstDataFromeNetworking:(NSString *)urlString
{
    [SVProgressHUD showInfoWithStatus:@"正在搜索"];
    [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:urlString,_currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];

        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        layout.minimumInteritemSpacing = 1;
        layout.minimumColumnSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        layout.columnCount = 2;
        
        
        ClassListCollectionController *vc = [[ClassListCollectionController alloc]initWithCollectionViewLayout:layout andString:urlString andDict:responseObject];
        
        [self.view addSubview:vc.collectionView];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

@end
