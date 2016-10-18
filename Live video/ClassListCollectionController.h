//
//  ClassListCollectionController.h
//  Live video
//
//  Created by ZC on 16/10/16.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
typedef void (^BackToPlayerController) (NSDictionary *);

@interface ClassListCollectionController : UICollectionViewController

@property (nonatomic,copy) BackToPlayerController backToPlayerController;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict:(NSDictionary *)dict;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict2:(NSDictionary *)dict;
@end
