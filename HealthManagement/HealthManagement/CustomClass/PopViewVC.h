//
//  PopViewVC.h
//  XiaoYing
//
//  Created by ZWL on 16/9/9.
//  Copyright © 2016年 yinglaijinrong. All rights reserved.
//


typedef void(^ClickBlock)(NSInteger);


@interface PopViewVC : UIViewController

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,copy) ClickBlock clickBlock;



@end
