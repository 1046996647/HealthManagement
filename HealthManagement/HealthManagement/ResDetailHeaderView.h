//
//  ResDetailHeaderView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResDetailModel.h"


@interface ResDetailHeaderView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) ResDetailModel *model;

@end
