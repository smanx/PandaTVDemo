//
//  PandaMainCollectionReusableView.h
//  Live video
//
//  Created by chuan on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaMainCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

-(void)cellWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;
@end
