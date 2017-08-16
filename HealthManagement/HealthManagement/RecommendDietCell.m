//
//  RecommendDietCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietCell.h"
#import "NSStringExt.h"

@implementation RecommendDietCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, 174/2, 164/2)];
        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectZero];
        _lab3.font = [UIFont boldSystemFontOfSize:16];
        _lab3.textColor = [UIColor colorWithHexString:@"#FD4900"];
        [self.contentView addSubview:_lab3];
        
        _imgView4 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView4.image = [UIImage imageNamed:@"money"];
        [self.contentView addSubview:_imgView4];
        
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom+12, _imgView.width, 16)];
        _lab1.font = [UIFont systemFontOfSize:15];
        _lab1.text = @"匹配度 58%";
        _lab1.textColor = [UIColor colorWithHexString:@"#636363"];
//        _lab1.textAlignment = NSTextAlignmentRight;
//        _lab1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-50-12-12, 18)];
        _lab2.font = [UIFont boldSystemFontOfSize:16];
//        _lab2.text = @"蜂蜜水晶包";
        [self.contentView addSubview:_lab2];
        
        _lab6 = [[UILabel alloc] initWithFrame:CGRectZero];
        _lab6.font = [UIFont boldSystemFontOfSize:12];
        _lab6.textColor = [UIColor colorWithHexString:@"#ABABAB"];
        [self.contentView addSubview:_lab6];
        
        _imgView5 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView5.image = [UIImage imageNamed:@"diet_1"];
        [self.contentView addSubview:_imgView5];
    
        
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+14, 16, 15)];
        _imgView1.image = [UIImage imageNamed:@"shop"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView1];
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView1.right+12, _imgView1.center.y-7, kScreen_Width-(_imgView1.right+12)-50-12-12, 14)];
        _lab4.font = [UIFont boldSystemFontOfSize:12];
//        _lab4.text = @"胜必";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab4.bottom+14, 15, 18)];
        _imgView2.image = [UIImage imageNamed:@"address"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView2];
        
        _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView2.right+12, _imgView2.center.y-7, kScreen_Width-(_imgView2.right+12)-12, 14)];
        _lab5.font = [UIFont boldSystemFontOfSize:12];
//        _lab5.text = @"拱墅区祥园路28号";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        _lab5.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab5];
        
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab5.bottom+14, 16, 16)];
        _imgView3.image = [UIImage imageNamed:@"tag"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView3];
        
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_imgView3.right+12, _imgView3.top-10, kScreen_Width-_imgView3.right-12-12, 0)];
        _tagsView.type = 1;
        _tagsView.tagSpace = 4.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 15.0;
        _tagsView.titleSize = 10.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor grayColor];
        _tagsView.cornerRadius = 3;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor grayColor];
//        [_tagsView setTagAry:tagAry delegate:nil];
        [self.contentView addSubview:_tagsView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _lab1.bottom+14, kScreen_Width, 6)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        self.view = view;


        
    }
    return self;
}

- (void)setModel:(RecipeModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
    
    NSInteger percentage = model.ConstitutionPercentage.integerValue;
    
    UIColor *color = nil;
    
    if (90 < percentage) {
        color = [UIColor colorWithHexString:@"#ff0000"];
    }
    if (80 < percentage && percentage <= 90) {
        color = [UIColor colorWithHexString:@"#107909"];
    }
    if (70 < percentage && percentage <= 80) {
        color = [UIColor colorWithHexString:@"#7d28fb"];
    }
    if (60 < percentage && percentage <= 70) {
        color = [UIColor colorWithHexString:@"#0d8bf6"];
    }
    if (60 >= percentage) {
        color = [UIColor colorWithHexString:@"#666666"];
    }
    
    NSMutableAttributedString *attr = [NSString text:[NSString stringWithFormat:@" %@",model.ConstitutionPercentage] fullText:[NSString stringWithFormat:@"匹配度 %@%%",model.ConstitutionPercentage] location:3 color:color font:nil];
    _lab1.attributedText = attr;

    
    CGSize size = [NSString textLength:model.price font:_lab3.font];
    _lab3.frame = CGRectMake(kScreen_Width-size.width-10, 14, size.width, 17);
    _lab3.text = model.price;
//    _lab3.backgroundColor = [UIColor yellowColor];
    
    _imgView4.frame = CGRectMake(_lab3.left-5-18, _lab3.center.y-9, 18, 18);

    _lab2.width = kScreen_Width-(_imgView.right+12)-(kScreen_Width-_imgView4.left)-10;
    _lab2.text = model.name;


    NSString *sale = [NSString stringWithFormat:@"%@份",model.sales];
    size = [NSString textLength:sale font:_lab6.font];
    _lab6.frame = CGRectMake(kScreen_Width-size.width-10, _lab3.bottom+17, size.width, 13);
    _lab6.text = sale;
    
    _imgView5.frame = CGRectMake(_lab6.left-10-12, _lab6.center.y-6, 15, 12);
    
    _lab4.width = kScreen_Width-(_imgView1.right+12)-(kScreen_Width-_imgView5.left)-10;
    _lab4.text = model.Restaurant_Name;
    
    _lab5.text = model.Restaurant_Address;

    [_tagsView setTagAry:model.Tags delegate:nil];


    model.cellHeight = self.view.bottom;

    
}

@end
