//
//  PandaPlayerController.h
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PandaADModel.h"

@interface PandaPlayerController : UIViewController



- (instancetype)initWithPandaADModel:(PandaADModel *)model;
- (instancetype)initWithPandaADModel:(PandaADModel *)model indexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithPandaWithDict:(NSDictionary *)dict;

@end
