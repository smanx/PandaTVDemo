//
//  PandaMainCollectionReusableView.m
//  Live video
//
//  Created by chuan on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaMainCollectionReusableView.h"
#import "PandaADModel.h"
@implementation PandaMainCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)cellWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    PandaADModel *model = dataSource[0];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.type[@"icon"]]];
    self.name.text = model.type[@"cname"];
}

@end
