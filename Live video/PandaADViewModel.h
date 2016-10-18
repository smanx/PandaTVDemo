//
//  PandaADViewModel.h
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "ViewModelClass.h"

@interface PandaADViewModel : ViewModelClass

@property (nonatomic,copy)NSString *urlString;

+(instancetype)sharedViewModel;
+(instancetype)adViewWithUrlString:(NSString*)urlString;

- (void)requstDataFromeNetworking;

@end
