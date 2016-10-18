//
//  PandaHeaderReusable.m
//  Live video
//
//  Created by chuan on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaHeaderReusable.h"

@implementation PandaHeaderReusable

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)moreClick:(id)sender {
}

-(void)cellWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    PandaADModel *model = dataSource[indexPath.section];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.type[@"icon"]]];
    self.name.text = model.type[@"cname"];
}

@end
