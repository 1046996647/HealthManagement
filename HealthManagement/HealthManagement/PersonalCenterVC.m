//
//  PersonalCenterVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "SettingVC.h"
#import "BodyTestVC.h"
#import "PreferenceVC.h"
#import "BodyDataVC.h"

@interface PersonalCenterVC ()

@property (nonatomic,strong) UIScrollView *scrollView;


@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.scrollView addSubview:view];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, view.bottom+10, 156/2, 156/2)];
    headImg.image = [UIImage imageNamed:@"head"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:headImg];
    
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(headImg.right+12, view.bottom+24, 60, 15)];
    userNameLab.font = [UIFont boldSystemFontOfSize:14];
    userNameLab.text = @"zcz123";
    //        _lab1.textColor = [UIColor grayColor];
    [self.scrollView addSubview:userNameLab];
    
    UIImageView *bodyImg = [[UIImageView alloc] initWithFrame:CGRectMake(userNameLab.right, userNameLab.center.y-6, 33, 12)];
    bodyImg.image = [UIImage imageNamed:@"temperament_3"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:bodyImg];
    
    NSArray *imgArr = @[@"male",@"age_male",@"height_male",@"weight_male"];
    
    UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake(userNameLab.left, userNameLab.bottom+20, 16, 16)];
    sexImg.image = [UIImage imageNamed:imgArr[0]];
    [self.scrollView addSubview:sexImg];
    
    UILabel *sexLab = [[UILabel alloc] initWithFrame:CGRectMake(sexImg.right+3, sexImg.center.y-7, 20, 15)];
    sexLab.font = [UIFont systemFontOfSize:13];
    sexLab.text = @"男";
//    sexLab.backgroundColor = [UIColor redColor];
    sexLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.scrollView addSubview:sexLab];
    
    UIImageView *yearImg = [[UIImageView alloc] initWithFrame:CGRectMake(sexLab.right+15*scaleWidth, sexImg.top, 16, 16)];
    yearImg.image = [UIImage imageNamed:imgArr[1]];
    [self.scrollView addSubview:yearImg];
    
    UILabel *yearLab = [[UILabel alloc] initWithFrame:CGRectMake(yearImg.right+3, yearImg.center.y-7, 40, 15)];
    yearLab.font = [UIFont systemFontOfSize:13];
    yearLab.text = @"31岁";
//    yearLab.backgroundColor = [UIColor redColor];
    yearLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.scrollView addSubview:yearLab];
    
    UIImageView *heightImg = [[UIImageView alloc] initWithFrame:CGRectMake(yearLab.right+15*scaleWidth, sexImg.top, 16, 16)];
    heightImg.image = [UIImage imageNamed:imgArr[2]];
    [self.scrollView addSubview:heightImg];
    
    UILabel *heightLab = [[UILabel alloc] initWithFrame:CGRectMake(heightImg.right+3, heightImg.center.y-7, 45, 15)];
    heightLab.font = [UIFont systemFontOfSize:13];
    heightLab.text = @"176cm";
//    heightLab.backgroundColor = [UIColor redColor];
    heightLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.scrollView addSubview:heightLab];
    
    UIImageView *weightImg = [[UIImageView alloc] initWithFrame:CGRectMake(heightLab.right+15*scaleWidth, sexImg.top, 16, 16)];
    weightImg.image = [UIImage imageNamed:imgArr[3]];
    [self.scrollView addSubview:weightImg];
    
    UILabel *weightLab = [[UILabel alloc] initWithFrame:CGRectMake(weightImg.right+3, heightImg.center.y-7, 40, 15)];
    weightLab.font = [UIFont systemFontOfSize:13];
    weightLab.text = @"72kg";
//    weightLab.backgroundColor = [UIColor redColor];
    weightLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.scrollView addSubview:weightLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, headImg.bottom+10, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.scrollView addSubview:view];
    
    /////////////////
    NSString *str1 = @"生龙活虎";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"LV.%@",str1]];
    NSRange range1 = {3,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FBA200"] range:range1];
    
    UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bottom, 244/2, 31)];
    stateLab.font = [UIFont boldSystemFontOfSize:16];
    //    _lab1.backgroundColor = [UIColor cyanColor];
    stateLab.textColor = [UIColor colorWithHexString:@"#555555"];
    stateLab.attributedText = attStr;
    stateLab.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:stateLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(stateLab.right, stateLab.top+8, 1, stateLab.height-16)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.scrollView addSubview:view];
    
    str1 = @"234";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"积分%@",str1]];
    NSRange range2 = {2,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#309405"] range:range2];
    
    UILabel *jifenLab = [[UILabel alloc] initWithFrame:CGRectMake(view.right, stateLab.top, 208/2, 31)];
    jifenLab.font = [UIFont boldSystemFontOfSize:16];
    jifenLab.textAlignment = NSTextAlignmentCenter;
    //    _lab1.backgroundColor = [UIColor cyanColor];
    jifenLab.textColor = [UIColor colorWithHexString:@"#555555"];
    jifenLab.attributedText = attStr;
    [self.scrollView addSubview:jifenLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(jifenLab.right, stateLab.top+8, 1, stateLab.height-16)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.scrollView addSubview:view];
    
    str1 = @"4";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"升级还需%@积分",str1]];
    NSRange range3 = {4,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    
    UILabel *xuLab = [[UILabel alloc] initWithFrame:CGRectMake(view.right, stateLab.top, kScreen_Width-jifenLab.right, 31)];
    xuLab.textAlignment = NSTextAlignmentCenter;
    xuLab.font = [UIFont boldSystemFontOfSize:16];
    //    _lab1.backgroundColor = [UIColor cyanColor];
    xuLab.textColor = [UIColor colorWithHexString:@"#555555"];
    xuLab.attributedText = attStr;
    [self.scrollView addSubview:xuLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, xuLab.bottom, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.scrollView addSubview:view];
    
    //底部按钮
    NSArray *imgArr1 = @[@"mine_1",@"mine_2",@"mine_3"];
    NSArray *titleArr = @[@"专业版测试",@"个人偏好",@"身体数据"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *resBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resBtn.tag = i;
        resBtn.frame = CGRectMake(i*kScreen_Width/3.0, view.bottom, kScreen_Width/3.0, 170/2);
        [self.scrollView addSubview:resBtn];
        [resBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *resImgView = [[UIImageView alloc] initWithFrame:CGRectMake((resBtn.width-35)/2.0, 8, 35, 35)];
        //        imgView.backgroundColor = [UIColor redColor];
        resImgView.image = [UIImage imageNamed:imgArr1[i]];
        [resBtn  addSubview:resImgView];
        
        UILabel *resLab = [[UILabel alloc] initWithFrame:CGRectMake(0, resImgView.bottom+9, resBtn.width, 15)];
        resLab.font = [UIFont systemFontOfSize:14];
        resLab.text = titleArr[i];
        resLab.textColor = [UIColor colorWithHexString:@"#555555"];
        resLab.textAlignment = NSTextAlignmentCenter;
        [resBtn addSubview:resLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(resBtn.width, 2, 1, resBtn.height-4)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
        [resBtn addSubview:line];
        
        if (i == titleArr.count-1) {
            resImgView.frame = CGRectMake((resBtn.width-45)/2.0, 8, 45, 35);
        }


    }
    
    // 右上角按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 18, 18);
    [btn2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [btn2 addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        BodyTestVC *vc = [[BodyTestVC alloc] init];
        vc.title = @"体质测试";
        vc.tag = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        PreferenceVC *vc = [[PreferenceVC alloc] init];
        vc.title = @"个人偏好";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 2) {
        BodyDataVC *vc = [[BodyDataVC alloc] init];
        vc.title = @"身体数据";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)setAction
{
    SettingVC *vc = [[SettingVC alloc] init];
    vc.title = @"设置";
    [self.navigationController pushViewController:vc animated:YES];
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
