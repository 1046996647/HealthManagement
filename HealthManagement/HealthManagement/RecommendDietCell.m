//
//  RecommendDietCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietCell.h"

@implementation RecommendDietCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 70, 70)];
        _imgView.image = [UIImage imageNamed:@"food"];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreen_Width-12-50, _imgView.top-3, 50, 30);
        [_btn setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_btn setTitleColor:[UIColor colorWithHexString:@"#FD4900"] forState:UIControlStateNormal];
        [_btn setTitle:@"59" forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom+6, _imgView.width, 16)];
        _lab1.font = [UIFont systemFontOfSize:12];
        _lab1.text = @"匹配度 58%";
        _lab1.textColor = [UIColor grayColor];
//        _lab1.textAlignment = NSTextAlignmentRight;
//        _lab1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-50-12-12, 20)];
        _lab2.font = [UIFont systemFontOfSize:18];
        _lab2.text = @"科技福克斯京东方方式发送到";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(kScreen_Width-12-50, _lab2.bottom+10, 50, 20);
        [_btn1 setImage:[UIImage imageNamed:@"diet_1"] forState:UIControlStateNormal];
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        _btn1.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        _btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
        _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_btn1 setTitle:@"84份" forState:UIControlStateNormal];
        [self.contentView addSubview:_btn1];
        
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+10, 16, 16)];
        _imgView1.image = [UIImage imageNamed:@"shop"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView1];
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView1.right+12, _lab2.bottom+10, kScreen_Width-(_imgView1.right+12)-50-12-12, 16)];
        _lab4.font = [UIFont systemFontOfSize:14];
        _lab4.text = @"优惠滑动满100件20dgdgd";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab4.bottom+6, 16, 16)];
        _imgView2.image = [UIImage imageNamed:@"address"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView2];
        
        _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView2.right+12, _imgView2.top, kScreen_Width-(_imgView2.right+12)-40-12-12-12, 16)];
        _lab5.font = [UIFont systemFontOfSize:14];
        _lab5.text = @"跨境电商返回后防守打法";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab5.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab5];
        
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab5.bottom+6, 16, 16)];
        _imgView3.image = [UIImage imageNamed:@"tag"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView3];
        
        //单行滚动  ===============
        NSArray *tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_imgView3.right+12, _imgView3.top-10, kScreen_Width-_imgView3.right-12-12, 0)];
        _tagsView.type = 1;
        _tagsView.tagSpace = 5;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 20.0;
        _tagsView.titleSize = 12.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor grayColor];
        _tagsView.cornerRadius = 3;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor grayColor];
        [_tagsView setTagAry:tagAry delegate:nil];
        [self.contentView addSubview:_tagsView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 107+5, kScreen_Width, 10)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        
    }
    return self;
}

@end
