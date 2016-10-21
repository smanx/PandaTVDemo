//
//  PandaHeaderReusable.m
//  Live video
//
//  Created by chuan on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaHeaderReusable.h"

@interface PandaHeaderReusable ()
{
    NSDictionary *_dict;
}
@end

@implementation PandaHeaderReusable

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)moreClick:(id)sender {
    _backToController(_dict);
}

-(void)cellWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{

    
    PandaADModel *model = dataSource[indexPath.section];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.type[@"icon"]]];
    self.name.text = model.type[@"cname"];
    self.more.tintColor = kAppTintColor;
    _dict = model.type;
    
}

@end
