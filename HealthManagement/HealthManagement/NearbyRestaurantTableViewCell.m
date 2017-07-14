//
//  NearbyRestaurantTableViewCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyRestaurantTableViewCell.h"

@implementation NearbyRestaurantTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (107-85)/2, 85, 85)];
        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-40-12, _imgView.top+2, 40, 16)];
        _lab1.font = [UIFont systemFontOfSize:14];
        _lab1.text = @"190m";
        _lab1.textAlignment = NSTextAlignmentRight;
//        _lab1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-50-12-12, 20)];
        _lab2.font = [UIFont systemFontOfSize:18];
        _lab2.text = @"必胜（城北店万达店）";
//        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+6, kScreen_Width-(_imgView.right+12)-12, 16)];
        _lab3.font = [UIFont systemFontOfSize:14];
        _lab3.text = @"本月销售5861份    人均 ￥56";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab3.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab3];
        
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab3.bottom+6, 16, 16)];
        _imgView1.image = [UIImage imageNamed:@"Restaurant_3"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView1];
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView1.right+12, _lab3.bottom+6, kScreen_Width-(_imgView1.right+12)-12, 16)];
        _lab4.font = [UIFont systemFontOfSize:14];
        _lab4.text = @"优惠活动满100件20";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreen_Width-40-8, _lab4.bottom-5, 40, 40);
        [_btn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width-40-12, _lab4.bottom+6, 1, 20)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:line];
        
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab4.bottom+6, 16, 16)];
        _imgView2.image = [UIImage imageNamed:@"address"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView2];
        
        _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView2.right+12, _lab4.bottom+6, kScreen_Width-(_imgView2.right+12)-40-12-12, 16)];
        _lab5.font = [UIFont systemFontOfSize:14];
        _lab5.text = @"拱墅区祥园路28号";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab5.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab5];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 107, kScreen_Width, 10)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        
    }
    return self;
}



@end
