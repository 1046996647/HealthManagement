//
//  RequestUrl.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

// 线上
//#define BaseUrl  @"http:// 106.14.218.31:8020/"

// 线下
#define BaseUrl  @"http://192.168.10.100:8051/API/"

// 1.5	首页信息
#define TitlePage  [NSString stringWithFormat:@"%@Restaurant/TitlePage",BaseUrl]

// 1.5	搜索信息
#define SearchVagueRestaurant  [NSString stringWithFormat:@"%@Restaurant/SearchVagueRestaurant",BaseUrl]

// 餐厅列表
#define GetRestaurantListInfo  [NSString stringWithFormat:@"%@Restaurant/GetRestaurantListInfo",BaseUrl]

// 餐厅详情页
#define GetRestaurantInfoById  [NSString stringWithFormat:@"%@Restaurant/GetRestaurantInfoById",BaseUrl]

// 菜谱列表
#define GetRecipeListInfoByDRId  [NSString stringWithFormat:@"%@Recipe/RecipeListInfoByDRId",BaseUrl]

// 推荐饮食列表
#define RecipeListByGPS  [NSString stringWithFormat:@"%@Recipe/RecipeListByGPS",BaseUrl]

// 菜谱详情页
#define RecipeItemInfo  [NSString stringWithFormat:@"%@Recipe/RecipeItemInfo",BaseUrl]

// 用户喜不喜欢
#define CustomerLikeOrNot  [NSString stringWithFormat:@"%@Restaurant/CustomerLikeOrNot",BaseUrl]

// 饮食文章列表
#define GetArticleListInfo  [NSString stringWithFormat:@"%@Article/GetArticleListInfo",BaseUrl]

// 获取验证码
#define SendMail  [NSString stringWithFormat:@"%@User/SendMail",BaseUrl]

// 5.2	手机注册
#define MailRegister  [NSString stringWithFormat:@"%@User/MailRegister",BaseUrl]

// 5.2	密码重置
#define ResetUserPassword  [NSString stringWithFormat:@"%@User/ResetUserPassword",BaseUrl]

// 4.1	简易版问卷列表
#define GetQuestionExpressList  [NSString stringWithFormat:@"%@Question/GetQuestionExpressList",BaseUrl]

// 4.1	简易版问题提交结果
#define GetSubmitExpressQuestion  [NSString stringWithFormat:@"%@Question/GetSubmitExpressQuestion",BaseUrl]

// 4.1	专业版问题列表
#define GetQuestionProfessionList  [NSString stringWithFormat:@"%@Question/GetQuestionProfessionList",BaseUrl]

// 4.1	专业版问题提交结果
#define GetSubmitQusttion  [NSString stringWithFormat:@"%@Question/GetSubmitQuestion",BaseUrl]

// 4.1	登入
#define Login  [NSString stringWithFormat:@"%@User/Login",BaseUrl]

// 5.4	设置用户身体信息
#define SetUserBodyInfo  [NSString stringWithFormat:@"%@User/SetUserBodyInfo",BaseUrl]

// 5.5	获得用户身体信息
#define GetUserBodyInfo  [NSString stringWithFormat:@"%@User/GetUserBodyInfo",BaseUrl]

// 5.5	用户偏好
#define SelectUserPreference  [NSString stringWithFormat:@"%@User/SelectUserPreference",BaseUrl]

#endif /* RequestUrl_h */
