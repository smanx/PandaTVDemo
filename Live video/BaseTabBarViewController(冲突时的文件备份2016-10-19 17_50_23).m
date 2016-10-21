//
//  BaseTabBarViewController.m
//  Project
//
//  Created by QF on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController () <UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *controllerNames;

@property (nonatomic,strong) NSArray *controllerTitles;

@property (nonatomic,strong) NSArray *normalImageNames;

@property (nonatomic,strong) NSArray *selectedImageNames;

@property (nonatomic,strong) UINavigationController *currentNavigationController;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.controllerNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[NSClassFromString(obj) alloc]init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
        vc.title = self.controllerTitles[idx];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
        
        if (idx == 0) {
            _currentNavigationController = nav;
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSArray *)controllerNames
{
    if (!_controllerNames) {
        _controllerNames = @[
                             @"MainViewController",
                             @"SencondViewController",
                             @"ThirdViewController",
                             @"FourthViewController"];
    }
    return _controllerNames;
}

-(NSArray *)controllerTitles

{
    if (!_controllerTitles) {
        _controllerTitles = @[@"首页",@"游戏",@"娱乐",@"我的"];
    }
    return _controllerTitles;
}

-(NSArray *)normalImageNames
{
    if (!_normalImageNames) {
        _normalImageNames = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    }
    return _normalImageNames;
}

-(NSArray *)selectedImageNames
{
    if (!_selectedImageNames) {
        _selectedImageNames = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    }
    return _selectedImageNames;
}

-(BOOL)shouldAutorotate{
    
    BOOL b = _currentNavigationController.topViewController.shouldAutorotate;
    return b;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    _currentNavigationController = (UINavigationController *)viewController;

    NSArray *controllers = self.childViewControllers;
    
    for (UINavigationController *vc in controllers) {
        [vc popToRootViewControllerAnimated:NO];
    }
    
}

- (void)dealloc
{
    
    NSLog(@"tabbarController销毁了");
}
@end
