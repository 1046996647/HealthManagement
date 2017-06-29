//
//  RCTabBarController.m
//  ChangeLanguage
//
//  Created by RongCheng on 16/7/21.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

#import "HomeVC.h"
#import "NearbyRestaurantVC.h"
#import "DietRecommendationVC.h"
#import "SportSleepVC.h"
#import "PersonalCenterVC.h"

@interface TabBarController ()

@end

@implementation TabBarController
+ (void)initialize{
   /**
    * 设置 TabBarItem的字体大小与颜色，可参考UIButton
    */
    
    NSMutableDictionary * tabDic=[NSMutableDictionary dictionary];
    tabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    tabDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedTabDic=[NSMutableDictionary dictionary];
    selectedTabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedTabDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#9f70c0"];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:tabDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedTabDic forState:(UIControlStateSelected)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setChildViewController:[[HomeVC alloc]init] Title:@"首页" Image:@"附近" SelectedImage:@"附近S"];
    [self setChildViewController:[[NearbyRestaurantVC alloc]init] Title:@"附近餐厅" Image:@"好友" SelectedImage:@"好友S"];
    [self setChildViewController:[[DietRecommendationVC alloc]init] Title:@"饮食推荐" Image:@"消息" SelectedImage:@"消息S"];
    [self setChildViewController:[[SportSleepVC alloc]init] Title:@"运动睡眠" Image:@"我的" SelectedImage:@"我的S"];
    [self setChildViewController:[[SportSleepVC alloc]init] Title:@"个人中心" Image:@"我的" SelectedImage:@"我的S"];
 
    
}
- (void)selectController:(NSInteger)index{
    self.selectedIndex=index;
}

/**
 *  初始化控制器
 */
- (void)setChildViewController:(UIViewController*)childVC Title:(NSString*)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage
{
    /**
     *  添加 tabBarItem 上的文字和图片
     */
    childVC.tabBarItem.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
//    [nav didMoveToParentViewController:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
