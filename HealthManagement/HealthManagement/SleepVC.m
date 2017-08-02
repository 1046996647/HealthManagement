//
//  SportSleepVc.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SleepVC.h"
#import "HealthManagement-Swift.h"
#import "ZWLSlider.h"
#import "SleepModel.h"
#import "NSStringExt.h"
#import "SleepSettingVC.h"


#define ClockPath @"ClockPath"

@interface SleepVC ()<UIGestureRecognizerDelegate,TenClockDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) TenClock *clock;
@property (nonatomic,strong) UILabel *sleepLab2;
@property (nonatomic,strong) UILabel *upLabel1;
@property (nonatomic,strong) UILabel *timeTotalLab;
@property (nonatomic,strong) SleepModel *model;
@property (nonatomic,strong) UILabel *weekLab;
@property (nonatomic,strong) UIView *view3;
@property (nonatomic,strong) UILabel *startLab;
@property (nonatomic,strong) UILabel *endLab;


//@property(nonatomic,strong) UIButton *lastBtn;




@end

@implementation SleepVC

- (SleepModel *)model
{
    // 取出闹钟本地数据
    _model = [InfoCache unarchiveObjectWithFile:ClockPath];
    if (!_model) {
        _model = [[SleepModel alloc] init];

    }
    return _model;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.userInteractionEnabled = YES;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    self.scrollView.delaysContentTouches = false;


    
    // 解决上下滑动冲突
    UIGestureRecognizer *gestur = [[UIGestureRecognizer alloc]init];
    gestur.delegate=self;
    [self.scrollView addGestureRecognizer:gestur];
    
    UILabel *sleepLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 80, 18)];
    sleepLab.font = [UIFont systemFontOfSize:17];
    sleepLab.text = @"睡眠";
    sleepLab.textAlignment = NSTextAlignmentLeft;
    sleepLab.textColor = [UIColor blackColor];
    [self.scrollView addSubview:sleepLab];
    
    UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake(sleepLab.left, sleepLab.bottom+10, 250, 16)];
    weekLab.font = [UIFont systemFontOfSize:13];
//    weekLab.text = @"周一 周二";
    weekLab.textAlignment = NSTextAlignmentLeft;
    weekLab.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.scrollView addSubview:weekLab];
    self.weekLab = weekLab;
    
    // 打开或关闭闹钟
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(kScreen_Width-42-12, sleepLab.top+10, 42, 24);
    [setBtn setImage:[UIImage imageNamed:@"setGray"] forState:UIControlStateNormal];
    [setBtn setImage:[UIImage imageNamed:@"setGreen"] forState:UIControlStateSelected];

    [setBtn addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:setBtn];
    setBtn.selected = self.model.isOpen;

    [self setWeekMethod];


    // 灰色条
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, weekLab.bottom+7, kScreen_Width, 6)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view2];
    
    // 就寝
    UIImageView *sleepImg = [[UIImageView alloc] initWithFrame:CGRectMake(60, view2.bottom+25, 30, 30)];
    sleepImg.image = [UIImage imageNamed:@"sleep_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:sleepImg];
    
    UILabel *sleepLab1 = [[UILabel alloc] initWithFrame:CGRectMake(sleepImg.right+10, sleepImg.center.y-11, 80, 22)];
    sleepLab1.font = [UIFont systemFontOfSize:21];
    sleepLab1.text = @"就寝";
    sleepLab1.textAlignment = NSTextAlignmentLeft;
    sleepLab1.textColor = [UIColor blackColor];
    [self.scrollView addSubview:sleepLab1];
    
    UILabel *sleepLab2 = [[UILabel alloc] initWithFrame:CGRectMake(sleepImg.left, sleepLab1.bottom+15, 100, 35)];
    sleepLab2.font = [UIFont systemFontOfSize:34];
    sleepLab2.text = @"23:00";
    sleepLab2.textAlignment = NSTextAlignmentLeft;
    sleepLab2.textColor = [UIColor colorWithHexString:@"59A43A"];
    [self.scrollView addSubview:sleepLab2];
    self.sleepLab2 = sleepLab2;
    
    // 起床
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-50-70, sleepLab1.top, 50, 22)];
    upLabel.font = [UIFont systemFontOfSize:21];
    upLabel.text = @"起床";
    upLabel.textAlignment = NSTextAlignmentRight;
    upLabel.textColor = [UIColor blackColor];
    [self.scrollView addSubview:upLabel];
    
    UIImageView *upImg = [[UIImageView alloc] initWithFrame:CGRectMake(upLabel.left-sleepImg.width, sleepImg.top, sleepImg.width, sleepImg.width)];
    upImg.image = [UIImage imageNamed:@"icon"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:upImg];
    
    UILabel *upLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-sleepLab2.width-70, sleepLab2.top, sleepLab2.width, 35)];
    upLabel1.font = [UIFont systemFontOfSize:34];
    upLabel1.text = @"07:00";
    upLabel1.textAlignment = NSTextAlignmentRight;
    upLabel1.textColor = [UIColor colorWithHexString:@"FC801B"];
    [self.scrollView addSubview:upLabel1];
    self.upLabel1 = upLabel1;
    
    // 闹钟
    TenClock *clock = [[TenClock alloc] initWithFrame:CGRectMake((kScreen_Width-(310*scaleX))/2, upLabel1.bottom, 310*scaleX, 310*scaleX)];
    
    //    clock.startDate = Date()
    //    clock.endDate = Date().addingTimeInterval(-60 * 60 * 8 )
    //    clock.update()
//    clock.backgroundColor = [UIColor redColor];
    clock.delegate = self;
    clock.startDate = [NSDate date];
    clock.endDate = [[NSDate date] dateByAddingTimeInterval:-60 * 60 * 8];
    [clock update];
    [self.scrollView addSubview:clock];
//    self.scrollView.
    
    self.clock = clock;
    
    if (_model.startDate) {
        clock.startDate = _model.startDate;
        clock.endDate = _model.endDate;
        [self dateFormatterStart:clock.startDate end:clock.endDate];

    }
    else {
        _model.startDate = [NSDate date];
        _model.endDate = [[NSDate date] dateByAddingTimeInterval:-60 * 60 * 8];
    }
    
    // 解决上下滑动冲突(有bug，慢滑手指离开不会调代理方法)
//    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBtnLoction:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.delegate=self;
    [self.clock addGestureRecognizer:tap];
    
    UIImageView *clockImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, clock.width-125, clock.width-125)];
    clockImg.image = [UIImage imageNamed:@"circle_bg"];
    clockImg.center = clock.center;
    clockImg.layer.cornerRadius = clockImg.height/2.0;
    clockImg.layer.masksToBounds = YES;
//    clockImg.backgroundColor = [UIColor redColor];

//    clockImg.userInteractionEnabled = YES;// 处理在闹钟中间滑动
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:clockImg];
    
    UIImageView *stopImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, clock.width-125-30, clock.width-125-30)];
    stopImg.center = clock.center;
    stopImg.layer.cornerRadius = stopImg.height/2.0;
    stopImg.layer.masksToBounds = YES;
//    stopImg.backgroundColor = [UIColor redColor];
    
    stopImg.userInteractionEnabled = YES;// 处理在闹钟中间滑动
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:stopImg];

    _timeTotalLab = [[UILabel alloc] initWithFrame:CGRectMake(0, (clockImg.height-35)/2.0, clockImg.width, 35)];
    _timeTotalLab.font = [UIFont systemFontOfSize:13];
//    _timeTotalLab.text = @"07:00";
    _timeTotalLab.textAlignment = NSTextAlignmentCenter;
    _timeTotalLab.textColor = [UIColor colorWithHexString:@"8E8E8E"];
    [clockImg addSubview:_timeTotalLab];
    
    // 灰色条
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, clock.bottom, kScreen_Width, view2.height)];
    view3.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view3];
    self.view3 = view3;
    
    
    // 右上角按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 18, 18);
    [btn2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [btn2 addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 睡眠分析
    [self initSleepView];

}

- (void)initSleepView
{
    UILabel *fenxiLab = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view3.bottom+10, kScreen_Width-20, 18)];
    fenxiLab.font = [UIFont systemFontOfSize:16];
    fenxiLab.text = @"睡眠分析";
    fenxiLab.textAlignment = NSTextAlignmentLeft;
    fenxiLab.textColor = [UIColor blackColor];
    [self.scrollView addSubview:fenxiLab];
    
    UILabel *startLab = [[UILabel alloc] initWithFrame:CGRectMake(10, fenxiLab.bottom+11, 35, 11)];
    startLab.font = [UIFont boldSystemFontOfSize:10];
    startLab.text = @"23:34";
    startLab.textAlignment = NSTextAlignmentLeft;
    startLab.textColor = [UIColor colorWithHexString:@"#5B5B5B"];
//    startLab.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:startLab];
    self.startLab = startLab;
    
    // 灰色条
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(startLab.right, startLab.center.y-.25, kScreen_Width-startLab.right-12, .5)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#AFAFAF"];
    [self.scrollView addSubview:line1];
    
    UILabel *endLab = [[UILabel alloc] initWithFrame:CGRectMake(10, startLab.bottom+41, startLab.width, 11)];
    endLab.font = [UIFont boldSystemFontOfSize:10];
    endLab.text = @"03:34";
    endLab.textAlignment = NSTextAlignmentLeft;
    endLab.textColor = [UIColor colorWithHexString:@"#5B5B5B"];
    //    startLab.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:endLab];
    self.endLab = endLab;
    
    [self dateFormatterStart:self.clock.startDate end:self.clock.endDate];


    
    // 灰色条
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(endLab.right, endLab.bottom-2, line1.width, .5)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#AFAFAF"];
    [self.scrollView addSubview:line2];
    
    for (int i=0; i<4; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(line1.left, line1.bottom+10+i*(1+10), line1.width, 1)];
        [self drawDashLine:line lineLength:2 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"#C3C3C3"]];
//        lineImg.backgroundColor = [UIColor redColor];
        // 添加到控制器的view上
        [self.scrollView addSubview:line];
    }
    
    NSArray *weekArr = @[@"周一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i=0; i<weekArr.count; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(line2.left+i*(line2.width/weekArr.count), line2.bottom+11, line2.width/weekArr.count, 15)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = weekArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithHexString:@"#999999"];
        //    startLab.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:lab];
        
        if (i == 0) {
            lab.textAlignment = NSTextAlignmentLeft;

        }
        if (i == weekArr.count-1) {
            lab.textAlignment = NSTextAlignmentRight;
            
        }
    }
    
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, line2.bottom+35);
}


- (void)setWeekMethod
{
    if (_model.weekDay.count) {
        NSMutableString *mStr = [NSMutableString string];
        
        NSComparator finderSort = ^(id string1,id string2){
            
            if ([string1 integerValue] > [string2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }else if ([string1 integerValue] < [string2 integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
                return (NSComparisonResult)NSOrderedSame;
        };
        
        //数组排序：
        NSArray *resultArray = [_model.weekDay sortedArrayUsingComparator:finderSort];
        
        for (NSString *weekDay in resultArray) {
            
            NSString *chNum = [NSString translationArabicNum:weekDay.integerValue];
            
            [mStr appendFormat:@"周%@ ",chNum];
        }
        self.weekLab.text = mStr;
        
    }
}


- (void)setAction
{
    SleepSettingVC *vc = [[SleepSettingVC alloc] init];
    vc.title = @"睡眠设置";
    vc.model = self.model;
    vc.settingBlock = ^{
        
        [self setWeekMethod];
        [InfoCache archiveObject:_model toFile:ClockPath];
        if (_model.isOpen) {
            
            [self createLocalNotification];
    
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}




// 打开或关闭闹钟
- (void)controlAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    _model.isOpen = btn.selected;
    [InfoCache archiveObject:_model toFile:ClockPath];

    
    if (btn.selected) {
        [self createLocalNotification];

    }
    else {
        [SleepVC shutdownClock:@"SleepID"];
        [SleepVC shutdownClock:@"WakeupID"];

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TenClockDelegate

// 时时更新
- (void)timesUpdated:(TenClock *)clock startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{

    [self dateFormatterStart:startDate end:endDate];

}

// 停止拖动更新
- (void)timesChanged:(TenClock *)clock startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{

    _model.startDate = startDate;
    _model.endDate = endDate;
    NSLog(@"------%@",startDate);
    NSLog(@"------%@",endDate);
//    [InfoCache archiveObject:_model toFile:ClockPath];
//    [self dateFormatterStart:startDate end:endDate];
    if (_model.isOpen) {
        [self createLocalNotification];
        
    }
}

- (void)timesTotal:(TenClock *)clock time:(NSInteger)time
{

    NSString *str1 = [NSString stringWithFormat:@"%ld",(time / 12)];
    NSString *str2 = [NSString stringWithFormat:@"%ld",((time % 12) * 5)];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@小时%@分钟",str1, str2]];
    NSRange range1 = {0,[str1 length]};
    NSRange range2 = {[str1 length]+2,[str2 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#030303"] range:range1];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#030303"] range:range2];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:34]
     
                   range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:34]
     
                   range:range2];
    self.timeTotalLab.attributedText = attStr;

}


// 时间格式化
- (void)dateFormatterStart:(NSDate *)startDate end:(NSDate *)endDate
{
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    //创建日期显示格式
    [pickerFormatter setDateFormat:@"HH:mm"];
    //将日期转换为字符串的形式
    NSString *startString = [pickerFormatter stringFromDate:startDate];
    NSString *endString = [pickerFormatter stringFromDate:endDate];
    
    self.sleepLab2.text = startString;
    self.upLabel1.text = endString;
    
    self.startLab.text = startString;
    self.endLab.text = endString;
}

#pragma mark - 闹钟方法

// 创建闹钟入口
- (void)createLocalNotification
{
    if (_model) {
        
        // 时间格式化
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * startDate = nil;
        NSString * endDate = nil;
        NSDate *updateDate = nil;
        NSTimeInterval time = 0;
        
        // 就寝时
        if (_model.tag.integerValue == 0) {
            //转化为字符串
            startDate = [dateFormatter stringFromDate:_model.startDate];
            NSLog(@"！！！！！！！！！%@",startDate);
            
        }
        
        // 15分钟前
        if (_model.tag.integerValue == 1) {
            time = 15 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
            
        }
        // 30分钟前
        else if (_model.tag.integerValue == 2) {
            time = 30 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
        }
        // 1小时前
        else if (_model.tag.integerValue == 3) {
            time = 1 * 60 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
        }
        endDate = [dateFormatter stringFromDate:_model.endDate];

        
        // 就寝闹钟
        [SleepVC shutdownClock:@"SleepID"];
        [SleepVC postLocalNotification:@"SleepID" clockTime:startDate weekArr:_model.weekDay alertBody:@"该睡觉啦~" clockMusic:_model.musicName];

        // 起床闹钟
        [SleepVC shutdownClock:@"WakeupID"];
        [SleepVC postLocalNotification:@"WakeupID" clockTime:endDate weekArr:_model.weekDay alertBody:@"该起床啦~" clockMusic:_model.musicName];
        
        [InfoCache archiveObject:_model toFile:ClockPath];

    }
    
}

+ (void)postLocalNotification:(NSString *)clockID clockTime:(NSString *)clockTime weekArr:(NSArray *)array alertBody:(NSString *)alertBody clockMusic:(NSString *)clockMusic
{
    
    //-----组建本地通知的fireDate-----------------------------------------------
    NSArray *clockTimeArray = [clockTime componentsSeparatedByString:@":"];
    NSDate *dateNow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //    [comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    NSInteger unitFlags = NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter;
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    [comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
    [comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
    [comps setSecond:0];
    
    //------------------------------------------------------------------------
    Byte weekday = [comps weekday];
    //    NSArray *array = [[clockMode substringFromIndex:1] componentsSeparatedByString:@"、"];
    Byte i = 0;
    Byte j = 0;
    int days = 0;
    int	temp = 0;
    Byte count = [array count];
    Byte clockDays[7];
    
//    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七", nil];
    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"7",@"1",@"2",@"3",@"4",@"5",@"6", nil];
    //查找设定的周期模式
    for (i = 0; i < count; i++) {
        for (j = 0; j < 7; j++) {
            if ([[array objectAtIndex:i] isEqualToString:[tempWeekdays objectAtIndex:j]]) {
                clockDays[i] = j + 1;
                break;
            }
        }
    }
    
    for (i = 0; i < count; i++) {
        temp = clockDays[i] - weekday;
        days = (temp >= 0 ? temp : temp + 7);
        NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        
        UILocalNotification *newNotification = [[UILocalNotification alloc] init];
        if (newNotification) {
            newNotification.fireDate = newFireDate;
            newNotification.alertBody = alertBody;
//            newNotification.soundName = @"7557.wav";
            newNotification.soundName = [NSString stringWithFormat:@"%@.caf", clockMusic];

            //            newNotification.alertAction = @"查看闹钟";
            newNotification.repeatInterval = NSCalendarUnitWeekOfYear;
//            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:clockID forKey:@"ActivityClock"];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:clockID,@"ActivityClock",newNotification.soundName,@"clockMusic",clockTime,@"clockTime", nil];
            newNotification.userInfo = userInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
        }
        NSLog(@"Post new localNotification:%@", [newNotification fireDate]);
        
    }
}

+ (void)shutdownClock:(NSString *)clockID
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in localNotifications)
    {
        if ([[[notification userInfo] objectForKey:@"ActivityClock"] isEqualToString:clockID]) {
            NSLog(@"Shutdown localNotification:%@", [notification fireDate]);
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
//    NSLog(@"%@--%@",gestureRecognizer,touch);
    if ([gestureRecognizer.view isKindOfClass:[self.clock class]] )
    {
        self.scrollView.scrollEnabled = NO;
        return YES;

    }
    else {
        self.scrollView.scrollEnabled = YES;
        return NO;
    }

}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/ - (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     [shapeLayer setBounds:lineView.bounds];
     [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
     [shapeLayer setFillColor:[UIColor clearColor].CGColor];
     //  设置虚线颜色为blackColor
     [shapeLayer setStrokeColor:lineColor.CGColor];
     //  设置虚线宽度
     [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
     [shapeLayer setLineJoin:kCALineJoinRound];
     //  设置线宽，线间距
     [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
     //  设置路径
     CGMutablePathRef path = CGPathCreateMutable();
     CGPathMoveToPoint(path, NULL, 0, 0); CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0); [shapeLayer setPath:path]; CGPathRelease(path);
     //  把绘制好的虚线添加上来
     [lineView.layer addSublayer:shapeLayer];
 }



//自定义滑块的大小    通过此方法可以更改滑块的任意大小和形状
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size

{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}



@end
