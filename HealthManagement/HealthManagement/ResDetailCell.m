//
//  ResDetailCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailCell.h"

@implementation ResDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kScreen_Width-24, 0)];
//        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        view.layer.cornerRadius = 6;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = .5;
        view.layer.borderColor = [UIColor colorWithHexString:@"#efeff4"].CGColor;
        [self.contentView addSubview:view];
        self.view = view;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, 70)];
        _imgView.image = [UIImage imageNamed:@"long"];
//        _imgView.backgroundColor = [UIColor redColor];
//        _imgView.layer.cornerRadius = 6;
//        _imgView.layer.masksToBounds = YES;
//        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:_imgView];
        
        // 半透明背景
        UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.height-20, _imgView.width, 20)];
        alphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        [_imgView addSubview:alphaView];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.height-20, 100, 20)];
        _lab1.font = [UIFont systemFontOfSize:14];
        _lab1.text = @" 鸡蛋蔬菜沙拉";
        _lab1.textColor = [UIColor whiteColor];
        _lab1.textAlignment = NSTextAlignmentLeft;
        //        _lab1.backgroundColor = [UIColor redColor];
        [_imgView addSubview:_lab1];
        
        
        // 体质
        NSArray *bodyArr = @[@"temperament_1",@"temperament_2",@"temperament_3"];
        for (int i=0; i<bodyArr.count; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.right+i*(30+5), _lab1.center.y-5, 30, 10)];
            //        imgView.backgroundColor = [UIColor redColor];
            imgView.image = [UIImage imageNamed:bodyArr[i]];
            [_imgView addSubview:imgView];
            
        }
        
        UIImageView *moneyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imgView.bottom+12, 14, 14)];
        //        imgView.backgroundColor = [UIColor redColor];
        moneyImgView.image = [UIImage imageNamed:@"money"];
        [view addSubview:moneyImgView];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(moneyImgView.right+10, moneyImgView.center.y-10, 100, 20);
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitleColor:[UIColor colorWithHexString:@"#FD4900"] forState:UIControlStateNormal];
        [_btn setTitle:@"59" forState:UIControlStateNormal];
        [view addSubview:_btn];
        
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(view.width-20-12, _btn.top, 20, 20);
        [_btn2 setImage:[UIImage imageNamed:@"Restaurant_11"] forState:UIControlStateNormal];
        [view addSubview:_btn2];
        
        
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(_btn2.left-50, _btn2.center.y-7.5, 50, 15);
        _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btn1 setTitleColor:[UIColor colorWithHexString:@"#8650F4"] forState:UIControlStateNormal];
        [_btn1 setTitle:@"584份" forState:UIControlStateNormal];
        [view addSubview:_btn1];
        
        UIImageView *countImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_btn1.left-20, _btn2.center.y-7.5, 15, 15)];
        //        imgView.backgroundColor = [UIColor redColor];
        countImgView.image = [UIImage imageNamed:@"Restaurant_10"];
        [view addSubview:countImgView];
                
        //------------------------------------
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, _btn2.bottom, view.width, 80)];
        //        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [view addSubview:view1];
        self.view1 = view1;
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, view.width, 1)];
        //        imgView.backgroundColor = [UIColor redColor];
        lineImgView.image = [UIImage imageNamed:@"dotted"];
        [view1 addSubview:lineImgView];
        
        NSString *str1 = @"主食";
        //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
        //    self.money = str1;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    米饭290g",str1]];
        NSRange range1 = {0,[str1 length]};
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, _imgView.width-10, 14)];
        _lab1.font = [UIFont systemFontOfSize:12];
//        _lab1.text = @"匹配度 58%";
        _lab1.textColor = [UIColor grayColor];
        //        _lab1.textAlignment = NSTextAlignmentRight;
        //        _lab1.backgroundColor = [UIColor redColor];
        [view1 addSubview:_lab1];
        _lab1.attributedText = attStr;
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab1.height)];
        img1.image = [UIImage imageNamed:@"xian"];
//        _imgView.backgroundColor = [UIColor redColor];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_lab1 addSubview:img1];
        
        
        str1 = @"配菜";
        //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
        //    self.money = str1;
        attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    黑木耳292g",str1]];
//        range1 = {2,[str1 length]};
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(5, _lab1.bottom+10, _imgView.width-10, 14)];
        _lab2.font = [UIFont systemFontOfSize:12];
        //        _lab1.text = @"匹配度 58%";
        _lab2.textColor = [UIColor grayColor];
        //        _lab1.textAlignment = NSTextAlignmentRight;
        //        _lab1.backgroundColor = [UIColor redColor];
        [view1 addSubview:_lab2];
        _lab2.attributedText = attStr;
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab2.height)];
        img2.image = [UIImage imageNamed:@"xian"];
        //        _imgView.backgroundColor = [UIColor redColor];
        [_lab2 addSubview:img2];
        
        str1 = @"水果";
        //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
        //    self.money = str1;
        attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    水果沙拉292g",str1]];
        //        range1 = {2,[str1 length]};
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(5, _lab2.bottom+10, _imgView.width-10, 14)];
        _lab3.font = [UIFont systemFontOfSize:12];
        //        _lab1.text = @"匹配度 58%";
        _lab3.textColor = [UIColor grayColor];
        //        _lab1.textAlignment = NSTextAlignmentRight;
        //        _lab1.backgroundColor = [UIColor redColor];
        [view1 addSubview:_lab3];
        _lab3.attributedText = attStr;
        
        UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab3.height)];
        img3.image = [UIImage imageNamed:@"xian"];
        //        _imgView.backgroundColor = [UIColor redColor];
        [_lab3 addSubview:img3];
        
        
        view.height = view1.bottom;
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kScreen_Width, 20)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:whiteView];
        self.whiteView = whiteView;
        
    }
    
    return self;
    
}

- (void)setModel:(ResDetailModel *)model
{
    _model = model;
    
    _model.cellHeight = self.whiteView.bottom;
}

@end
