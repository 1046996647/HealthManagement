//
//  PayRecordCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "DietRecordCell.h"
//#import "NSStringExt.h"

@implementation DietRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (100-65)/2, 65, 65)];
        _imgView.image = [UIImage imageNamed:@"food"];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+10, _imgView.top+2, 100, 18)];
        _lab1.font = [UIFont systemFontOfSize:16];
        _lab1.text = @"姜红糖煮鸡蛋";
//        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab1];
        
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.right+10, _lab1.top, 50, 18)];
        _imgView1.image = [UIImage imageNamed:@"temperament_3"];
//        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView1];
        
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-50-12, _lab1.top, 50, 16)];
        _moneyLab.font = [UIFont systemFontOfSize:14];
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.text = @"￥ 256";
        _moneyLab.textColor = [UIColor redColor];
//        _moneyLab.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_moneyLab];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_lab1.left, _lab1.bottom+5, kScreen_Width-(_imgView.right+10)-12, 16)];
        _lab2.font = [UIFont systemFontOfSize:12];
        _lab2.text = @"生姜10g，红糖50g，鸡蛋2个";
        _lab2.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreen_Width-70-12, _lab2.bottom, 70, 25);
        [_btn setImage:[UIImage imageNamed:@"home_6"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btn];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+5, 200, 20)];
        _lab3.text = @"吉野家  2017年12月10日12:80:00";
        _lab3.textColor = [UIColor grayColor];
        _lab3.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_lab3];
        
        
    }
    return self;
}

//- (void)setModel:(PayRecordModel *)model
//{
//    _model = model;
//    
//    _lab1.text = [NSString dateToWeek:model.fullPayTime];
//    _lab2.text = [model.fullPayTime substringFromIndex:5];
//
//    _lab3.text = model.payableAmount;
//    _lab4.text = [NSString stringWithFormat:@"交易流水号 : %@",model.payId];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
