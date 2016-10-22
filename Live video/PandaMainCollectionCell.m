//
//  PandaMainCollectionCell.m
//  Live video
//
//  Created by chuan on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaMainCollectionCell.h"
#import "UIImage+GIF.h"
@implementation PandaMainCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)cellWithModel:(PandaADModel *)model cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.items[indexPath.item][@"pictures"][@"img"]]placeholderImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    
    self.titleLabel.text = model.items[indexPath.item][@"name"];
    self.nickNameLabel.text = model.items[indexPath.item][@"userinfo"][@"nickName"];
    
    NSString *string = model.items[indexPath.item][@"person_num"];
    CGFloat personNumber = [string floatValue];
    if (personNumber > 9999) {
        personNumber /= 10000;
        string = [NSString stringWithFormat:@"%0.1f万",personNumber];
    }
    string = [NSString stringWithFormat:@"👁%@",string];
    self.personNumberLabel.text = string;
    
    [self layoutWithIndexPath:indexPath];
}

-(void)cellWithWithDict:(NSDictionary *)dict cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"pictures"][@"img"]]placeholderImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    self.titleLabel.text = dict[@"name"];
    self.nickNameLabel.text = dict[@"userinfo"][@"nickName"];
    if (!self.nickNameLabel.text) {
        self.nickNameLabel.text = dict[@"nickname"];
    }
    
    NSString *string = dict[@"person_num"];

    CGFloat personNumber = [string floatValue];
    if (personNumber > 9999) {
        personNumber /= 10000;
        string = [NSString stringWithFormat:@"%0.1f万",personNumber];
    }
    string = [NSString stringWithFormat:@"👁%@",string];
    self.personNumberLabel.text = string;
    
    [self layoutWithIndexPath:indexPath];
    
}

-(void)layoutWithIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    if (indexPath.item % 2 == 0) {
        self.imageViewLeading.constant = self.titleLabelLeading.constant = 4;
        self.imageViewTrailing.constant = self.titleLabelTrailing.constant = 2;
    }
    else
    {
        self.imageViewLeading.constant = self.titleLabelLeading.constant = 2;
        self.imageViewTrailing.constant = self.titleLabelTrailing.constant = 4;
        
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.imageView);
    }];
    
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(4, 4);
    self.imageView.layer.shadowOpacity = 0.8;
    self.imageView.layer.shadowRadius = 4;
    
    
}

@end
