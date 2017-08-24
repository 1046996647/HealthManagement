//
//  SleepSettingVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SleepSettingVC.h"
#import "NSStringExt.h"
#import "MusicSelectVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface SleepSettingVC ()

@property (nonatomic,strong) UILabel *remindLab;
@property (nonatomic,strong) UILabel *musicLab;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UISlider *slider;


@end

@implementation SleepSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UILabel *weekLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    weekLab1.font = [UIFont systemFontOfSize:15];
    weekLab1.text = @"  星期";
    weekLab1.userInteractionEnabled = YES;
    weekLab1.textAlignment = NSTextAlignmentLeft;
    weekLab1.textColor = [UIColor blackColor];
    [baseView addSubview:weekLab1];
    
    NSArray *weekArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i=0; i<weekArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(60*scaleWidth+i*(25+20)*scaleWidth, (weekLab1.height-25*scaleWidth)/2, 25*scaleWidth, 25*scaleWidth);
        btn.layer.cornerRadius = btn.width/2;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:16*scaleWidth];
        btn.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [btn setTitle:weekArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(weekAction:) forControlEvents:UIControlEventTouchUpInside];
        [weekLab1 addSubview:btn];
        
        if (_model.weekDay.count) {
            for (NSString *weekDay in _model.weekDay) {
                
                
                NSString *chNum = [NSString translationArabicNum:weekDay.integerValue];
                
                if ([chNum isEqualToString:@"七"]) {
                    chNum = @"日";
                }
                
                if ([chNum isEqualToString:weekArr[i]]) {
                    btn.backgroundColor = [UIColor colorWithHexString:@"#59A43A"];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
            
        }
        
    }
    
    // 灰色条
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, weekLab1.bottom, kScreen_Width, 10)];
    view5.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [baseView addSubview:view5];
    
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
    [baseView addSubview:sleepRemindLab];
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
        [baseView addSubview:remindLab];
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
    
    /*
    // 灰色条
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(0, self.remindLab.bottom, kScreen_Width, view5.height)];
    view6.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [baseView addSubview:view6];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, view6.bottom, kScreen_Width, 40);
    //    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 setTitle:@"  提醒铃声" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 addTarget:self action:@selector(musicAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [baseView addSubview:btn3];
    
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
     
     */
    
    /*
    // 灰色条
    UIView *view7 = [[UIView alloc] initWithFrame:CGRectMake(0, self.remindLab.bottom, kScreen_Width, view5.height)];
    view7.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [baseView addSubview:view7];
    
    UILabel *volumeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, view7.bottom, kScreen_Width, 40)];
    volumeLab.font = [UIFont systemFontOfSize:13];
    volumeLab.text = @"  铃声音量";
    volumeLab.userInteractionEnabled = YES;
    volumeLab.textAlignment = NSTextAlignmentLeft;
    //    remindLab.textColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [baseView addSubview:volumeLab];
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(75, 0, kScreen_Width -75-10, volumeLab.height)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMinimumTrackTintColor:[UIColor colorWithHexString:@"#59A33A"]];
    [slider setMaximumTrackTintColor:[UIColor colorWithHexString:@"#EDEEEE"]];
    [slider setThumbImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
    [volumeLab addSubview:slider];
    self.slider = slider;
    
    if (self.model.volume < 0) {
        self.slider.value = [SleepSettingVC getSystemVolumValue];

    }
    else {
        self.slider.value = self.model.volume;
        
    }
    */
    
    baseView.height = self.remindLab.bottom;
    
    // 右上角按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 40, 30);
    //    [btn2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#59A43A"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [btn2 addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

-(void)volumeChange:(NSNotification*)notifi{
    NSString * style = [notifi.userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"];
    CGFloat value = [[notifi.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] doubleValue];
    if ([style isEqualToString:@"Ringtone"]) {
        NSLog(@"铃声改变");
    }else if ([style isEqualToString:@"Audio/Video"]){
        NSLog(@"音量改变 当前值:%f",value);
        self.slider.value = value;
        self.model.volume = value;
    }
}

- (void)sliderMethod:(UISlider *)sender
{
    [SleepSettingVC setSysVolumWith:sender.value];

}

//

#pragma mark - 音量控制
/*
 *获取系统音量滑块
 */
+(UISlider*)getSystemVolumSlider{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(10, 50, 200, 4)];
        
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                volumeViewSlider.hidden = YES;// YES:音量提示框出现,NO:音量提示框隐藏
                break;
            }
        }
    }
    
    return volumeViewSlider;
}


/*
 *获取系统音量大小
 */
+(CGFloat)getSystemVolumValue{
    return [[self getSystemVolumSlider] value];
}
/*
 *设置系统音量大小
 */
+(void)setSysVolumWith:(double)value{
    [self getSystemVolumSlider].value = value;
}

// 设置完成
- (void)finishAction
{
    if (self.settingBlock) {
        self.settingBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// 选择铃声
- (void)musicAction:(UIButton *)btn
{
    
    MusicSelectVC *vc = [[MusicSelectVC alloc] init];
    vc.block = ^(NSString *name) {
        self.musicLab.text = name;
        _model.musicName = name;
        //        [InfoCache archiveObject:_model toFile:ClockPath];

        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
*/

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
    
//    if (_model.isOpen) {
////        [self createLocalNotification];
//        
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
