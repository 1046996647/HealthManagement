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
#import "AppDelegate.h"
#import "LZQTimerLabel.h"
#import "NSStringExt.h"
#import "CAAnimation+HCAnimation.h"



@interface SportVC ()<PXLineChartViewDelegate,LZQTimerLabelDelegate>

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

@property (nonatomic,strong)LZQTimerLabel *oneLabel;


// -----------统计图-----------------
@property (nonatomic, strong) PXLineChartView *pXLineChartView;

@property (nonatomic, strong) NSArray *lines;//line count
@property (nonatomic, strong) NSArray *xElements;//x轴数据
@property (nonatomic, strong) NSArray *yElements;//y轴数据

@property(nonatomic,strong)CMPedometer *pedometer;


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
    
    // 灰色条
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view1];
    
    // -----------运动-----------------
    UIButton *sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sportBtn.frame = CGRectMake((kScreen_Width-350/2.0*scaleWidth)/2.0, view1.bottom+20, scaleWidth*350/2.0, scaleWidth*350/2.0);
    [sportBtn setImage:[UIImage imageNamed:@"lan"] forState:UIControlStateNormal];
    [sportBtn addTarget:self action:@selector(sportAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:sportBtn];
    
    [CAAnimation showScaleAnimationInView:sportBtn Repeat:1 Autoreverses:NO FromValue:0.0 ToValue:1.0 Duration:1.0];



    
    UIView *sportView = [[UIView alloc] initWithFrame:CGRectMake((sportBtn.width-80)/2.0, (sportBtn.height-80)/2.0, 80, 80)];
//    sportView.center = sportBtn.center;
    sportView.userInteractionEnabled = NO;
//    sportView.backgroundColor = [UIColor redColor];
    [sportBtn addSubview:sportView];
    
    UIImageView *sportImg = [[UIImageView alloc] initWithFrame:CGRectMake((sportView.width-24)/2.0-10-24, -5, 48/2, 54/2)];
    sportImg.image = [UIImage imageNamed:@"sport_2"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [sportView addSubview:sportImg];
    
    
    
    _sportLab = [[UILabel alloc] initWithFrame:CGRectMake(sportImg.right+5, sportImg.center.y-7.5, 100, 15)];
    _sportLab.font = [UIFont boldSystemFontOfSize:14];
    _sportLab.text = @"尚未运动";
    _sportLab.textAlignment = NSTextAlignmentLeft;
    //        _lab5.textColor = [UIColor grayColor];
    [sportView addSubview:_sportLab];
    
    _startLab = [[UILabel alloc] initWithFrame:CGRectMake((sportView.width-sportBtn.width)/2.0, sportImg.bottom+16, sportBtn.width, 32)];
    _startLab.font = [UIFont boldSystemFontOfSize:30];
    _startLab.text = @"点击开始";
//    _startLab.userInteractionEnabled = YES;
    _startLab.textAlignment = NSTextAlignmentCenter;
    _startLab.textColor = [UIColor colorWithHexString:@"#4F5152"];
    [sportView addSubview:_startLab];
    
    _stepLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _startLab.bottom+18, sportView.width, 15)];
    _stepLab.font = [UIFont boldSystemFontOfSize:14];
    _stepLab.text = @"步数";
    _stepLab.textAlignment = NSTextAlignmentCenter;
    _stepLab.textColor = [UIColor grayColor];
    [sportView addSubview:_stepLab];
    
    
    // -----------时间-----------------
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(sportBtn.center.x-30-scaleWidth*282/2.0, sportBtn.center.y+10, scaleWidth*282/2.0, scaleWidth*282/2.0);
    [timeBtn setImage:[UIImage imageNamed:@"yew"] forState:UIControlStateNormal];
    //    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView insertSubview:timeBtn atIndex:0];
    self.timeBtn = timeBtn;
    
    [CAAnimation showScaleAnimationInView:timeBtn Repeat:1 Autoreverses:NO FromValue:0.0 ToValue:1.0 Duration:1.5];

    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake((timeBtn.width-80)/2.0, (timeBtn.height-80)/2.0, 80, 80)];
    //    sportView.backgroundColor = [UIColor redColor];
    [timeBtn addSubview:timeView];
    
    UIImageView *timeImg = [[UIImageView alloc] initWithFrame:CGRectMake((timeView.width-54/2)/2.0, 0, 54/2, 27)];
    timeImg.image = [UIImage imageNamed:@"sport_4"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [timeView addSubview:timeImg];
    
    
    _timeLab1 = [[UILabel alloc] initWithFrame:CGRectMake((timeView.width-timeBtn.width)/2.0, timeImg.bottom+11, timeBtn.width, 29)];
    _timeLab1.font = [UIFont boldSystemFontOfSize:14];
//    _timeLab1.text = @"103 min";
    _timeLab1.textAlignment = NSTextAlignmentCenter;
    _timeLab1.textColor = [UIColor grayColor];
    [timeView addSubview:_timeLab1];
    
    NSMutableAttributedString *attr = [NSString text:@"0" fullText:[NSString stringWithFormat:@"%@ min",@"0"] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
    _timeLab1.attributedText = attr;
    
    _timeLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _timeLab1.bottom+11, timeView.width, 15)];
    _timeLab2.font = [UIFont boldSystemFontOfSize:14];
    _timeLab2.text = @"时间";
    _timeLab2.textAlignment = NSTextAlignmentCenter;
    _timeLab2.textColor = [UIColor grayColor];
    [timeView addSubview:_timeLab2];
    
    // -----------距离-----------------
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disBtn.frame = CGRectMake(sportBtn.center.x+40, sportBtn.center.y, scaleWidth*264/2.0, scaleWidth*264/2.0);
    [disBtn setImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    //    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView insertSubview:disBtn atIndex:0];
    
    [CAAnimation showScaleAnimationInView:disBtn Repeat:1 Autoreverses:NO FromValue:0.0 ToValue:1.0 Duration:2.0];

    
    UIView *disView = [[UIView alloc] initWithFrame:CGRectMake((disBtn.width-80)/2.0, (disBtn.height-80)/2.0, 80, 80)];
    //    sportView.backgroundColor = [UIColor redColor];
    [disBtn addSubview:disView];
    
    UIImageView *disImg = [[UIImageView alloc] initWithFrame:CGRectMake((disView.width-33)/2.0, 0, 33, 23)];
    disImg.image = [UIImage imageNamed:@"sport_3"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [disView addSubview:disImg];
    
    
    _disLab1 = [[UILabel alloc] initWithFrame:CGRectMake((disView.width-disBtn.width)/2.0, disImg.bottom+11, disBtn.width, 26)];
    _disLab1.font = [UIFont boldSystemFontOfSize:14];
//    _disLab1.text = @"23 km";
    _disLab1.textAlignment = NSTextAlignmentCenter;
    _disLab1.textColor = [UIColor grayColor];
    [disView addSubview:_disLab1];
    
    attr = [NSString text:@"0" fullText:[NSString stringWithFormat:@"%@ km",@"0"] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
    _disLab1.attributedText = attr;

    
    _disLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _disLab1.bottom+11, disView.width, 15)];
    _disLab2.font = [UIFont boldSystemFontOfSize:14];
    _disLab2.text = @"距离";
    _disLab2.textAlignment = NSTextAlignmentCenter;
    _disLab2.textColor = [UIColor grayColor];
    [disView addSubview:_disLab2];
    
    // 灰色条
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, timeBtn.bottom+30, kScreen_Width, 6)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view2];
    self.view2 = view2;
    
    // 计时器
    _oneLabel = [[LZQTimerLabel alloc] initWithLabel:nil andTimerType:LZQTimerLabelTypeWithNormal withDelegate:self];
    
    // 统计图
    [self initRecordView];
}

// 统计图
- (void)initRecordView
{
    UIImageView *recordImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, self.view2.bottom+12, 18, 20)];
    recordImg.image = [UIImage imageNamed:@"sport_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:recordImg];
    
    NSArray *items = @[@"日",@"月",@"年"];
    //创建分段控件实例
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:items]; //用文字数组初始化
    sc.frame = CGRectMake((kScreen_Width-180)/2, recordImg.center.y-10, 180, 18);
    sc.layer.masksToBounds = YES;               //    默认为no，不设置则下面一句无效
    sc.layer.cornerRadius = sc.height/2-2;               //    设置圆角大小，同UIView
    sc.layer.borderWidth = 1;                   //    边框宽度，重新画边框，若不重新画，可能会出现圆角处无边框的情况
    sc.layer.borderColor = [UIColor colorWithHexString:@"59A43A"].CGColor; //     边框颜色
    sc.tintColor = [UIColor colorWithHexString:@"#59A43A"];
    sc.selectedSegmentIndex = 0;
    [self.scrollView addSubview:sc];
    [sc addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    
    _pXLineChartView = [[PXLineChartView alloc] initWithFrame:CGRectMake(-25, sc.bottom, kScreen_Width, 250)];
    _pXLineChartView.delegate = self;
//    _pXLineChartView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_pXLineChartView];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, _pXLineChartView.bottom+12);
    
    _xElements = @[@"6.27",@"6.28",@"6.29",@"6.30",@"7.1",@"7.2",@"7.3"];
    _yElements = @[@"1000",@"2000",@"3000",@"4000",@"5000"];
    
    self.lines = [self lines:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", Index);

    switch (Index)
    {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;

        default:
            
            break;
    }
    
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
    
    NSArray *pointsArr1 = @[@{@"xValue" : @"6.27", @"yValue" : @"500"},
                            @{@"xValue" : @"6.28", @"yValue" : @"2200"},
                            @{@"xValue" : @"6.29", @"yValue" : @"3000"},
                            @{@"xValue" : @"6.30", @"yValue" : @"3750"},
                            @{@"xValue" : @"7.1", @"yValue" : @"3800"},
                            @{@"xValue" : @"7.2", @"yValue" : @"5000"},
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
             firstYAsOrigin : @0,
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
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    return label;
}
//每条line对应的point数组
- (NSArray<id<PointItemProtocol>> *)plotsOflineIndex:(NSUInteger)lineIndex {
    return self.lines[lineIndex];
}
////点击point回调响应
//- (void)elementDidClickedWithPointSuperIndex:(NSUInteger)superidnex pointSubIndex:(NSUInteger)subindex {
//    PointItem *item = self.lines[superidnex][subindex];
//    NSString *xTitle = item.time;
//    NSString *yTitle = item.price;
//    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:yTitle
//                                                                       message:[NSString stringWithFormat:@"x：%@ \ny：%@",xTitle,yTitle] preferredStyle:UIAlertControllerStyleAlert];
//    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    [self presentViewController:alertView animated:YES completion:nil];
//}

// 开始运动
- (void)sportAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        // 开始计时
        [_oneLabel start];

        
        _sportLab.text = @"正在运动";
        
        _startLab.text = @"0";
        _startLab.textColor = [UIColor colorWithHexString:@"#58B6DA"];
        
        NSMutableAttributedString *attr = [NSString text:@"0" fullText:[NSString stringWithFormat:@"%@ min",@"0"] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
        _timeLab1.attributedText = attr;
        
        attr = [NSString text:@"0" fullText:[NSString stringWithFormat:@"%@ km",@"0"] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
        _disLab1.attributedText = attr;


        [self  gotoOpenStepCountFunction];
        
    }else{
        
        // 运动结束
        [_oneLabel pause];

        _sportLab.text = @"今日运动";
        [self gotoCloseStepCountFucntion];
        
    }
}


-(void)gotoOpenStepCountFunction{
    
    _pedometer = [[AppDelegate share ] sharedPedometer];
    
    if ([CMPedometer isStepCountingAvailable]) {
        [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error====%@",error);

                
            }else {
                NSLog(@"BBB步数====%@",pedometerData.numberOfSteps);
                NSLog(@"BBB距离====%@",pedometerData.distance);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    _startLab.text = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
                    
                    NSMutableAttributedString *attr = [NSString text:[NSString stringWithFormat:@"%.1f",pedometerData.distance.floatValue/1000] fullText:[NSString stringWithFormat:@"%.1f km",pedometerData.distance.floatValue/1000] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
                    _disLab1.attributedText = attr;
                    
                });


            }
            
        }];
        
    }else{
        
        NSLog(@"计步器不可用");
        
    }
    
    
}

-(void)gotoCloseStepCountFucntion{
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        _pedometer = [[AppDelegate share] sharedPedometer];
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"startStepCount"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        [_pedometer stopPedometerUpdates];
        
    }
    
}

#pragma mark - LZQTimerLabelDelegate
//定时器更新的时间
- (void)updateTimer:(NSString *)date
{
    NSLog(@"-----%@",date);// 停止后会变为0
    NSMutableAttributedString *attr = [NSString text:date fullText:[NSString stringWithFormat:@"%@ min",date] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
    _timeLab1.attributedText = attr;
}



@end
