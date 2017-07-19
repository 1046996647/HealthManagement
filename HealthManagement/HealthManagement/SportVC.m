//
//  DietRecommendationVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SportVC.h"
#import "PXLineChartView.h"
#import "PointItem.h"
@interface SportVC ()<PXLineChartViewDelegate>

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
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *view2;

// -----------统计图-----------------
@property (nonatomic, strong) PXLineChartView *pXLineChartView;

@property (nonatomic, strong) NSArray *lines;//line count
@property (nonatomic, strong) NSArray *xElements;//x轴数据
@property (nonatomic, strong) NSArray *yElements;//y轴数据

@end

@implementation SportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // -----------运动-----------------
    UIButton *sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sportBtn.frame = CGRectMake((kScreen_Width-120*scaleX)/2.0, 20, scaleX*120, scaleX*120);
    [sportBtn setImage:[UIImage imageNamed:@"lan"] forState:UIControlStateNormal];
//    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:sportBtn];
    
    UIView *sportView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    sportView.center = sportBtn.center;
//    sportView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:sportView];
    
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
    [scrollView insertSubview:timeBtn atIndex:0];
    self.timeBtn = timeBtn;
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    timeView.center = timeBtn.center;
    //    sportView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:timeView];
    
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
    [scrollView insertSubview:disBtn atIndex:0];
    
    UIView *disView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    disView.center = disBtn.center;
    //    sportView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:disView];
    
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
    _disLab2.text = @"距离";
    _disLab2.textAlignment = NSTextAlignmentCenter;
    _disLab2.textColor = [UIColor grayColor];
    [disView addSubview:_disLab2];
    
    // 灰色条
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, timeBtn.bottom+30, kScreen_Width, 10)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view2];
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
    [self.scrollView addSubview:recordImg];
    
    NSArray *items = @[@"日",@"月",@"年"];
    //创建分段控件实例
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:items]; //用文字数组初始化
    sc.frame = CGRectMake((kScreen_Width-200)/2, recordImg.center.y-15, 200, 30);
    sc.tintColor = [UIColor colorWithHexString:@"#59A43A"];
    [self.scrollView addSubview:sc];
    
    _pXLineChartView = [[PXLineChartView alloc] initWithFrame:CGRectMake(-25, sc.bottom, kScreen_Width, 200)];
    _pXLineChartView.delegate = self;
//    _pXLineChartView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_pXLineChartView];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, _pXLineChartView.bottom+12-64);
    
    _xElements = @[@"6.27",@"6.28",@"6.29",@"6.30",@"7.1",@"7.2",@"7.3"];
    _yElements = @[@"1000",@"2000",@"3000",@"4000",@"5000"];
    
    self.lines = [self lines:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)lines:(BOOL)fill {
    //    NSArray *pointsArr1 = @[@{@"xValue" : @"16-2", @"yValue" : @"1000"},
    //                           @{@"xValue" : @"16-4", @"yValue" : @"2000"},
    //                           @{@"xValue" : @"16-6", @"yValue" : @"1700"},
    //                           @{@"xValue" : @"16-8", @"yValue" : @"3100"},
    //                           @{@"xValue" : @"16-9", @"yValue" : @"3500"},
    //                           @{@"xValue" : @"16-12", @"yValue" : @"3400"},
    //                           @{@"xValue" : @"17-02", @"yValue" : @"1100"},
    //                           @{@"xValue" : @"17-04", @"yValue" : @"1500"}];
    
    NSArray *pointsArr1 = @[@{@"xValue" : @"6.27", @"yValue" : @"2000"},
                            @{@"xValue" : @"6.28", @"yValue" : @"2200"},
                            @{@"xValue" : @"6.29", @"yValue" : @"3000"},
                            @{@"xValue" : @"6.30", @"yValue" : @"3750"},
                            @{@"xValue" : @"7.1", @"yValue" : @"3800"},
                            @{@"xValue" : @"7.2", @"yValue" : @"4000"},
                            @{@"xValue" : @"7.3", @"yValue" : @"2000"}];
    
    //    NSMutableArray *points = @[].mutableCopy;
    //    for (int i = 0; i < pointsArr.count; i++) {
    //        PointItem *item = [[PointItem alloc] init];
    //        NSDictionary *itemDic = pointsArr[i];
    //        item.price = itemDic[@"yValue"];
    //        item.time = itemDic[@"xValue"];
    //        item.chartLineColor = [UIColor redColor];
    //        item.chartPointColor = [UIColor redColor];
    //        item.pointValueColor = [UIColor redColor];
    ////        if (fill) {
    ////            item.chartFillColor = [UIColor colorWithRed:0 green:0.5 blue:0.2 alpha:0.5];
    ////            item.chartFill = YES;
    ////        }
    //        [points addObject:item];
    //    }
    
    NSMutableArray *pointss = @[].mutableCopy;
    for (int i = 0; i < pointsArr1.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr1[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = [UIColor colorWithRed:0.2 green:1 blue:0.7 alpha:1];
        item.chartPointColor = [UIColor whiteColor];
        item.pointValueColor = [UIColor blackColor];
        //        if (fill) {
        //            item.chartFillColor = [UIColor colorWithRed:0.5 green:0.1 blue:0.8 alpha:0.5];
        //            item.chartFill = YES;
        //        }
        [pointss addObject:item];
    }
    //两条line
    return @[pointss];
}

#pragma mark PXLineChartViewDelegate
//通用设置
- (NSDictionary<NSString*, NSString*> *)lineChartViewAxisAttributes {
    return @{yElementInterval : @"40",
             xElementInterval : @"40",
             yMargin : @"50",
             xMargin : @"25",
             yAxisColor : [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1],
             xAxisColor : [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1],
             gridColor : [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1],
             gridHide : @0,
             pointHide : @0,
             pointFont : [UIFont systemFontOfSize:10],
             firstYAsOrigin : @1,
             scrollAnimation : @1,
             scrollAnimationDuration : @"2"};
}
//line count
- (NSUInteger)numberOfChartlines {
    return self.lines.count;
}
//x轴y轴对应的元素count
- (NSUInteger)numberOfElementsCountWithAxisType:(AxisType)axisType {
    return (axisType == AxisTypeY)? _yElements.count : _xElements.count;
}
//x轴y轴对应的元素view
- (UILabel *)elementWithAxisType:(AxisType)axisType index:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] init];
    NSString *axisValue = @"";
    if (axisType == AxisTypeX) {
        axisValue = _xElements[index];
        label.textAlignment = NSTextAlignmentCenter;//;
    }else if(axisType == AxisTypeY){
        axisValue = _yElements[index];
        label.textAlignment = NSTextAlignmentRight;//;
    }
    label.text = axisValue;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    return label;
}
//每条line对应的point数组
- (NSArray<id<PointItemProtocol>> *)plotsOflineIndex:(NSUInteger)lineIndex {
    return self.lines[lineIndex];
}
//点击point回调响应
- (void)elementDidClickedWithPointSuperIndex:(NSUInteger)superidnex pointSubIndex:(NSUInteger)subindex {
    PointItem *item = self.lines[superidnex][subindex];
    NSString *xTitle = item.time;
    NSString *yTitle = item.price;
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:yTitle
                                                                       message:[NSString stringWithFormat:@"x：%@ \ny：%@",xTitle,yTitle] preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertView animated:YES completion:nil];
}

//static bool fill = NO;
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    fill = !fill;
//    self.lines = [self lines:fill];
//    [_pXLineChartView reloadData];
//}


@end
