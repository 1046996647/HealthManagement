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
#import "SleepVC.h"
#import "DietArticleVC.h"
#import "SportVC.h"
#import "PersonalCenterVC.h"

@interface TabBarController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>


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
    selectedTabDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#59A43A"];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:tabDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedTabDic forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor colorWithHexString:@"#FEFEFE"];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.delegate = self;
    
    [self setChildViewController:[[DietArticleVC alloc]init] Title:@"饮食文章" Image:@"logo_5" SelectedImage:@"logo_6"];
    [self setChildViewController:[[SportVC alloc]init] Title:@"运动" Image:@"logo_7" SelectedImage:@"logo_8"];

    [self setChildViewController:[[HomeVC alloc]init] Title:@"首页" Image:@"" SelectedImage:@""];
    [self setChildViewController:[[SleepVC alloc]init] Title:@"睡眠" Image:@"logo_3" SelectedImage:@"logo_4"];
    
    [self setChildViewController:[[PersonalCenterVC alloc]init] Title:@"我的" Image:@"logo_9" SelectedImage:@"icon_geren"];
 
    // 首页选项
    CGFloat width = 35;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreen_Width-width)/2, 49-width-15-8, width, width);
    btn.selected = YES;
    [btn setImage:[UIImage imageNamed:@"logo_2"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"logo_1"] forState:UIControlStateSelected];
    [self.tabBar addSubview:btn];
    self.btn = btn;
    
    [self selectController:2];
    
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
    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVC];
//    nav.delegate = self;
    [self addChildViewController:nav];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    viewController = (UINavigationController
                      *)viewController.childViewControllers[0];
    if ([viewController isKindOfClass:[HomeVC class]]) {
        self.btn.selected = YES;

    }
    else {
        self.btn.selected = NO;

    }
}
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    BOOL isHomePage = [viewController isKindOfClass:[self class]];
//    
//    [navigationController setNavigationBarHidden:isHomePage animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
