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
#import "MusicSelectVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define ClockPath @"ClockPath"

@interface SleepVC ()<UIGestureRecognizerDelegate,TenClockDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *remindLab;
@property (nonatomic,strong) TenClock *clock;
@property (nonatomic,strong) UILabel *sleepLab2;
@property (nonatomic,strong) UILabel *upLabel1;
@property (nonatomic,strong) UILabel *timeTotalLab;
@property (nonatomic,strong) SleepModel *model;
@property (nonatomic,strong) UILabel *weekLab;

@property(nonatomic,strong) UIButton *lastBtn;

@property (nonatomic,strong) UILabel *musicLab;



@end

@implementation SleepVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    // 取出闹钟本地数据
    _model = [InfoCache unarchiveObjectWithFile:ClockPath];
    if (!_model) {
        _model = [[SleepModel alloc] init];

    }
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
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
    
    [self setWeekMethod];

    // 打开或关闭闹钟
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(kScreen_Width-42-12, sleepLab.top+10, 42, 24);
    [setBtn setImage:[UIImage imageNamed:@"setGray"] forState:UIControlStateNormal];
    [setBtn setImage:[UIImage imageNamed:@"setGreen"] forState:UIControlStateSelected];

    [setBtn addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:setBtn];
    setBtn.selected = _model.isOpen;




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
    self.clock = clock;
    [self dateFormatterStart:clock.startDate end:clock.endDate];
    
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
    
    UIImageView *clockImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, clock.width-135, clock.width-135)];
    clockImg.image = [UIImage imageNamed:@"circle_bg"];
    clockImg.center = clock.center;
//    clockImg.userInteractionEnabled = YES;// 处理在闹钟中间滑动
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:clockImg];
    

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
    
    UILabel *setLab = [[UILabel alloc] initWithFrame:CGRectMake(0, view3.bottom, kScreen_Width, 40)];
    setLab.font = [UIFont systemFontOfSize:16];
    setLab.text = @"  设置";
    setLab.textAlignment = NSTextAlignmentLeft;
    setLab.textColor = [UIColor blackColor];
    [self.scrollView addSubview:setLab];
    
    // 灰色条
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, setLab.bottom, kScreen_Width, 10)];
    view4.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view4];
    
    UILabel *weekLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, view4.bottom, kScreen_Width, 40)];
    weekLab1.font = [UIFont systemFontOfSize:15];
    weekLab1.text = @"  星期";
    weekLab1.userInteractionEnabled = YES;
    weekLab1.textAlignment = NSTextAlignmentLeft;
    weekLab1.textColor = [UIColor blackColor];
    [self.scrollView addSubview:weekLab1];
    
    NSArray *weekArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七"];
    for (int i=0; i<weekArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(60+i*(25+20), (weekLab1.height-25)/2, 25, 25);
        btn.layer.cornerRadius = btn.width/2;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [btn setTitle:weekArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(weekAction:) forControlEvents:UIControlEventTouchUpInside];
        [weekLab1 addSubview:btn];
        
        if (_model.weekDay.count) {
            for (NSString *weekDay in _model.weekDay) {
                
                NSString *chNum = [NSString translationArabicNum:weekDay.integerValue];
                if ([chNum isEqualToString:weekArr[i]]) {
                    btn.backgroundColor = [UIColor colorWithHexString:@"#59A43A"];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
            
        }
        
    }
    
    // 灰色条
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, weekLab1.bottom, kScreen_Width, view4.height)];
    view5.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view5];
    
    NSString *str1 = @"  就寝提醒";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  您希望将提醒设为就寝前多久?",str1]];
    NSRange range1 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:14.0]
     
                   range:range1];
    UILabel *sleepRemindLab = [[UILabel alloc] initWithFrame:CGRectMake(0, view5.bottom, kScreen_Width, 40)];
    sleepRemindLab.font = [UIFont systemFontOfSize:11];
//    remindLab.text = @"  就寝提醒";
    sleepRemindLab.textAlignment = NSTextAlignmentLeft;
    sleepRemindLab.textColor = [UIColor colorWithHexString:@"#A0A0A0"];
    [self.scrollView addSubview:sleepRemindLab];
    sleepRemindLab.attributedText = attStr;
    
    NSArray *beforeArr = @[@"  就寝时",@"  15分钟前",@"  30分钟前",@"  1小时前"];
    for (int i=0; i<beforeArr.count; i++) {
        
        UILabel *remindLab = [[UILabel alloc] initWithFrame:CGRectMake(0, sleepRemindLab.bottom+i*40, kScreen_Width, 40)];
        remindLab.font = [UIFont systemFontOfSize:15];
        //    remindLab.text = @"  就寝提醒";
        remindLab.text = beforeArr[i];
        remindLab.userInteractionEnabled = YES;
        remindLab.textAlignment = NSTextAlignmentLeft;
        remindLab.textColor = [UIColor colorWithHexString:@"#6F6E6F"];
        [self.scrollView addSubview:remindLab];
        self.remindLab = remindLab;
        
        // 灰色条
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [remindLab addSubview:line];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(kScreen_Width-30-12, (remindLab.height-30)/2, 30, 30);
        btn.tag = i;
        UIImage *image = [self OriginImage:[UIImage imageNamed:@"hui"] scaleToSize:CGSizeMake(15, 15)];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"lv"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(remindAction:) forControlEvents:UIControlEventTouchUpInside];
        [remindLab addSubview:btn];
        
        if (_model.tag.integerValue == i) {
            btn.selected = YES;
            self.lastBtn = btn;

        }
        
        
    }
    
    // 灰色条
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(0, self.remindLab.bottom, kScreen_Width, view4.height)];
    view6.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view6];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, view6.bottom, kScreen_Width, 40);
    //    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 setTitle:@"  提醒铃声" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 addTarget:self action:@selector(musicAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView addSubview:btn3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-7-12, (btn3.height-10)/2.0, 7, 10)];
    //            imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"assistor"];
    [btn3 addSubview:imgView];
    
    UILabel *musicLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-200-30, 0,200, btn3.height)];
    musicLab.font = [UIFont systemFontOfSize:12];
//    timeLab.text = @"早起者";
    musicLab.textAlignment = NSTextAlignmentRight;
    musicLab.textColor = [UIColor colorWithHexString:@"#727272"];
    [btn3 addSubview:musicLab];
    self.musicLab = musicLab;
    
    if (_model.musicName) {
        musicLab.text = _model.musicName;

    }
    
    // 灰色条
    UIView *view7 = [[UIView alloc] initWithFrame:CGRectMake(0, btn3.bottom, kScreen_Width, view4.height)];
    view7.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view7];
    
    UILabel *volumeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, view7.bottom, kScreen_Width, 40)];
    volumeLab.font = [UIFont systemFontOfSize:13];
    volumeLab.text = @"  铃声音量";
    volumeLab.userInteractionEnabled = YES;
    volumeLab.textAlignment = NSTextAlignmentLeft;
//    remindLab.textColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:volumeLab];
    
//    //自定义MPVolumeView 高度不能改变其他都可以
//    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(75, 0, kScreen_Width -75-10, volumeLab.height)];
//    //把自定义的MPVolumeView贴在view上
////    [self.view addSubview: volumeView];
//    
//    //寻找建立UISlider;
//    UISlider* slider = nil;
//    //设置音量大小
//    slider.value = 0.7;
//    for (UIView *view in [volumeView subviews]){
//        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
//            slider = (UISlider*)view;
////            volumeViewSlider.backgroundColor = [UIColor yellowColor];
//            break;
//        }
//    }
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(75, 0, kScreen_Width -75-10, volumeLab.height)];
//    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
//    [slider setMaximumValue:1];
//    [slider setMinimumValue:0];
//    UIImage *image = [self OriginImage:[UIImage imageNamed:@"green"] scaleToSize:CGSizeMake(20, 20)];
    [slider setMinimumTrackTintColor:[UIColor colorWithHexString:@"#59A33A"]];
    [slider setMaximumTrackTintColor:[UIColor colorWithHexString:@"#EDEEEE"]];
    [slider setThumbImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
    [volumeLab addSubview:slider];

    self.scrollView.contentSize = CGSizeMake(kScreen_Width, volumeLab.bottom+15-64);
    
    

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




// 日期动作
- (void)weekAction:(UIButton *)btn
{
    NSString *numStr = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"#59A43A"];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (![_model.weekDay containsObject:numStr]) {
            [_model.weekDay addObject:numStr];
        }
    }
    else {
        btn.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if ([_model.weekDay containsObject:numStr]) {
            [_model.weekDay removeObject:numStr];
        }
        
    }
    
    [self setWeekMethod];
    
    if (_model.isOpen) {
        [self createLocalNotification];

    }
    

    
//    [InfoCache archiveObject:_model toFile:ClockPath];

}

// 选择铃声
- (void)musicAction:(UIButton *)btn
{
    
    MusicSelectVC *vc = [[MusicSelectVC alloc] init];
    vc.block = ^(NSString *name) {
        self.musicLab.text = name;
        _model.musicName = name;
//        [InfoCache archiveObject:_model toFile:ClockPath];
        if (_model.isOpen) {
            [self createLocalNotification];
            
        }

    };
    [self.navigationController pushViewController:vc animated:YES];
}


// 打开或关闭闹钟
- (void)setAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    _model.isOpen = btn.selected;
    
    if (btn.selected) {
        [self createLocalNotification];

    }
    else {
        [SleepVC shutdownClock:@"SleepID"];
        [SleepVC shutdownClock:@"WakeupID"];

    }

//    [InfoCache archiveObject:_model toFile:ClockPath];
}

// 提前提醒入睡
- (void)remindAction:(UIButton *)btn
{
//    btn.selected = !btn.selected;
    _model.tag = @(btn.tag);
//    [InfoCache archiveObject:_model toFile:ClockPath];

    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;

    if (_model.isOpen) {
        [self createLocalNotification];
        
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
    //    NSLog(@"------%@",endDate);
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
}

#pragma mark - 闹钟方法

// 创建闹钟入口
- (void)createLocalNotification
{
    if (_model) {
        
        [InfoCache archiveObject:_model toFile:ClockPath];

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
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:clockID forKey:@"ActivityClock"];
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
