//
//  RecipeModel.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeModel : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *sales;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *titleImage;
@property(nonatomic,copy) NSString *ConstitutionPercentage;
@property(nonatomic,copy) NSString *Restaurant_Address;
@property(nonatomic,copy) NSString *Restaurant_Name;
@property(nonatomic,copy) NSString *RestaurantId;
@property(nonatomic,strong) NSArray *images;
@property(nonatomic,strong) NSArray *Constitution;
@property(nonatomic,strong) NSArray *foodRecipe;
@property(nonatomic,strong) NSArray *Tags;

//
@property(nonatomic,copy) NSString *recordItem;


@property(nonatomic,copy) NSString *RecipeImage;


@property(nonatomic,copy) NSString *RecipeId;
@property(nonatomic,copy) NSString *RecipeName;
@property(nonatomic,copy) NSString *OrderPrice;
@property(nonatomic,copy) NSString *OrderTime;
@property(nonatomic,copy) NSString *OrderId;
@property(nonatomic,copy) NSString *RestaurantName;
@property(nonatomic,copy) NSString *RestaurantImage;
@property(nonatomic,copy) NSString *RestaurantType;
@property(nonatomic,copy) NSString *RestaurantDistance;
@property(nonatomic,copy) NSString *RestaurantAddress;
@property(nonatomic,copy) NSString *RestaurantPhone;
@property(nonatomic,strong) NSArray *FoodRecipe;


@property(nonatomic,assign) NSInteger cellHeight;
@property(nonatomic,assign) BOOL isExpend;



@end

@interface RecipeItemModel : NSObject

@property(nonatomic,copy) NSString *ListFood;
@property(nonatomic,copy) NSString *RecipeItemName;



@end

@interface RecipeItem1Model : NSObject

@property(nonatomic,strong) NSArray *ListFood;
@property(nonatomic,copy) NSString *RecipeItemName;



@end

@interface FoodModel : NSObject

@property(nonatomic,copy) NSString *FoodName;
@property(nonatomic,copy) NSString *FoodWeight;
@property(nonatomic,copy) NSString *FoodId;
@property(nonatomic,copy) NSString *text;


// 0:没发生 1：不喜欢 2：喜欢
@property(nonatomic,copy) NSString *WhetherLike;
@property(nonatomic,assign) NSInteger type;



@end
