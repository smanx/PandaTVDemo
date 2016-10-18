//
//  PandaMainCollectionCell.h
//  Live video
//
//  Created by chuan on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaADModel.h"
@interface PandaMainCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNumberLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTrailing;

-(void)cellWithModel:(PandaADModel *)model cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)cellWithWithDict:(NSDictionary *)dict cellForItemAtIndexPath:(NSIndexPath *)indexPath;




@end
