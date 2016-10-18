//
//  PandaClassCell.h
//  Live video
//
//  Created by ZC on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaADModel.h"
@interface PandaClassCell : UICollectionViewCell
-(void)cellWithDataSource:(NSArray *)dataSource cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
