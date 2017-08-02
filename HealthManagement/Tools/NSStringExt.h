//
//  NSString+ArabicToChinese.h
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ArabicToChinese)

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum;

// 根据日期计算是星期几
+ (NSString *)dateToWeek:(NSString *)dateStr;

/**
 *  是否为同一月
 */
+ (NSString *)isSameMonth:(NSString*)dateStr;

// 公里计算
+ (NSString *)meterToKilometer:(NSString *)meterStr;

// 文本宽度
+ (CGSize)textLength:(NSString *)content font:(UIFont *)font;

// 富文本
+ (NSMutableAttributedString *)text:(NSString *)text  fullText:(NSString *)fullText location:(NSInteger)location color:(UIColor *)color;

@end
