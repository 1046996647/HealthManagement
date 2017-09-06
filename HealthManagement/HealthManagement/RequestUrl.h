//
//  RequestUrl.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

// 服务器
//#define BaseUrl  @"http://106.14.218.31:8020/API/"

// 调试
#define BaseUrl  @"http://192.168.2.13:8051/API/"

// 1.5	首页信息
#define TitlePage  [NSString stringWithFormat:@"%@Restaurant/TitlePage",BaseUrl]

// 1.5	搜索信息
#define SearchVagueRestaurant  [NSString stringWithFormat:@"%@Restaurant/SearchVagueRestaurant",BaseUrl]

// 1.5	热门搜索
#define HotSearch  [NSString stringWithFormat:@"%@Restaurant/HotSearch",BaseUrl]

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

// 获得订单信息列表
#define OrderList  [NSString stringWithFormat:@"%@Orders/OrderList",BaseUrl]

// 获得订单信息详情
#define OrderInfo  [NSString stringWithFormat:@"%@Orders/OrderInfo",BaseUrl]



// 支付详情页
#define RecipeItemInfoForPay  [NSString stringWithFormat:@"%@Recipe/RecipeItemInfoForPay",BaseUrl]

// 到店支付
#define PayAtShopOrder  [NSString stringWithFormat:@"%@Orders/PayAtShopOrder",BaseUrl]

// 删除订单
#define DeleteOrder  [NSString stringWithFormat:@"%@Orders/DeleteOrder",BaseUrl]



// 用户喜不喜欢
#define CustomerLikeOrNot  [NSString stringWithFormat:@"%@Restaurant/CustomerLikeOrNot",BaseUrl]

// 饮食文章列表
#define GetArticleListInfo  [NSString stringWithFormat:@"%@Article/GetArticleListInfo",BaseUrl]

// 文章点赞
#define ArticlePointPraise  [NSString stringWithFormat:@"%@Article/ArticlePointPraise",BaseUrl]

// 文章查看
#define ArticleClick  [NSString stringWithFormat:@"%@Article/ArticleClick",BaseUrl]

// 获取验证码
#define SendMail  [NSString stringWithFormat:@"%@User/SendMail",BaseUrl]

// 5.2	手机注册
#define MailRegister  [NSString stringWithFormat:@"%@User/MailRegister",BaseUrl]

// 5.2	忘记密码
#define ResetUserPassword  [NSString stringWithFormat:@"%@User/ResetUserPassword",BaseUrl]

// 5.2	修改密码
#define ModifyUserPassword  [NSString stringWithFormat:@"%@User/ModifyUserPassword",BaseUrl]

// 5.2	验证旧手机
#define VerificationCode  [NSString stringWithFormat:@"%@User/VerificationCode",BaseUrl]

// 5.2	更换新手机
#define ModifyUserPhone  [NSString stringWithFormat:@"%@User/ModifyUserPhone",BaseUrl]


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

// 餐厅收藏
#define UserPreferenceRest  [NSString stringWithFormat:@"%@Restaurant/UserPreferenceRest",BaseUrl]


// 5.5	运动数据更新
#define UpLoadSportInfo  [NSString stringWithFormat:@"%@Sport/UpLoadSportInfo",BaseUrl]

// 5.5	获取运动信息列表
#define GetSportList  [NSString stringWithFormat:@"%@Sport/GetSportList",BaseUrl]

// 5.5	上传图片
#define UploadUserHeadImage  [NSString stringWithFormat:@"%@User/UploadUserHeadImage",BaseUrl]

#define UploadImage  [NSString stringWithFormat:@"%@User/UploadImage",BaseUrl]

// 5.5	用户积分信息
#define UserScoreInfo  [NSString stringWithFormat:@"%@User/UserScoreInfo",BaseUrl]


// 5.5	增加积分
#define AddScoreRecord  [NSString stringWithFormat:@"%@Score/AddScoreRecord",BaseUrl]

// 5.5	获得积分列表
#define GetScoreList  [NSString stringWithFormat:@"%@/Score/GetScoreList",BaseUrl]

// 5.5	获得未获取分数列表
#define GetClickScore  [NSString stringWithFormat:@"%@/Score/GetClickScore",BaseUrl]

// 5.5	积分点击
#define ClickScore  [NSString stringWithFormat:@"%@/Score/ClickScore",BaseUrl]


#endif /* RequestUrl_h */
