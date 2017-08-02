//
//  PersonModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    
    NSString *age = dic[@"age"];
    
    if (age.integerValue>200) {
        _age = @"";
        _BirthDay = @"";

    }
    else {
        
        NSString *timeStr = dic[@"BirthDay"];
        _BirthDay = [[timeStr componentsSeparatedByString:@"T"] firstObject];
        NSDateFormatter *pickerFormatter =[[NSDateFormatter alloc]init];
        //创建日期显示格式
        [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date = [pickerFormatter dateFromString:[[timeStr componentsSeparatedByString:@"T"] firstObject]];
        
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];

        _BirthDay = [pickerFormatter stringFromDate:date];

    }
    
    return YES;
}

@end
