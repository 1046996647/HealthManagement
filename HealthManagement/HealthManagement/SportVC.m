//
//  DietRecommendationVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SportVC.h"

@interface SportVC ()

// -----------运动-----------------
@property(nonatomic,strong) UILabel *sportLab;
@property(nonatomic,strong) UILabel *startLab;
@property(nonatomic,strong) UILabel *stepLab;

// -----------时间-----------------
@property(nonatomic,strong) UILabel *timeLab1;
@property(nonatomic,strong) UILabel *timeLab2;
@property(nonatomic,strong) UIButton *timeBtn;


// -----------距离-----------------
@property(nonatomic,strong) UILabel *disLab1;
@property(nonatomic,strong) UILabel *disLab2;

// -----------其他-----------------
@property(nonatomic,strong) UIView *view2;



@end

@implementation SportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    // -----------运动-----------------
    UIButton *sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sportBtn.frame = CGRectMake((kScreen_Width-120*scaleX)/2.0, 20, scaleX*120, scaleX*120);
    [sportBtn setImage:[UIImage imageNamed:@"lan"] forState:UIControlStateNormal];
//    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:sportBtn];
    
    UIView *sportView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    sportView.center = sportBtn.center;
//    sportView.backgroundColor = [UIColor redColor];
    [baseView addSubview:sportView];
    
    UIImageView *sportImg = [[UIImageView alloc] initWithFrame:CGRectMake((sportView.width-16)/2.0-10-16, 0, 16, 16)];
    sportImg.image = [UIImage imageNamed:@"sport_2"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [sportView addSubview:sportImg];
    
    _sportLab = [[UILabel alloc] initWithFrame:CGRectMake(sportImg.right+5, sportImg.center.y-7, 50, 14)];
    _sportLab.font = [UIFont systemFontOfSize:12];
    _sportLab.text = @"尚未运动";
    _sportLab.textAlignment = NSTextAlignmentLeft;
    //        _lab5.textColor = [UIColor grayColor];
    [sportView addSubview:_sportLab];
    
    _startLab = [[UILabel alloc] initWithFrame:CGRectMake(0, sportImg.bottom+15, sportView.width, 20)];
    _startLab.font = [UIFont systemFontOfSize:18];
    _startLab.text = @"点击开始";
    _startLab.textAlignment = NSTextAlignmentCenter;
    //        _lab5.textColor = [UIColor grayColor];
    [sportView addSubview:_startLab];
    
    _stepLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _startLab.bottom+15, sportView.width, 14)];
    _stepLab.font = [UIFont systemFontOfSize:12];
    _stepLab.text = @"步数";
    _stepLab.textAlignment = NSTextAlignmentCenter;
    _stepLab.textColor = [UIColor grayColor];
    [sportView addSubview:_stepLab];
    
    // -----------时间-----------------
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(sportBtn.center.x-30-scaleX*100, sportBtn.center.y+10, scaleX*100, scaleX*100);
    [timeBtn setImage:[UIImage imageNamed:@"yew"] forState:UIControlStateNormal];
    //    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [baseView insertSubview:timeBtn atIndex:0];
    self.timeBtn = timeBtn;
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    timeView.center = timeBtn.center;
    //    sportView.backgroundColor = [UIColor redColor];
    [baseView addSubview:timeView];
    
    UIImageView *timeImg = [[UIImageView alloc] initWithFrame:CGRectMake((timeView.width-16)/2.0, 0, 16, 16)];
    timeImg.image = [UIImage imageNamed:@"sport_4"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [timeView addSubview:timeImg];
    
    NSString *str1 = @"103";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ min",str1]];
    NSRange range1 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F89532"] range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:16.0]
     
                          range:range1];
    
    _timeLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, timeImg.bottom+15, timeView.width, 18)];
    _timeLab1.font = [UIFont systemFontOfSize:12];
//    _timeLab1.text = @"103 min";
    _timeLab1.textAlignment = NSTextAlignmentCenter;
    _timeLab1.textColor = [UIColor grayColor];
    [timeView addSubview:_timeLab1];
    _timeLab1.attributedText = attStr;
    
    _timeLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _timeLab1.bottom+15, timeView.width, 14)];
    _timeLab2.font = [UIFont systemFontOfSize:12];
    _timeLab2.text = @"时间";
    _timeLab2.textAlignment = NSTextAlignmentCenter;
    _timeLab2.textColor = [UIColor grayColor];
    [timeView addSubview:_timeLab2];
    
    // -----------距离-----------------
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disBtn.frame = CGRectMake(sportBtn.center.x+30, sportBtn.center.y, scaleX*90, scaleX*90);
    [disBtn setImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    //    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [baseView insertSubview:disBtn atIndex:0];
    
    UIView *disView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    disView.center = disBtn.center;
    //    sportView.backgroundColor = [UIColor redColor];
    [baseView addSubview:disView];
    
    UIImageView *disImg = [[UIImageView alloc] initWithFrame:CGRectMake((disView.width-25)/2.0, 0, 25, 16)];
    disImg.image = [UIImage imageNamed:@"sport_3"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [disView addSubview:disImg];
    
    str1 = @"25";
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ km",str1]];
//    NSRange range1 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#E966BD"] range:range1];
    
    _disLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, disImg.bottom+15, disView.width, 18)];
    _disLab1.font = [UIFont systemFontOfSize:12];
    _disLab1.text = @"23 km";
    _disLab1.textAlignment = NSTextAlignmentCenter;
    _disLab1.textColor = [UIColor grayColor];
    [disView addSubview:_disLab1];
    
    _disLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _disLab1.bottom+15, disView.width, 14)];
    _disLab2.font = [UIFont systemFontOfSize:12];
    _disLab2.text = @"时间";
    _disLab2.textAlignment = NSTextAlignmentCenter;
    _disLab2.textColor = [UIColor grayColor];
    [disView addSubview:_disLab2];
    
    // 灰色条
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, timeBtn.bottom+30, kScreen_Width, 10)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.view addSubview:view2];
    self.view2 = view2;
    
    // 统计图
    [self initRecordView];
}

// 统计图
- (void)initRecordView
{
    UIImageView *recordImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, self.view2.bottom+12, 20, 20)];
    recordImg.image = [UIImage imageNamed:@"sport_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:recordImg];
    
    NSArray *items = @[@"日",@"月",@"年"];
    //创建分段控件实例
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:items]; //用文字数组初始化
    sc.frame = CGRectMake((kScreen_Width-200)/2, recordImg.center.y-15, 200, 30);
    sc.tintColor = [UIColor colorWithHexString:@"#59A43A"];
    [self.view addSubview:sc];
    

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
