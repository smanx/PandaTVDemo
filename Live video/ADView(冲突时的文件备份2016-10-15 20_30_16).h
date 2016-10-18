//
//  ADView.h
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADView : UIView

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,weak) UIPageControl *pageControl;



+(instancetype)adViewWithFrame:(CGRect)frame urlString:(NSString *)urlString;

@end
