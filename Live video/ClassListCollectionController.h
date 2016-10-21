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

@property (nonatomic,copy) void (^backBlock) (UIScrollView *);

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict:(NSDictionary *)dict;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andDict2:(NSDictionary *)dict;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andString:(NSString *)urlString andDict:(NSDictionary *)dict;;
@end
