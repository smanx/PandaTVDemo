//
//  SearchViewController.m
//  PandaTVDemo
//
//  Created by ZC on 16/10/20.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "SearchViewController.h"
#import "ClassListCollectionController.h"
@interface SearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

{
    NSInteger _currentPage;
    NSString *_urlString;
}

@property (nonatomic,weak)UITableView *tableView;

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

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.searchBar becomeFirstResponder];
    self.tabBarController.tabBar.hidden = YES;
    
    [self tableView];
    
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
    [self.searchBar becomeFirstResponder];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    NSString *string = searchBar.text;
    
    
    [self saveSearchHistory:string];
    
    
    _currentPage = 1;
    string = [NSString stringWithFormat:kSearchOnlineUrlString,string,_currentPage];

    
    _urlString = string;
    
    [self requstDataFromeNetworking:string];
    
    [self.searchBar resignFirstResponder];
}

- (void)saveSearchHistory:(NSString *)string
{
    NSMutableArray *searchHistorys = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"SearchHistorys"]];
    if (!searchHistorys) {
        searchHistorys = [NSMutableArray array];
    }
    [searchHistorys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:string]) {
            [searchHistorys removeObject:string];
        }
    }];
    [searchHistorys addObject:string];
    [[NSUserDefaults standardUserDefaults] setObject:searchHistorys forKey:@"SearchHistorys"];
    [self.tableView reloadData];
}

- (void)requstDataFromeNetworking:(NSString *)urlString
{
    [SVProgressHUD showInfoWithStatus:@"正在搜索"];
    urlString = [NSString stringWithFormat:urlString,_currentPage];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }
    else
    {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];

        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        layout.minimumInteritemSpacing = 1;
        layout.minimumColumnSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        layout.columnCount = 2;
        
        
        ClassListCollectionController *vc = [[ClassListCollectionController alloc]initWithCollectionViewLayout:layout andString:_urlString andDict:responseObject];
        __weak UIViewController *weakSelf = self;
        vc.backSearchController = ^(UIViewController *player)
        {
            [weakSelf.navigationController pushViewController:player animated:YES];
        };
        
        [self.view addSubview:vc.collectionView];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *historys = [[NSUserDefaults standardUserDefaults]valueForKey:@"SearchHistorys"];
    return 1 + historys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *historys = [[NSUserDefaults standardUserDefaults]valueForKey:@"SearchHistorys"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"搜索历史(点击清空)";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else{
        cell.textLabel.text = historys[historys.count - indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清空搜索历史记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }else
    {
        NSString *string = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        
        [self saveSearchHistory:string];
        
        
        _currentPage = 1;
        string = [NSString stringWithFormat:kSearchOnlineUrlString,string,_currentPage];
        
        
        _urlString = string;
        
        [self requstDataFromeNetworking:string];
        
        [self.searchBar resignFirstResponder];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(buttonIndex == 1)
    {
        NSMutableArray *historys = [NSMutableArray array];
        [[NSUserDefaults standardUserDefaults] setObject:historys forKey:@"SearchHistorys"];
        [self.tableView reloadData];
    }
    
    
}

-(void)dealloc
{
    NSLog(@"搜索界面销毁了");
}
@end
