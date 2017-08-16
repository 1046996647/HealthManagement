//
//  detePickerView.h
//  XiaoYing
//
//  Created by 林颖 on 15/11/30.
//  Copyright © 2015年 MengFanBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWLDatePickerView;

typedef void(^DataBlock)(NSString *str,NSString *str1);


@interface ZWLDatePickerView : UIView
{
   
    UIDatePicker *dataPicker;
    UILabel *dateLabel2;
}

@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic, copy)DataBlock dataBlock;
//@property (nonatomic,assign) NSInteger type;

-(instancetype)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode;

@end
