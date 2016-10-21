
//
//  ADView.m
//  Live video
//
//  Created by ZC on 16/10/14.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "ADView.h"
#import "UIImageView+WebCache.h"
#import "PandaADViewModel.h"
#import "PandaADModel.h"
@interface ADView () <UIScrollViewDelegate>
{
    NSInteger _currentPage;
    NSArray *_dataSource;
}
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation ADView

+(instancetype)adViewWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
    return [[self alloc]initWithFrame:frame urlString:urlString];
}

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        PandaADViewModel *viewModel = [PandaADViewModel adViewWithUrlString:urlString];
        
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
            [self setupViewWithFrame:frame dataSource:returnValue];
            _dataSource = returnValue;
        } WithErrorBlock:^(id errorCode) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        } WithFailureBlock:^{
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }
    return self;
}


- (void)setupViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.backgroundColor = [UIColor redColor];
    _scrollView.contentSize = CGSizeMake((dataSource.count + 2) * kScreenWidth, 0);
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(idx * kScreenWidth, 0, _scrollView.width, _scrollView.height);
        imageView.contentMode = UIViewContentModeScaleToFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dataSource[idx] newimg]] placeholderImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
        
        [_scrollView addSubview:imageView];
        
        [self addTitleViewWithTitle:[dataSource[idx] title] imageView:imageView];
    }];
    
    self.pageControl.numberOfPages = dataSource.count;
    
    [self.timer fire];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / kScreenWidth;
    _pageControl.currentPage = page;
    _currentPage = page;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:pageControl];
        
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.and.bottom.equalTo(self);
            make.height.equalTo(@25);
            make.width.equalTo(@(kScreenWidth/3));
        }];
        
        _pageControl = pageControl;
    }
    return _pageControl;
}


-(void)addTitleViewWithTitle:(NSString *)title imageView:(UIImageView *)imageView
{
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.text = [NSString stringWithFormat:@"   %@",title];
    [imageView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(imageView);
        make.height.equalTo(@25);
        
    }];
    
    
}

-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [UIView animateWithDuration:1 animations:^{
                
                
                if (++_currentPage < _dataSource.count) {
                    _pageControl.currentPage = _currentPage;
                    [_scrollView setContentOffset:CGPointMake(_currentPage * kScreenWidth, 0)];
                }
                else{
                    _pageControl.currentPage = 0;
                    _currentPage = 0;
                    [_scrollView setContentOffset:CGPointMake(_currentPage * kScreenWidth, 0)];
                    
                }
            }];
            
        }];
        
    }
    return _timer;
}

@end
