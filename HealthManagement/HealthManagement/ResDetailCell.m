//
//  ResDetailCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailCell.h"
#import "NSStringExt.h"

@implementation ResDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width-20, 0)];
//        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        view.layer.cornerRadius = 6;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = .5;
        view.layer.borderColor = [UIColor colorWithHexString:@"#efeff4"].CGColor;
        [self.contentView addSubview:view];
        self.view = view;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, 85)];
//        _imgView.image = [UIImage imageNamed:@"long"];
//        _imgView.backgroundColor = [UIColor redColor];
//        _imgView.layer.cornerRadius = 6;
//        _imgView.layer.masksToBounds = YES;
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:_imgView];
        
        // 半透明背景
        UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom-20, _imgView.width, 20)];
        alphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        [view addSubview:alphaView];
        self.alphaView = alphaView;
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom-20, 100, 20)];
        _lab4.font = [UIFont systemFontOfSize:14];
//        _lab1.text = @" 鸡蛋蔬菜沙拉";
        _lab4.textColor = [UIColor whiteColor];
        _lab4.textAlignment = NSTextAlignmentLeft;
        //        _lab1.backgroundColor = [UIColor redColor];
        [view addSubview:_lab4];
        
        
        
        UIImageView *moneyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imgView.bottom+12, 16, 16)];
        //        imgView.backgroundColor = [UIColor redColor];
        moneyImgView.image = [UIImage imageNamed:@"money"];
        [view addSubview:moneyImgView];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(moneyImgView.right+5, moneyImgView.center.y-10, 100, 20);
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        _btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_btn setTitleColor:[UIColor colorWithHexString:@"#FD4900"] forState:UIControlStateNormal];
//        [_btn setTitle:@"59" forState:UIControlStateNormal];
        [view addSubview:_btn];
        
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(view.width-20-2, _btn.top, 20, 20);
        [_btn2 setImage:[UIImage imageNamed:@"Restaurant_12"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"Restaurant_11"] forState:UIControlStateSelected];
        [_btn2 addTarget:self action:@selector(expendAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_btn2];
        
        
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(_btn2.left-50, _btn2.center.y-7.5, 50, 15);
        _btn1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_btn1 setTitleColor:[UIColor colorWithHexString:@"#8650F4"] forState:UIControlStateNormal];
//        [_btn1 setTitle:@"584份" forState:UIControlStateNormal];
        [view addSubview:_btn1];
        
        UIImageView *countImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_btn1.left-20, _btn2.center.y-8.5, 17, 17)];
        //        imgView.backgroundColor = [UIColor redColor];
        countImgView.image = [UIImage imageNamed:@"Restaurant_10"];
        [view addSubview:countImgView];
        self.countImgView = countImgView;
                
        //------------------------------------
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, _btn2.bottom, view.width, 80)];
        view1.clipsToBounds = YES;
        //        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [view addSubview:view1];
        self.view1 = view1;

        view.height = view1.bottom;
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kScreen_Width, 20)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:whiteView];
        self.whiteView = whiteView;
        
    }
    
    return self;
    
}

- (void)setModel:(RecipeModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
    
    CGSize textSize = [[NSString stringWithFormat:@" %@",model.name] sizeWithAttributes:@{NSFontAttributeName:_lab4.font}];
    _lab4.width = textSize.width;
    _lab4.text = [NSString stringWithFormat:@" %@",model.name];
    
    // 体质
    for (int i=0; i<model.Constitution.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab4.right+5+i*(30+5), (self.alphaView.height-12)/2.0, 30, 12)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:model.Constitution[i]];
        [self.alphaView addSubview:imgView];
        
    }
    
    [_btn setTitle:model.price forState:UIControlStateNormal];
    
    textSize = [NSString textLength:[NSString stringWithFormat:@"%@份",model.sales] font:_btn1.titleLabel.font];
    _btn1.frame = CGRectMake(_btn2.left-26, _btn2.center.y-7.5, textSize.width, 15);
    [_btn1 setTitle:[NSString stringWithFormat:@"%@份",model.sales] forState:UIControlStateNormal];
    
    self.countImgView.frame = CGRectMake(_btn1.left-20, _btn2.center.y-6, 17, 12);
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.view.width, 1)];
    //        imgView.backgroundColor = [UIColor redColor];
    lineImgView.image = [UIImage imageNamed:@"dotted"];
    [self.view1 addSubview:lineImgView];

    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in model.foodRecipe) {
        RecipeItemModel *model = [RecipeItemModel yy_modelWithJSON:dic];
        [arrM addObject:model];
    }
    
    for (int i = 0; i<arrM.count; i++) {
        RecipeItemModel *model = arrM[i];
        NSString *str1 = model.RecipeItemName;
        
        NSMutableAttributedString *attStr = [NSString text:str1 fullText:[NSString stringWithFormat:@"%@    %@",str1,model.ListFood] location:0 color:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:13]];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10+i*(14+10), _imgView.width-10, 14)];
        _lab1.font = [UIFont boldSystemFontOfSize:12];
        //        _lab1.text = @"匹配度 58%";
        _lab1.textColor = [UIColor colorWithHexString:@"#676767"];
        //        _lab1.textAlignment = NSTextAlignmentRight;
        //        _lab1.backgroundColor = [UIColor redColor];
        [self.view1 addSubview:_lab1];
        _lab1.attributedText = attStr;
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab1.height)];
        img1.image = [UIImage imageNamed:@"xian"];
        //        _imgView.backgroundColor = [UIColor redColor];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_lab1 addSubview:img1];

    }

    
    self.view1.height = arrM.count*24+8;
    
    if (self.model.isExpend) {
        self.view1.hidden = YES;
        self.btn2.selected = YES;
        self.view.height = self.btn2.bottom+6;
        
    }
    else {
        self.view1.hidden = NO;
        self.btn2.selected = NO;
        self.view.height = self.view1.bottom;
        
    }
    self.whiteView.top = self.view.bottom;
    
    _model.cellHeight = self.whiteView.bottom;

//    self.view.height = self.view1.bottom;
//    self.whiteView.top = self.view.bottom;
//    
//    _model.cellHeight = self.whiteView.bottom;
}

- (void)expendAction:(UIButton *)btn
{
    self.model.isExpend = !self.model.isExpend;
    

    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

@end
