//
//  ClockView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/2.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 610/2*scaleWidth, 672/2*scaleWidth)];
        baseImg.image = [UIImage imageNamed:@"clockback"];
        baseImg.layer.cornerRadius = 5;
        baseImg.layer.masksToBounds = YES;
        baseImg.userInteractionEnabled = YES;
        baseImg.center = self.center;
        [self addSubview:baseImg];
        
        UILabel *sleepLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, (baseImg.height-35)/2.0+10, baseImg.width, 35)];
        sleepLab2.font = [UIFont systemFontOfSize:34];
        sleepLab2.text = @"23:00";
        sleepLab2.textAlignment = NSTextAlignmentCenter;
        sleepLab2.textColor = [UIColor blackColor];
        [baseImg addSubview:sleepLab2];
        self.sleepLab2 = sleepLab2;
        
        UIImageView *clockImg = [[UIImageView alloc] initWithFrame:CGRectMake((baseImg.width-168/2)/2.0, sleepLab2.top-23-176/2, 168/2, 176/2)];
        clockImg.image = [UIImage imageNamed:@"sleep_9"];
        [baseImg addSubview:clockImg];
        
        UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        enterBtn.frame = CGRectMake((baseImg.width-430/2)/2.0, sleepLab2.bottom+23, 430/2, 108/2);
        enterBtn.layer.cornerRadius = 5;
        enterBtn.layer.masksToBounds = YES;
        [enterBtn setTitle:@"起床" forState:UIControlStateNormal];
        enterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        enterBtn.backgroundColor = [UIColor colorWithHexString:@"#A189BD"];
        [baseImg addSubview:enterBtn];
        [enterBtn addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)upAction:(UIButton *)btn
{
    if (self.block) {
        self.block();
    }
    
    [self removeFromSuperview];
    
}

- (void)setTimeStr:(NSString *)timeStr
{
    self.sleepLab2.text = timeStr;
}














@end
