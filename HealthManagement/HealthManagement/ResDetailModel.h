//
//  ResDetailModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResDetailModel : NSObject

@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *category;
@property(nonatomic,copy) NSString *consumption;
@property(nonatomic,copy) NSString *discount;
@property(nonatomic,copy) NSString *distance;

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *titleImage;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *sales;
@property(nonatomic,strong) NSArray *images;

@property(nonatomic,assign) NSInteger cellHeight;





@end
