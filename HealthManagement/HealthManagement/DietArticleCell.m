//
//  DietArticleCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietArticleCell.h"

@implementation DietArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 70, 70)];
        //        _imgView.image = [UIImage imageNamed:@"recipes_3"];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-12, 20)];
        _lab2.font = [UIFont systemFontOfSize:16];
        _lab2.text = @"科技福克斯京东方方式发送到";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+12, 16, 16)];
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
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView1.right+12, _imgView.bottom-14, kScreen_Width-(_imgView1.right+12)-50-12-12, 14)];
        _lab4.font = [UIFont systemFontOfSize:12];
        _lab4.text = @"2017-21-12 17:09:22";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
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
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 104-10, kScreen_Width, 10)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        
    }
    return self;
}

@end
