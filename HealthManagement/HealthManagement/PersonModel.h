//
//  PersonModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString *UserId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *height;
@property(nonatomic,copy) NSString *weight;
@property(nonatomic,copy) NSString *age;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *BirthDay;
@property(nonatomic,copy) NSString *labourIntensity;
@property(nonatomic,copy) NSString *HeadImage;
@property(nonatomic,copy) NSString *constitution;
@property(nonatomic,copy) NSString *score;
@property(nonatomic,copy) NSString *Token;


@end
