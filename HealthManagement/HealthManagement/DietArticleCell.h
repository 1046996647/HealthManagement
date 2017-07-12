//
//  DietArticleCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagsView.h"


@interface DietArticleCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UIImageView *imgView2;
@property(nonatomic,strong) UIImageView *imgView3;
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UIButton *btn1;

@property(nonatomic,strong) HXTagsView *tagsView;

@end
