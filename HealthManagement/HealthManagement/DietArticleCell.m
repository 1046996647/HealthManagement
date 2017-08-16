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
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (104-10-154/2)/2, 170/2, 154/2)];
//        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top, kScreen_Width-(_imgView.right+12)-12, 20)];
        _lab2.font = [UIFont boldSystemFontOfSize:16];
//        _lab2.text = @"糖尿病饮食指南";
        //        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_imgView.right+12, _lab2.bottom+17, 16, 16)];
        _imgView3.image = [UIImage imageNamed:@"tag"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView3];
        
        //单行滚动  ===============
//        NSArray *tagAry = @[@"红烧",@"油闷",@"清蒸"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_imgView3.right+12, _imgView3.top-12, kScreen_Width-_imgView3.right-12-12, 0)];
        _tagsView.type = 1;
        _tagsView.tagSpace = 4.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 15.0;
        _tagsView.titleSize = 10.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor grayColor];
        _tagsView.cornerRadius = 3;
        _tagsView.userInteractionEnabled = NO;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor grayColor];
//        [_tagsView setTagAry:tagAry delegate:nil];
        [self.contentView addSubview:_tagsView];
        
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-120-12, _imgView.bottom-11, 120, 11)];
        _lab4.font = [UIFont boldSystemFontOfSize:10];
//        _lab4.text = @"2017-21-12 17:09:22";
        _lab4.textAlignment = NSTextAlignmentRight;
//        _lab4.backgroundColor = [UIColor redColor];
        _lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab4];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(_imgView3.left+5, _lab4.center.y-5.5, 60, 11);
        [_btn setImage:[UIImage imageNamed:@"browse"] forState:UIControlStateNormal];
//        _btn.backgroundColor = [UIColor redColor];
        _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_btn setTitle:@"6753" forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(_btn.right, _btn.top, 60, 11);
        [_btn1 setImage:[UIImage imageNamed:@"thumbs_normal"] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"thumbs-up"] forState:UIControlStateSelected];
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        _btn1.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _btn1.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_btn1 setTitle:@"7253" forState:UIControlStateNormal];
        [self.contentView addSubview:_btn1];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 104-10, kScreen_Width, 6)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self.contentView addSubview:view];
        self.view = view;

        
    }
    return self;
}

- (void)setModel:(ArticleModel *)model
{
    _model = model;
    
//    if (self.type == 1) {
//        self.view.frame = CGRectMake(0, 104-1, kScreen_Width, 1);
//    }
//    else {
//        self.view.frame = CGRectMake(0, 104-10, kScreen_Width, 10);
//        
//    }
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.TitleImage]];
    _lab2.text = model.title;
    [_tagsView setTagAry:model.tags delegate:nil];
    _lab4.text = model.aTime;
    [_btn setTitle:model.cilckCount forState:UIControlStateNormal];
    [_btn1 setTitle:model.loveCount forState:UIControlStateNormal];
    
    if (model.PointPraise.integerValue == 0) {
        _btn1.selected = NO;
    }
    else {
        _btn1.selected = YES;

    }

}

@end
