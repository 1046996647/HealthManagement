//
//  DietRecordView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietRecordView.h"

@implementation DietRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        _viewArr = [NSMutableArray array];
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-80)/2, 15, 80, 20)];
    lab.font = [UIFont systemFontOfSize:16];
    lab.text = @"饮食记录";
    lab.textAlignment = NSTextAlignmentCenter;
    //    lab.backgroundColor = [UIColor cyanColor];
    //    lab.textColor = [UIColor colorWithHexString:@"#868788"];
    [self addSubview:lab];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(lab.left-12-50, lab.center.y, 50, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(lab.right+12, lab.center.y, 50, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreen_Width-50, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"assistor"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //    btn.backgroundColor = [UIColor redColor];
    [self addSubview:btn];
    
    self.height = btn.height;
}

@end
