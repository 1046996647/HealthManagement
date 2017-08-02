//
//  NavgationBarView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavHeadTitleViewDelegate <NSObject>
@optional
//- (void)NavHeadback;
- (void)navHeadToRight;
@end

@interface NavgationBarView : UIView

@property(nonatomic,assign)id<NavHeadTitleViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * headBgView;

@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * backTitleImage;
@property(nonatomic,strong)NSString * rightImageView;

@end
