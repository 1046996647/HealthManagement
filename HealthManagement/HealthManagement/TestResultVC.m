//
//  TestResultVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "TestResultVC.h"
#import "AppDelegate.h"

@interface TestResultVC ()

@property (nonatomic,strong) UIScrollView *scrollView;


@end

@implementation TestResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 15, kScreen_Width, kScreen_Height-49-15)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width-20, 0)];
    view.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-294/2)/2, 30, 294/2, 294/2)];
    baseImg.image = [UIImage imageNamed:@"result_2"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:baseImg];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, baseImg.bottom+76/2, kScreen_Width, 21)];
    titleLab.text = @"您的体质是";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:20];
//    titleLab.backgroundColor = [UIColor whiteColor];
    [view addSubview:titleLab];
    
    UILabel *titleLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLab.bottom+46/2, kScreen_Width, 36)];
    titleLab1.text = @"痰湿质";
    titleLab1.textAlignment = NSTextAlignmentCenter;
    titleLab1.font = [UIFont systemFontOfSize:35];
    titleLab1.textColor = [UIColor colorWithHexString:@"#FE0400"];
    //    titleLab.backgroundColor = [UIColor whiteColor];
    [view addSubview:titleLab1];
    
    NSString *strText = @"   痰湿体质是指当人体脏腑功能失调，易引起气血津液运化失调，水湿停聚，聚湿成痰而成痰湿内蕴表现，常表现为体形肥胖，腹部肥满，胸闷，痰多，容易困倦，身重不爽，喜食肥甘醇酒，舌体胖大，舌苔白腻";
    
    // 计算高度
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    CGSize size = [strText boundingRectWithSize:CGSizeMake(kScreen_Width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    // 设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:15];//行距的大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, strText.length)];
    
    UILabel *contenLab = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLab1.bottom+60/2, view.width-20, size.height)];
//    contenLab.text = strText;
    contenLab.numberOfLines = 0;
//    contenLab.textAlignment = NSTextAlignmentCenter;
    contenLab.font = [UIFont systemFontOfSize:14];
    contenLab.textColor = [UIColor colorWithHexString:@"#696969"];
    //    titleLab.backgroundColor = [UIColor whiteColor];
    [view addSubview:contenLab];
    contenLab.attributedText = attributedString;
    [contenLab sizeToFit];

    
    view.height = contenLab.bottom+22;
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(60, view.bottom+52/2, kScreen_Width-120, 86/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"进入首页" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [self.scrollView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];

    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, enterBtn.bottom+40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:nil];
    
    //    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    TabBarController *tabVC = [[TabBarController alloc] init];
//    delegate.window.rootViewController = tabVC;
}

// 重写
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
