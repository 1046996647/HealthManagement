//
//  RecommendDietView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietView.h"
#import "RecommendDietVC.h"

@implementation RecommendDietView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _viewArr = [NSMutableArray array];
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-80)/2, 15, 80, 20)];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = @"推荐饮食";
    lab.textAlignment = NSTextAlignmentCenter;
//    lab.backgroundColor = [UIColor cyanColor];
    //    lab.textColor = [UIColor colorWithHexString:@"#868788"];
    [self addSubview:lab];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(lab.left-12-50, lab.center.y, 50, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(lab.right+12, lab.center.y, 50, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreen_Width-50, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"assistor"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btn.backgroundColor = [UIColor redColor];
    [self addSubview:btn];
    
    // 小图
    CGFloat height = kRWidth+40;
    for (int i=0; i<4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12+kBigWidth+5+i%2*(kRWidth+5), btn.bottom+i/2*(height+5), kRWidth, height)];
        view.layer.borderWidth = .5;
        view.layer.borderColor = [UIColor colorWithHexString:@"#efeff4"].CGColor;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRWidth, kRWidth)];
//        imgView.backgroundColor = [UIColor redColor];
        imgView.tag = 100+i;
        imgView.image = [UIImage imageNamed:@"food"];
        [view addSubview:imgView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, imgView.bottom, kRWidth-10, 20)];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.text = @"桂花莲子";
        titleLab.tag = 101+i;
//        titleLab.backgroundColor = [UIColor cyanColor];
        //    lab.textColor = [UIColor colorWithHexString:@"#868788"];
        [view addSubview:titleLab];
        
        UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom, kRWidth/3, 14)];
        moneyLab.font = [UIFont systemFontOfSize:12];
//        moneyLab.textAlignment = NSTextAlignmentRight;
        moneyLab.text = @"￥25";
        moneyLab.textColor = [UIColor redColor];
//        moneyLab.backgroundColor = [UIColor yellowColor];
        moneyLab.tag = 102+i;
        [view addSubview:moneyLab];
        
        NSString *str1 = @"88";
        //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
        //    self.money = str1;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度%@%%",str1]];
        NSRange range1 = {3,[str1 length]};
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#107909"] range:range1];
        UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kRWidth-kRWidth*2/3+5, titleLab.bottom, kRWidth*2/3-5, 14)];
        fitLab.font = [UIFont systemFontOfSize:12];
        fitLab.textAlignment = NSTextAlignmentRight;
//        fitLab.text = @"";
        fitLab.tag = 103+i;
        fitLab.textColor = [UIColor grayColor];
//        fitLab.backgroundColor = [UIColor yellowColor];
        fitLab.attributedText = attStr;
        [view addSubview:fitLab];
        
        [_viewArr addObject:view];
        
    }
    
    // 大图
    UIView *view = [_viewArr lastObject];
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(12, btn.bottom, kBigWidth, view.bottom-50)];
    _bigView.layer.borderWidth = .5;
    _bigView.layer.borderColor = [UIColor colorWithHexString:@"#efeff4"].CGColor;
    _bigView.layer.cornerRadius = 5;
    _bigView.layer.masksToBounds = YES;
    [self addSubview:_bigView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kBigWidth, _bigView.height-60)];
    imgView.backgroundColor = [UIColor redColor];
    imgView.tag = 10;
    imgView.image = [UIImage imageNamed:@"food"];
    [_bigView addSubview:imgView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, _bigView.height-30-20, kBigWidth-10, 18)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.text = @"桂花莲子";
    titleLab.tag = 11;
//    titleLab.backgroundColor = [UIColor cyanColor];
    //    lab.textColor = [UIColor colorWithHexString:@"#868788"];
    [_bigView addSubview:titleLab];
    
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom+5, kBigWidth/3, 16)];
    moneyLab.font = [UIFont systemFontOfSize:14];
    //        moneyLab.textAlignment = NSTextAlignmentRight;
    moneyLab.text = @"￥256";
    moneyLab.textColor = [UIColor redColor];
//    moneyLab.backgroundColor = [UIColor yellowColor];
    moneyLab.tag = 12;
    [_bigView addSubview:moneyLab];
    
    
    NSString *str1 = @"98";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度%@%%",str1]];
    NSRange range1 = {3,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kBigWidth-kBigWidth*2/3+5, titleLab.bottom+5, kBigWidth*2/3-5, 16)];
    fitLab.font = [UIFont systemFontOfSize:14];
    fitLab.textAlignment = NSTextAlignmentRight;
//    fitLab.text = @"匹配度98%";
    fitLab.tag = 13;
    fitLab.textColor = [UIColor grayColor];
    //        fitLab.backgroundColor = [UIColor yellowColor];
    fitLab.attributedText = attStr;
    [_bigView addSubview:fitLab];
    
    self.height = _bigView.bottom+10;

}

// 跳转附近餐厅
- (void)btnAction
{
    RecommendDietVC *vc = [[RecommendDietVC alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    for (int i=0; i<_viewArr.count; i++) {
        UIView *view = _viewArr[i];
//        UIImageView *imgView = (UIImageView *)[view viewWithTag:100+i];
//        UILabel *titleLab = (UILabel *)[view viewWithTag:101+i];
//        UILabel *moneyLab = (UILabel *)[view viewWithTag:102+i];
//        UILabel *fitLab = (UILabel *)[view viewWithTag:103+i];
        NSLog(@"%@",view.subviews);
    }
    
//    UIImageView *imgView = (UIImageView *)[_bigView viewWithTag:10];
//    UILabel *titleLab = (UILabel *)[_bigView viewWithTag:11];
//    UILabel *moneyLab = (UILabel *)[_bigView viewWithTag:12];
//    UILabel *fitLab = (UILabel *)[_bigView viewWithTag:13];
}

@end
