//
//  BodyModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//


@interface BodyModel : NSObject

@property(nonatomic,copy) NSString *QuestionContent;
@property(nonatomic,copy) NSString *QuestionId;
@property(nonatomic,strong) NSArray *Options;
@property(nonatomic,strong) NSMutableArray *conten;


@end


@interface ContenModel : NSObject

@property(nonatomic,copy) NSString *OptionContent;
@property(nonatomic,copy) NSString *OptionId;
@property(nonatomic,assign) BOOL isSelected;



@end
