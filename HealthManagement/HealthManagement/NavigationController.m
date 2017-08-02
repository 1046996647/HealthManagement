//
//  RCNavigationController.m
//  ChangeLanguage
//
//  Created by RongCheng on 16/7/21.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController
/**
 *  初始化
 */

+ (void)initialize{
    
    
    /**
     *  设置 UINavigationBar
     */
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    bar.barTintColor = [UIColor whiteColor];
    //消除底部横线
//    [bar setShadowImage:[[UIImage alloc] init]];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBW"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置字体
//    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#59A43A"]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  重写push方法
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        /**
         *  设置默认的"< 返回 "
         */
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
////        [button setTitle:@"返回" forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
////        [button setImage:[UIImage imageNamed:@"navigationReturnClick"] forState:UIControlStateHighlighted];
//        CGRect frame = button.frame;
//        frame.size = CGSizeMake(30, 20);
//        button.frame = frame;
//        
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
////        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];

}
//- (void)back{
//    [self popViewControllerAnimated:YES];
//}
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
