//
//  BaseModel.m
//  Project
//
//  Created by vera on 16/9/21.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (id)modelWithDictionary:(NSDictionary *)dictionary
{
    BaseModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
