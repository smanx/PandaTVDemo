//
//  PandaPlayerController.h
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PandaADModel.h"
#import "ZFPlayerView.h"
@interface PandaPlayerController : UIViewController


@property (nonatomic,strong)ZFPlayerView *playerView;
- (instancetype)initWithPandaADModel:(PandaADModel *)model;
- (instancetype)initWithPandaADModel:(PandaADModel *)model indexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithPandaWithDict:(NSDictionary *)dict;

@end
