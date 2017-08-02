//
//  TimeModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property(nonatomic,copy) NSString *timeStr;
@property(nonatomic,strong) NSMutableArray *headCellArray;

@end

@interface IntergrationRecordModel : NSObject

@property(nonatomic,copy) NSString *fullPayTime;
@property(nonatomic,copy) NSString *payTime;


@end
