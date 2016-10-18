
//
//  Config.h
//  Project
//
//  Created by vera on 16/9/21.
//  Copyright © 2016年 zc. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "Config.h"

//屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//主题颜色
#define kAppTintColor [UIColor colorWithRed:255.0/255.0 green:85.0/255.0 blue:141.0/255.0 alpha:1.0]

//颜色
#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kFirstOpenKey @"kFirstOpenKey"


#define kPandaMainViewADViewUrlString @"http://api.m.panda.tv/ajax_rmd_ads_get"
#define kPandaRoom @"http://room.api.m.panda.tv/index.php?method=room.shareapi&roomid=430265&callback=jQuery19107462225784955148_1476435072084&_=1476435072085"


#define kColor  [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1]

#endif /* Config_h */
