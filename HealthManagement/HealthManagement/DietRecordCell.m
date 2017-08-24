//
//  PayRecordCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "DietRecordCell.h"
#import "NSStringExt.h"
#import "PaymentVC.h"

@implementation DietRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (100-65)/2, 65, 65)];
//        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+10, _imgView.top+2, 100, 18)];
        _lab1.font = [UIFont systemFontOfSize:16];
//        _lab1.text = @"姜红糖煮鸡蛋";
//        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab1];
        
        // 滑动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        //        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
        [self.contentView addSubview:scrollView];
        self.scrollView = scrollView;
        
//        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.right+10, _lab1.center.y-8, 33, 12)];
//        _imgView1.image = [UIImage imageNamed:@"气郁质"];
////        _imgView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.contentView addSubview:_imgView1];
        
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-50-12, _lab1.top, 50, 16)];
        _moneyLab.font = [UIFont systemFontOfSize:12];
        _moneyLab.textAlignment = NSTextAlignmentRight;
//        _moneyLab.text = @"￥ 256";
        _moneyLab.textColor = [UIColor redColor];
//        _moneyLab.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_moneyLab];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_lab1.left, _lab1.bottom+5, kScreen_Width-(_imgView.right+10)-12, 16)];
        _lab2.font = [UIFont systemFontOfSize:12];
//        _lab2.text = @"生姜10g，红糖50g，鸡蛋2个";
        _lab2.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreen_Width-50-12, _lab2.bottom+5, 50, 20);
        [_btn setImage:[UIImage imageNamed:@"home_6"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+5, 200, 20)];
//        _lab3.text = @"吉野家  2017年12月10日12:80:00";
        _lab3.textColor = [UIColor grayColor];
        _lab3.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_lab3];
        
        
    }
    return self;
}

- (void)btnAction
{
    PaymentVC *vc = [[PaymentVC alloc] init];
    vc.model = self.model;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setModel:(RecipeModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.RecipeImage]];
    

    CGSize textSize = [NSString textLength:model.RecipeName font:_lab1.font];
    _lab1.text = model.RecipeName;
    
    if (textSize.width > 100) {
        _lab1.width = 100;
    }
    else {
        _lab1.width = textSize.width;

    }

    self.scrollView.frame = CGRectMake(_lab1.right+10, _lab1.top, _moneyLab.left-(_lab1.right+10)-5, 20);
    self.scrollView.contentSize = CGSizeMake(model.Constitution.count*(33+5), 0);
    
    // 体质
    for (int i=0; i<model.Constitution.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(33+5), (self.scrollView.height-12)/2.0, 30, 12)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:model.Constitution[i]];
        [self.scrollView addSubview:imgView];
        
    }
    
    _moneyLab.text = [NSString stringWithFormat:@"￥ %@",model.OrderPrice];
    
    _lab2.text = model.recordItem;


    _lab3.text = [NSString stringWithFormat:@"%@  %@",model.RestaurantName,model.OrderTime];
    

}



@end
