//
//  FoodCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"

typedef void(^ReloadFoodBlock)(void);


@interface FoodCell : UITableViewCell

@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UIImageView *img1;
@property(nonatomic,strong) UIButton *unLikeBtn;
@property(nonatomic,strong) UIButton *likeBtn;

@property(nonatomic,strong) FoodModel *model;
@property(nonatomic,copy) NSString *Type_Like;
@property(nonatomic,copy) NSString *Opertion;

@property (nonatomic,copy) ReloadFoodBlock reloadFoodBlock;


@end
