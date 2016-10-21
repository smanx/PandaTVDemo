//
//  MeUserView.m
//  PandaTVDemo
//
//  Created by ZC on 16/10/20.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "MeUserView.h"

@implementation MeUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defaulthead"]];
    headerView.layer.cornerRadius = 30;
    headerView.clipsToBounds = YES;
    [self addSubview:headerView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gift_rank_wangzhe01"]];
    [self addSubview:iconView];

    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"吴彦祖";
    [self addSubview:nameLabel];
    
    UILabel *myBamboo = [[UILabel alloc]init];
    myBamboo.text = @"我的竹子：70";
    myBamboo.font = [UIFont systemFontOfSize:13];
    [self addSubview:myBamboo];
    
    UILabel *myMoney = [[UILabel alloc]init];
    myMoney.text = @"我的猫币：100";
    myMoney.font = [UIFont systemFontOfSize:13];
    [self addSubview:myMoney];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"猫币充值" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:174.0/255.0 blue:1.0/255.0 alpha:1];
    [self addSubview:button];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@60);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLabel.mas_trailing).offset(10);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headerView.mas_trailing).offset(10);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@60).priority(750);
    }];
    
    [myBamboo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headerView.mas_trailing).offset(10);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(@90);
    }];
    
    [myMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(myBamboo.mas_trailing).offset(20);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(@100);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-20);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
