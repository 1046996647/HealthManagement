//
//  ArticleModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property(nonatomic,copy) NSString *ArticleId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *TitleImage;
@property(nonatomic,copy) NSString *cilckCount;
@property(nonatomic,copy) NSString *loveCount;
@property(nonatomic,copy) NSString *aTime;
@property(nonatomic,strong) NSArray *tags;
@property(nonatomic,copy) NSString *url;




@end

@interface SuggestModel : NSObject

@property(nonatomic,copy) NSString *NotSuitEat;
@property(nonatomic,copy) NSString *SuitEat;
@property(nonatomic,copy) NSString *constitution;




@end
