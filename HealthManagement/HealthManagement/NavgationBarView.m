//
//  NavgationBarView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NavgationBarView.h"

@interface NavgationBarView()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView * back;
@property(nonatomic,strong)UIButton * rightBtn;
@end

@implementation NavgationBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.headBgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor=[UIColor whiteColor];
//        self.headBgView.image = [UIImage imageNamed:@"nav－-bar"];
        //隐藏黑线
        self.headBgView.alpha=0;
        [self addSubview:self.headBgView];

        
//        self.backgroundColor=[UIColor whiteColor];
//        self.alpha=0;

        
        self.back=[[UIImageView alloc] init];
//        self.back.backgroundColor=[UIColor redColor];
        self.back.frame=CGRectMake(10, 56/2, 23, 23);
        self.back.layer.cornerRadius = self.back.height/2.0;
        self.back.layer.masksToBounds = YES;
//        [self.back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headBgView addSubview:self.back];
        
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:17];
        [self.headBgView addSubview:self.label];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(kScreen_Width-18-12, 70/2.0, 18, 18);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64-.5, kScreen_Width, .5)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
        [self.headBgView addSubview:view];
        
    }
    
    return self;
}

//右边按钮
-(void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(navHeadToRight)]) {
        [_delegate navHeadToRight];
    }
}

-(void)setBackTitleImage:(NSString *)backTitleImage
{
    _backTitleImage=backTitleImage;
//    [self.back setImage:[UIImage imageNamed:_backTitleImage] forState:UIControlStateNormal];
    [self.back sd_setImageWithURL:[NSURL URLWithString:backTitleImage] placeholderImage:[UIImage imageNamed:@""]];
//    [self.back sd_setImageWithURL:[NSURL URLWithString:backTitleImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head"]];
    
}
-(void)setRightImageView:(NSString *)rightImageView
{
    _rightImageView=rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
    //[self.rightBtn setTitle:rightImageView forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    self.label.text=title;
    //self.label.textColor=[UIColor whiteColor];
    //[self jianBian];
    
}

@end
