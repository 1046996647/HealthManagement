//
//  NSString+ArabicToChinese.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "NSStringExt.h"

@implementation NSString (ArabicToChinese)

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

// 根据日期计算是星期几
+ (NSString *)dateToWeek:(NSString *)dateStr
{
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"-"];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[dateArr[2] integerValue]];
    [_comps setMonth:[dateArr[1] integerValue]];
    [_comps setYear:[dateArr[0] integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int _weekday = [weekdayComponents weekday];
    NSLog(@"_weekday::%d",_weekday);
    switch (_weekday) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}

/**
 *  是否为同一月
 */
+ (NSString *)isSameMonth:(NSString*)dateStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [inputFormatter dateFromString:dateStr];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy年MM月"];
    NSString *string = [outputFormatter stringFromDate:date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
//    BOOL isTure = [comp1 month] == [comp2 month] &&
//    [comp1 year]  == [comp2 year];
    if ([comp1 month] == [comp2 month] &&
        [comp1 year]  == [comp2 year]) {
        return @"本月";
    }
    else if ([comp1 year]  == [comp2 year]) {// 只返回月
        string = [string substringFromIndex:5];
        if ([string hasPrefix:@"0"]) {
            string = [string substringFromIndex:1];
        }
        return string;

    }
    else {// 全返回
        return string;

    }
    
    
    return nil;
}

@end
