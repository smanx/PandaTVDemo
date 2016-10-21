//
//  PandaHeaderReusable.h
//  Live video
//
//  Created by chuan on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaADModel.h"
@interface PandaHeaderReusable : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *more;


@property (nonatomic,copy) void (^backToController)(NSDictionary *);

-(void)cellWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;

@end
