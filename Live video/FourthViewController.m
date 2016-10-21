//
//  FourthViewController.m
//  PandaTVDemo
//
//  Created by ZC on 16/10/20.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "FourthViewController.h"
#import "MeUserView.h"
#import "MeTableViewCell.h"
@interface FourthViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)NSArray *imageNames;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titles = @[@"我要当主播",@"我的订阅",@"观看历史",@"私信",@"活动中心",@"开播提醒",@"意见反馈"];
    _imageNames = @[@"ic_profile_apply_host",@"ic_profile_follow",@"ic_profile_history",@"chatmessage_xinxi_icon_lishi",@"ic_profile_activity",@"ic_profile_remind",@"ic_profile_feedback"];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        tableView.contentInset = UIEdgeInsetsMake(64, 0, -49, 0);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [tableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        tableView.tableHeaderView = [[MeUserView alloc]initWithFrame:CGRectMake(0, 0, 0, 80)];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 4;
            break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section < 3) {
        cell.titleLabel.text = _titles[indexPath.section];
        cell.iconView.image = [UIImage imageNamed:_imageNames[indexPath.section]];
        
    }
    else{
        cell.titleLabel.text = _titles[indexPath.row + 3];
        cell.iconView.image = [UIImage imageNamed:_imageNames[indexPath.row + 3]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
