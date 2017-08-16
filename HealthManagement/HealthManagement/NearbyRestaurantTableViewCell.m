//
//  NearbyRestaurantTableViewCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyRestaurantTableViewCell.h"
#import "NSStringExt.h"

@implementation NearbyRestaurantTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.clipsToBounds = YES;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, 188/2, 194/2)];
//        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-50-12, _imgView.top+2, 50, 13)];
        _lab1.font = [UIFont boldSystemFontOfSize:12];
//        _lab1.text = @"190m";
        _lab1.textAlignment = NSTextAlignmentRight;
//        _lab1.backgroundColor = [UIColor redColor];545354
        _lab1.textColor = [UIColor colorWithHexString:@"#545354"];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-50-12-12, 17)];
        _lab2.font = [UIFont boldSystemFontOfSize:16];
//        _lab2.text = @"必胜（城北店万达店）";
//        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+12, kScreen_Width-(_imgView.right+12)-12, 13)];
        _lab3.font = [UIFont boldSystemFontOfSize:12];
//        _lab3.text = @"本月销售5861份    人均 ￥56";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab3.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab3];
        
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab3.bottom+12, 12, 14)];
        _imgView1.image = [UIImage imageNamed:@"Restaurant_3"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView1];
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView1.right+10, _imgView1.center.y-6.5, kScreen_Width-(_imgView1.right+12)-12, 13)];
        _lab4.font = [UIFont boldSystemFontOfSize:12];
//        _lab4.text = @"优惠活动满100件20";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreen_Width-17-8, _lab4.bottom+10, 17, 17);
        [_btn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        [_btn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width-40-12, _btn.top, 1, 15)];
        line.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [self.contentView addSubview:line];
        
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView1.bottom+12, 15, 18)];
        _imgView2.image = [UIImage imageNamed:@"address"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView2];
        
        _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView2.right+10, _imgView2.center.y-6.5, kScreen_Width-(_imgView2.right+12)-17-12-12, 13)];
        _lab5.font = [UIFont boldSystemFontOfSize:12];
        _lab5.text = @"拱墅区祥园路28号";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab5.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab5];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _imgView.bottom+14, kScreen_Width, 6)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        self.view = view;
        
    }
    return self;
}

- (void)callAction
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

- (void)setModel:(ResDetailModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
    _lab1.text = [NSString meterToKilometer:model.distance];
    _lab2.text = model.name;
    _lab3.text = [NSString stringWithFormat:@"本月销售%@份    人均 ￥%@",model.sales,model.consumption];
    _lab4.text = model.discount;
    _lab5.text = model.address;

    _model.cellHeight = self.view.bottom;
    
}



@end
