
//
//  ViewModelClass.m
//  BaisiDemo
//
//  Created by chuan on 16/10/2.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "ViewModelClass.h"
#import "AFNetworkReachabilityManager.h"
@implementation ViewModelClass




#pragma 接收穿过来的block
-(void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

+(instancetype)sharedViewModel
{
    static ViewModelClass *viewModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewModel = [[self alloc]init];
    });
    return viewModel;
}


@end
