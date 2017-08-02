//
//  SleepModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//


@interface SleepModel : NSObject<NSCoding>

@property (nonatomic,strong) NSMutableArray *weekDay;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate;
@property (nonatomic,strong) NSNumber *tag;// 就寝提醒
@property (nonatomic,copy) NSString *musicName;


@end
