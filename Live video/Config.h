
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

#define kColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]
//颜色
#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kCollectionElementKindSectionHeader @"UICollectionElementKindSectionHeader"

#define kCollectionElementKindSectionFooter @"UICollectionElementKindSectionFooter"

#define kPandaMainViewADViewUrlString @"http://api.m.panda.tv/ajax_rmd_ads_get"
#define kPandaRoomUrlString @"http://room.api.m.panda.tv/index.php?method=room.shareapi&roomid=%@"
#define kPandaMainListUrlString @"http://api.m.panda.tv/ajax_get_live_list_by_multicate?pagenum=4&hotroom=1&__version=2.0.1.1339&__plat=ios"
#define kPandaClassUrlString @"http://api.m.panda.tv/index.php?method=category.list&type=game&__version=2.0.1.1339&__plat=ios"
#define kPandaRecommendUrlString @"http://api.m.panda.tv/index.php?method=room.alllist&pageno=%ld&pagenum=%ld"

#define kPandaClassListUrlString @"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=%@&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=2.0.1.1339&__plat=ios"


#define kRecreationTitleListUrlString @"http://api.m.panda.tv/index.php?method=category.list&type=yl&__plat=iOS&__vesion=2.0.1.1339&__version=2.0.1.1339&__plat=ios"

#define kPandaAllUrlString @"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=2.0.1.1339&__plat=ios"

#endif /* Config_h */
