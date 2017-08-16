//
//  detePickerView.m
//  XiaoYing
//
//  Created by 林颖 on 15/11/30.
//  Copyright © 2015年 MengFanBiao. All rights reserved.
//

#import "ZWLDatePickerView.h"

@interface ZWLDatePickerView ()

@end


@implementation ZWLDatePickerView


-(instancetype)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithDatePickerMode:datePickerMode];
    }
    return self;
}

-(void)initWithDatePickerMode:(UIDatePickerMode)datePickerMode {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, kScreen_Width, 17)];
    label1.text = @"请选择时间";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor colorWithHexString:@"#333333"];
    label1.font = [UIFont systemFontOfSize:16];
    [view addSubview:label1];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, label1.center.y-22, kScreen_Width/2.0, 88/2.0)];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"left-button"] forState: UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"  取消" forState:UIControlStateNormal];
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deleteBtn];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width/2.0, deleteBtn.top, kScreen_Width/2.0-10, 88/2.0)];
//    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"right-button"] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
//    confirmBtn.backgroundColor = [UIColor redColor];
    confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [confirmBtn addTarget:[self superview] action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:confirmBtn];
    
    //日期选择器
    dataPicker = [[UIDatePicker alloc] init];
    //改变大小必须分开写
    dataPicker.frame = CGRectMake(0, confirmBtn.bottom+12, kScreen_Width, self.height-(confirmBtn.bottom+12));

    dataPicker.datePickerMode = datePickerMode;
//    [dataPicker addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:dataPicker];
    
    if (datePickerMode == UIDatePickerModeDate) {
        //最大日期
        dataPicker.maximumDate = [NSDate date];
    }
    else {
        //最小日期
        dataPicker.minimumDate = [NSDate date];
    }
    
}


- (void)deleteAction
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmAction
{
    NSDate *pickerDate=[dataPicker date];
    
    NSDateFormatter *pickerFormatter =[[NSDateFormatter alloc]init];
    NSDateFormatter *pickerFormatter1 =[[NSDateFormatter alloc]init];

    if (dataPicker.datePickerMode == UIDatePickerModeDate) {
        //创建日期显示格式
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
        
        //创建日期显示格式
        [pickerFormatter1 setDateFormat:@"yyyy-MM-dd"];
    }
    else {
        //创建日期显示格式
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        
        //创建日期显示格式
        [pickerFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    }

    //将日期转换为字符串的形式
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    NSString *dateString1 = [pickerFormatter1 stringFromDate:pickerDate];
    
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        if (_dataBlock) {
            _dataBlock(dateString,dateString1);
        }
    }];

}

//重写setter方法
- (void)setDateStr:(NSString *)dateStr
{
    if (_dateStr != dateStr) {
        _dateStr = dateStr;
    }
    
    if ([self.dateStr isEqualToString:@""]) {
        dataPicker.date = [NSDate date];
    } else {
        dateLabel2.text = _dateStr;
        
        //日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //初始值
        NSDate *date = [dateFormatter dateFromString:_dateStr];

        dataPicker.date = date;
    }
    
}


@end
