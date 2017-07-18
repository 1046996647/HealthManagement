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
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface SleepVC ()<UIGestureRecognizerDelegate,TenClockDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *remindLab;
@property (nonatomic,strong) TenClock *clock;
@property (nonatomic,strong) UILabel *sleepLab2;
@property (nonatomic,strong) UILabel *upLabel1;
@property (nonatomic,strong) UILabel *timeTotalLab;



@end

@implementation SleepVC

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
    weekLab.text = @"周一 周二";
    weekLab.textAlignment = NSTextAlignmentLeft;
    weekLab.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.scrollView addSubview:weekLab];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(kScreen_Width-42-12, sleepLab.top+10, 42, 24);
    [setBtn setImage:[UIImage imageNamed:@"setGreen"] forState:UIControlStateNormal];
    //    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:setBtn];


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
    
    // 解决上下滑动冲突
//    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBtnLoction:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.delegate=self;
    [self.clock addGestureRecognizer:tap];
    
    UIImageView *clockImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, clock.width-135, clock.width-135)];
    clockImg.image = [UIImage imageNamed:@"circle_bg"];
    clockImg.center = clock.center;
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
    
    NSArray *weekArr = @[@"一",@"二",@"三"];
    for (int i=0; i<weekArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(60+i*(28+20), (weekLab1.height-28)/2, 28, 28);
        btn.layer.cornerRadius = btn.width/2;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [btn setTitle:weekArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(weekAction:) forControlEvents:UIControlEventTouchUpInside];
        [weekLab1 addSubview:btn];
        
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
        UIImage *image = [self OriginImage:[UIImage imageNamed:@"hui"] scaleToSize:CGSizeMake(15, 15)];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"lv"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(remindAction:) forControlEvents:UIControlEventTouchUpInside];

        [remindLab addSubview:btn];
        
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
    [self.scrollView addSubview:btn3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-7-12, (btn3.height-10)/2.0, 7, 10)];
    //            imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"assistor"];
    [btn3 addSubview:imgView];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-200-30, 0,200, btn3.height)];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.text = @"早起者";
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.textColor = [UIColor colorWithHexString:@"#727272"];
    [btn3 addSubview:timeLab];
    
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

//自定义滑块的大小    通过此方法可以更改滑块的任意大小和形状
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size

{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

// 日期动作
- (void)weekAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"#59A43A"];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        btn.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)remindAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TenClockDelegate
- (void)timesUpdated:(TenClock *)clock startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{

    [self dateFormatterStart:startDate end:endDate];
    NSLog(@"------%@",startDate);
//    NSLog(@"------%@",endDate);

}

- (void)timesChanged:(TenClock *)clock startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    [self dateFormatterStart:startDate end:endDate];
    
    // do something
}

- (void)timesTotal:(TenClock *)clock time:(NSInteger)time
{
//    titleTextLayer.string = "\(fiveMinIncrements / 12)hr \((fiveMinIncrements % 12) * 5)min"
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
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





@end
