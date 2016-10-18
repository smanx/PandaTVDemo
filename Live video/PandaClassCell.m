//
//  PandaClassCell.m
//  Live video
//
//  Created by ZC on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaClassCell.h"

@interface PandaClassCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation PandaClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)cellWithDataSource:(NSArray *)dataSource cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataSource[indexPath.item][@"img"]]];
    self.titleLabel.text = dataSource[indexPath.item][@"cname"];

    self.titleLabel.layer.shadowColor = self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleLabel.layer.shadowOffset = self.imageView.layer.shadowOffset = CGSizeMake(4, 4);
    self.titleLabel.layer.shadowOpacity = self.imageView.layer.shadowOpacity = 0.8;
    self.titleLabel.layer.shadowRadius = self.imageView.layer.shadowRadius = 4;
    
}
@end
