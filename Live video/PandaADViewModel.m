//
//  PandaADViewModel.m
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaADViewModel.h"
#import "PandaADModel.h"
@implementation PandaADViewModel

+(instancetype)sharedViewModel
{
    static PandaADViewModel *viewModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewModel = [[self alloc]init];
    });
    return viewModel;
}
+(instancetype)adViewWithUrlString:(NSString *)urlString
{
    return [[self alloc]initWithUrlString:urlString];
}

- (instancetype)initWithUrlString:(NSString *)urlString
{
    _urlString = urlString;
    self = [super init];
    if (self) {
        [self requstDataFromeNetworking];
    }
    return self;
}
- (void)requstDataFromeNetworking
{
    
    //[SVProgressHUD showWithStatus:@"正在加载"];
    [[AFHTTPSessionManager manager]GET:_urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleDataModeWithResponseObject:responseObject];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
}

- (void)handleDataModeWithResponseObject:(id)responseObject
{
    NSMutableArray *dataSource = [NSMutableArray array];
    NSArray *arr = responseObject[@"data"];
    for (NSDictionary *dict in arr) {
        PandaADModel *model = [PandaADModel modelWithDictionary:dict];
        [dataSource addObject:model];
    }

    if (self.returnBlock) {
        self.returnBlock(dataSource);
    }
}

@end
