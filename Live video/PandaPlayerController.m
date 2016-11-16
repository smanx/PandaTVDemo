//
//  PandaPlayerController.m
//  Live video
//
//  Created by ZC on 16/10/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "PandaPlayerController.h"

#import "ClassListCollectionController.h"
@interface PandaPlayerController () 
{
    PandaADModel *_model;
    NSIndexPath *_indexPath;
    NSDictionary *_dict;
    UICollectionView *_collectionView;
}

@end

@implementation PandaPlayerController


- (instancetype)initWithPandaADModel:(PandaADModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        
    }
    return self;
}

-(instancetype)initWithPandaADModel:(PandaADModel *)model indexPath:(NSIndexPath *)indexPath
{
    self = [super init];
    if (self) {
        _model = model;
        _indexPath = indexPath;
    }
    return self;
}

- (instancetype)initWithPandaWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _dict = dict;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)loadView
{
    [super loadView];
    [UIView animateWithDuration:0.01 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadList];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *imageUrlString = [NSString string];
    NSString *urlString = [NSString string];
    UIImageView *imageView = [[UIImageView alloc]init];
    self.playerView.placeholderImageName = @"egopv_photo_placeholder";
    
    if (_indexPath&&!_dict) {
        self.playerView.title = [_model items][_indexPath.item][@"name"];
        imageUrlString = [_model items][_indexPath.item][@"pictures"][@"img"];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        urlString = [NSString stringWithFormat:kPandaRoomUrlString,[_model items][_indexPath.item][@"id"]];
    }
    
    else if (!_indexPath&&_dict)
    {
        self.playerView.title = _dict[@"name"];
        imageUrlString = _dict[@"pictures"][@"img"];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        NSString *roomId = _dict[@"id"];
        if (!roomId) {
            roomId = _dict[@"roomid"];
        }
        urlString = [NSString stringWithFormat:kPandaRoomUrlString,roomId];
    }
    
    else
    {
        self.playerView.title = _model.title;
        imageUrlString = [_model newimg];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        urlString = [NSString stringWithFormat:kPandaRoomUrlString,[_model roomid]];
    }
    self.playerView.layer.contents = (id)(imageView.image.CGImage);
    
    
    [self requestNetworking:urlString];
    
    

    
    

    
}

- (void)requestNetworking:(NSString *)urlString
{
    
    [[AFHTTPSessionManager manager]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.playerView resetToPlayNewURL];
        self.playerView.videoURL = [NSURL URLWithString:responseObject[@"data"][@"videoinfo"][@"address"]];
        
        [self.playerView autoPlayTheVideo];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)loadList
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
    layout.minimumInteritemSpacing = 1;
    layout.minimumColumnSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(28, 1, 1, 1);
    layout.columnCount = 2;
    
    
    ClassListCollectionController *vc = [[ClassListCollectionController alloc]initWithCollectionViewLayout:layout];
    
    __weak typeof(self) weakSelf = self;
    vc.backToPlayerController = ^(NSDictionary *dict){
        NSString *urlString = [NSString stringWithFormat:kPandaRoomUrlString,dict[@"id"]];
        [weakSelf requestNetworking:urlString];
        
        NSString *imageUrlString = [NSString string];
        UIImageView *imageView = [[UIImageView alloc]init];
        
        weakSelf.playerView.title = dict[@"name"];
        imageUrlString = dict[@"pictures"][@"img"];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    };
    
    vc.backBlock = ^(UIScrollView *scrollView)
    {
        CGFloat defaultOffsetY = -245;
        
        if (scrollView.contentOffset.y < -245) {
            
            CGFloat _currentPlayerOffsetx = (defaultOffsetY - scrollView.contentOffset.y);
            
            [weakSelf.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(weakSelf.view).offset(-_currentPlayerOffsetx);
                make.trailing.equalTo(weakSelf.view).offset(_currentPlayerOffsetx);

                
            }];
            
        }
        if (scrollView.contentOffset.y > -200) {
            [weakSelf.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view);
                make.leading.trailing.equalTo(weakSelf.view);
                make.height.equalTo(weakSelf.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
            }];
        }
        
        
//        [UIView animateWithDuration:0.3 animations:^{
//            [weakSelf.view layoutIfNeeded];
//        }];

    };
    
    [self.view addSubview:vc.collectionView];
    
    _collectionView = vc.collectionView;
    
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
}

-(ZFPlayerView *)playerView
{
    if (!_playerView) {
        ZFPlayerView *playerView = [[ZFPlayerView alloc]init];
        playerView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:playerView];
        [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.trailing.equalTo(self.view);
            make.height.equalTo(playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
        }];
        
        
        
        __weak typeof(self) weakSelf = self;
        playerView.goBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //[weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        
        [playerView.controlView.progressView removeFromSuperview];
        [playerView.controlView.videoSlider removeFromSuperview];
        [playerView.controlView.totalTimeLabel removeFromSuperview];
        [playerView.controlView.currentTimeLabel removeFromSuperview];
        _playerView = playerView;
        
        
        playerView.layer.shadowColor = [UIColor blackColor].CGColor;
        playerView.layer.shadowOffset = CGSizeMake(0, 20);
        playerView.layer.shadowOpacity = 0.5;
        playerView.layer.shadowRadius = 10;
    }
    return _playerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)shouldAutorotate{
    return YES;
}

-(void)dealloc
{
    NSLog(@"播放界面销毁了");
}

@end
