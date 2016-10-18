//
//  PandaADModel.h
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "BaseModel.h"

@interface PandaADModel : BaseModel

@property (nonatomic,copy)NSString *roomid;

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickname;

@property (nonatomic,copy)NSString *bigimg;
@property (nonatomic,copy)NSString *smallimg;
@property (nonatomic,copy)NSString *newimg;

@property (nonatomic,strong)NSArray *items;
@property (nonatomic,strong)NSDictionary *type;

@end
