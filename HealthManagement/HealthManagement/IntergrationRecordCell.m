//
//  IntergrationRecordCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "IntergrationRecordCell.h"

@implementation IntergrationRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, 50, 20)];
        //        _lab1.font = [UIFont systemFontOfSize:15];
        _lab1.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(12, _lab1.bottom+5, 50, 14)];
        _lab2.font = [UIFont systemFontOfSize:13];
        _lab2.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
        [self.contentView addSubview:_lab2];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab2.right+10, (142/2-72/2)/2, 72/2, 72/2)];
        _imgView.image = [UIImage imageNamed:@"integral_5"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        

        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+30, 15, kScreen_Width-(_imgView.right+30)-12, 20)];
        _lab3.font = [UIFont boldSystemFontOfSize:18];        //        _lab2.textAlignment = NSTextAlignmentRight;
        //        _lab3.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lab3];

        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_lab3.left, _lab3.bottom+3, kScreen_Width-_lab3.left-12, 15)];
        _lab4.font = [UIFont systemFontOfSize:13];
        _lab4.textColor = [UIColor colorWithHexString:@"#666666"];
        _lab4.font = [UIFont boldSystemFontOfSize:14];        //        _lab2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lab4];
        
        
    }
    return self;
}

- (void)setModel:(IntergrationRecordModel *)model
{
    _model = model;
    
    _lab1.text = [NSString dateToWeek:model.fullPayTime];
    _lab2.text = [model.fullPayTime substringFromIndex:5];
    
    NSString *str1 = @"+1";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 积分",str1]];
    NSRange range1 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range1];
    _lab3.attributedText = attStr;

    _lab4.text = @"运动3000步";
    
    
//    _lab3.text = model.payableAmount;
//    _lab4.text = [NSString stringWithFormat:@"交易流水号 : %@",model.payId];
}

@end
