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
#import "SportModel.h"

// 运动状态
#define SportState @"SportState"

// 运动步数
#define SportStep @"SportStep"

// 运动时间
#define SportTime @"SportTime"

// 运动距离
#define SportDistance @"SportDistance"

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

// 缓存数据
@property(nonatomic,copy) NSString *steps;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *distance;

// 每30分钟的数据
@property(nonatomic,assign) NSInteger intervalSteps;
@property(nonatomic,assign) float intervalDistance;
@property(nonatomic,assign) BOOL isFirst;

// 连续运动时间
@property(nonatomic,copy) NSString *date;



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
@property(nonatomic,copy)NSString *DateType;


// 测试
@property(nonatomic,strong)UILabel *lab1;
@property(nonatomic,strong)UILabel *lab2;


@end

@implementation SportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    
    
//    // 测试
//    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lab1];
//    self.lab1 = lab1;
//    
//    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lab2];
//    self.lab2 = lab2;

    
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
//    _sportLab.text = @"尚未运动";
    _sportLab.textAlignment = NSTextAlignmentLeft;
    //        _lab5.textColor = [UIColor grayColor];
    [sportView addSubview:_sportLab];
    
    _startLab = [[UILabel alloc] initWithFrame:CGRectMake((sportView.width-sportBtn.width)/2.0, sportImg.bottom+16, sportBtn.width, 32)];
    _startLab.font = [UIFont boldSystemFontOfSize:30];
//    _startLab.text = @"点击开始";
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
    
    // 检查是否不是今天
    NSDate *today = [InfoCache getValueForKey:@"today"];
    if (today) {
        if (![[NSString getUTCFormateDate:today] isEqualToString:@"今天"]) {
            
            // 清楚之前保存的日期
            [InfoCache saveValue:@(NO) forKey:@"isSave"];
            // 运动状态
            [InfoCache saveValue:@"0" forKey:SportState];
        }
        
    }
    
    // 0:停止 1:运动 2:暂停
    NSNumber *state = [InfoCache getValueForKey:SportState];
    if (state.integerValue == 0) {
        _sportLab.text = @"尚未运动";
        _startLab.text = @"点击开始";
        
        [InfoCache saveValue:@"0" forKey:SportStep];
        
        [InfoCache saveValue:@"0.0" forKey:SportDistance];
        [InfoCache saveValue:@"0" forKey:SportTime];
        
//        return;
        
    }
    else {
        
        if (state.integerValue == 1) {
            _sportLab.text = @"正在运动";

        }
        if (state.integerValue == 2) {
            _sportLab.text = @"今日运动";
        }
        
        self.steps = [InfoCache getValueForKey:SportStep];
        
        _startLab.text = self.steps;
        _startLab.textColor = [UIColor colorWithHexString:@"#58B6DA"];


    }
    
    self.time = [InfoCache getValueForKey:SportTime];
    self.distance = [InfoCache getValueForKey:SportDistance];

    NSMutableAttributedString *attr = [NSString text:self.time fullText:[NSString stringWithFormat:@"%@ min",self.time] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
    _timeLab1.attributedText = attr;
    
    attr = [NSString text:self.distance fullText:[NSString stringWithFormat:@"%@ km",self.distance] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
    _disLab1.attributedText = attr;
    
    if (state.integerValue == 1) {
        // 开始计时
        [_oneLabel start];
        
        [self  gotoOpenStepCountFunction];

    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkIsNotToday];
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
    self.DateType = @"day";
    
    _pXLineChartView = [[PXLineChartView alloc] initWithFrame:CGRectMake(-25, sc.bottom, kScreen_Width, 200*scaleWidth+25)];
    _pXLineChartView.delegate = self;
//    _pXLineChartView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_pXLineChartView];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, _pXLineChartView.bottom+12);
    
//    _xElements = @[@"6.27",@"6.28",@"6.29",@"6.30",@"7.1",@"7.2",@"7.3",@"7.4",@"7.5",@"7.6"];
    _yElements = @[@"1000",@"2000",@"3000",@"4000",@"5000"];
//    _yElements = @[@"100",@"200",@"300",@"400",@"500"];
    
    
    [self getSportList:1];

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
            self.DateType = @"day";
            [self getSportList:1];
            
            break;
        case 1:
            self.DateType = @"month";
            [self getSportList:1];

            break;
        case 2:
            self.DateType = @"year";
            [self getSportList:1];

            break;

        default:
            
            break;
    }
    
}

- (NSArray *)lines:(NSMutableArray *)arrM {

    
    NSArray *pointsArr1 = arrM;
    
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
    return @[pointss];
}

#pragma mark PXLineChartViewDelegate
//通用设置
- (NSDictionary<NSString*, NSString*> *)lineChartViewAxisAttributes {
    return @{yElementInterval : @"20",
             xElementInterval : @"50",
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

// 开始运动
- (void)sportAction:(UIButton *)btn
{
    [CAAnimation showRotateAnimationInView:btn Degree:2*M_PI Direction:AxisY Repeat:1 Autoreverses:NO Duration:1.0];
    
    // 0:停止 1:运动 2:暂停
    NSNumber *state = [InfoCache getValueForKey:SportState];
    if (state.integerValue == 0) {

        // 开始计时
        [_oneLabel start];
        
        _sportLab.text = @"正在运动";
        _startLab.text = @"0";
        _startLab.textColor = [UIColor colorWithHexString:@"#58B6DA"];
        [InfoCache saveValue:@"1" forKey:SportState];

        [self  gotoOpenStepCountFunction];
        
        // 保存今天的运动日期
        NSNumber *isSave = [InfoCache getValueForKey:@"isSave"];
        if (!isSave.boolValue) {
            [InfoCache saveValue:@(YES) forKey:@"isSave"];
            [InfoCache saveValue:[NSDate date] forKey:@"today"];
            
            // 今天是否运动过通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kIsSportedNotification" object:nil];

        }
        
    }
    if (state.integerValue == 1) {
        
        // 运动暂停
        [_oneLabel pause];
        [InfoCache saveValue:@"2" forKey:SportState];
        
        _sportLab.text = @"今日运动";
        [self gotoCloseStepCountFucntion];
        
        //        _startLab.text = @"20";
        if (_startLab.text.integerValue > 10) {
            [self upLoadSportInfo];
            
        }
        
#pragma mark - 测试用的
        [self addScoreRecord];

    }
    
    if (state.integerValue == 2) {
        
        [InfoCache saveValue:@"1" forKey:SportState];
        _sportLab.text = @"正在运动";
        [self  gotoOpenStepCountFunction];
        
        // 开始计时
        [_oneLabel start];

    }

}

// 上传运动信息
- (void)upLoadSportInfo
{
    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:_startLab.text forKey:@"steps"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:UpLoadSportInfo dic:paramDic Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        NSNumber *code = responseObject[@"HttpCode"];

        if (code.integerValue == 200) {
            
            [self getSportList:0];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}

// 获取运动信息
- (void)getSportList:(NSInteger)tag
{
    if (tag) {
        [SVProgressHUD show];

    }
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.DateType forKey:@"DateType"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetSportList dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseObject);
        NSNumber *code = responseObject[@"HttpCode"];
        
        if (code.integerValue == 200) {
            
            NSMutableArray *arrX = [NSMutableArray array];
            NSMutableArray *arrDic = [NSMutableArray array];
            
            NSArray *arr = [responseObject objectForKey:@"ListData"];
            
            for (NSDictionary *dic in arr) {
                
                SportModel *model = [SportModel yy_modelWithJSON:dic];
                
                [arrX addObject:model.date];
                
                NSDictionary *dic1 = @{@"xValue" : model.date, @"yValue" : model.steps};
                [arrDic addObject:dic1];

            }
            self.xElements = arrX;
            self.lines = [self lines:arrDic];
            
            [_pXLineChartView reloadData];


        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}

// 运动开始
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
                    
                    //---------每30分钟的数据--------
                    NSInteger step1 = pedometerData.numberOfSteps.integerValue;
                    
                    float distance1 = pedometerData.distance.floatValue;

                    if (self.date.integerValue % 2 == 0) {
                        

                        // 步数
                        NSInteger step2 = step1-self.intervalSteps;
                        
                        // 距离
                        float distance2 = distance1-self.intervalDistance;
                        
//                        // 测试
//                        self.lab1.text = [NSString stringWithFormat:@"%ld",step2];
//                        self.lab2.text = [NSString stringWithFormat:@"%.1f",distance2];
                        
                        PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];

                        if (person.sex.integerValue == 0) {// 女

                            if (step2 > 3000 && distance2 > 2700) {
                                [self addScoreRecord];
                            }
                            
                        }
                        else {
                            if (step2 > 3000 && distance2 > 3300) {
                                [self addScoreRecord];
                            }
                        }
                        
                        if (!self.isFirst) {// 为了解决一分钟之内的连续调用问题
                            self.intervalSteps = pedometerData.numberOfSteps.integerValue;
                            
                            self.intervalDistance = pedometerData.distance.floatValue;
                        }
                        
                        self.isFirst = YES;
                        
                    }
                    else {
                        self.isFirst = NO;

                    }
                    
//                    self.intervalSteps = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
//                    self.intervalDistance = @"0.0";
                    
                    //---------缓存数据--------
                    // 步数
                    NSInteger step = self.steps.integerValue+pedometerData.numberOfSteps.integerValue;
                    NSString *stepStr = [NSString stringWithFormat:@"%ld",step];
                    _startLab.text = stepStr;
                    
                    [InfoCache saveValue:stepStr forKey:SportStep];
                    
                    // 距离
                    float distance = self.distance.floatValue+(pedometerData.distance.floatValue/1000);
                    NSString *distanceStr = [NSString stringWithFormat:@"%.1f",distance];
                    
                    NSMutableAttributedString *attr = [NSString text:distanceStr fullText:[NSString stringWithFormat:@"%@ km",distanceStr] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
                    _disLab1.attributedText = attr;
                    
                    [InfoCache saveValue:distanceStr forKey:SportDistance];

                    
                });


            }
            
        }];
        
    } else {
        
        NSLog(@"计步器不可用");
        
    }
    
    
}

// 增加积分
- (void)addScoreRecord
{
    //    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:@"Sport" forKey:@"ScoreType"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:AddScoreRecord dic:paramDic Succed:^(id responseObject) {
        
        //        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        //        [SVProgressHUD dismiss];
        
    }];
}

-(void)gotoCloseStepCountFucntion{
    
    if ([CMPedometer isStepCountingAvailable]) {

    self.steps = [InfoCache getValueForKey:SportStep];
    self.time = [InfoCache getValueForKey:SportTime];
    self.distance = [InfoCache getValueForKey:SportDistance];
        
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
    self.date = date;
    if (date.integerValue == 0) {
//        NSLog(@"-----%@",date);// 停止后会变为0
        self.intervalSteps = 0;
        self.intervalDistance = 0.0;

    }
    
    NSInteger time = self.time.integerValue+date.integerValue;
    date = [NSString stringWithFormat:@"%ld",time];
    NSMutableAttributedString *attr = [NSString text:date fullText:[NSString stringWithFormat:@"%@ min",date] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
    _timeLab1.attributedText = attr;
    
    [InfoCache saveValue:date forKey:SportTime];
    
    [self checkIsNotToday];
}

- (void)checkIsNotToday
{
    // 检查是否不是今天
    NSDate *today = [InfoCache getValueForKey:@"today"];
    if (today) {
        if (![[NSString getUTCFormateDate:today] isEqualToString:@"今天"]) {
            
            //        if (date.integerValue == 1) {// 测试
            
            // 清楚之前保存的日期
            [InfoCache saveValue:@(NO) forKey:@"isSave"];
            
            // 运动暂停
            [_oneLabel pause];
            
            [self gotoCloseStepCountFucntion];
            //        _startLab.text = @"20";
            if (_startLab.text.integerValue > 10) {
                [self upLoadSportInfo];
                
            }
            
            // 运动状态
            [InfoCache saveValue:@"0" forKey:SportState];
            
            
            _sportLab.text = @"尚未运动";
            _startLab.text = @"点击开始";
            _startLab.textColor = [UIColor colorWithHexString:@"#4F5152"];
            
            [InfoCache saveValue:@"0" forKey:SportStep];
            [InfoCache saveValue:@"0.0" forKey:SportDistance];
            [InfoCache saveValue:@"0" forKey:SportTime];
            
            self.steps = [InfoCache getValueForKey:SportStep];
            self.time = [InfoCache getValueForKey:SportTime];
            self.distance = [InfoCache getValueForKey:SportDistance];
            
            NSMutableAttributedString *attr = [NSString text:self.time fullText:[NSString stringWithFormat:@"%@ min",self.time] location:0 color:[UIColor colorWithHexString:@"#F89532"] font:[UIFont boldSystemFontOfSize:28]];
            _timeLab1.attributedText = attr;
            
            attr = [NSString text:self.distance fullText:[NSString stringWithFormat:@"%@ km",self.distance] location:0 color:[UIColor colorWithHexString:@"#E966BD"] font:[UIFont boldSystemFontOfSize:25]];
            _disLab1.attributedText = attr;
        }
        
    }

}

@end
