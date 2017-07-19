//
//  MusicSelectVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^MusicBlock)(NSString *name);


@interface MusicSelectVC : BaseViewController

@property(nonatomic,copy) MusicBlock block;


@end
