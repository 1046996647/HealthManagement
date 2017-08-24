//
//  IntegrationCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "IntegrationCell.h"

@implementation IntegrationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.text = @"运动3000+步";
        self.textLabel.textColor = [UIColor colorWithHexString:@"#414141"];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.detailTextLabel.text = @"07-25";
        self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#414141"];
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        

        UILabel *hositoryLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/3, 0,kScreen_Width/3, 42)];
        //        hositoryLab.backgroundColor = [UIColor redColor];
        hositoryLab.font = [UIFont boldSystemFontOfSize:14];
        hositoryLab.textAlignment = NSTextAlignmentCenter;
        hositoryLab.textColor = [UIColor colorWithHexString:@"#414141"];
        [self.contentView addSubview:hositoryLab];
        self.hositoryLab = hositoryLab;
    }
    return self;
}

- (void)setModel:(IntergrationModel *)model
{
    _model = model;
    self.textLabel.text = model.Content;
    self.detailTextLabel.text = model.Time;
    
    NSString *str1 = nil;
    if (model.ScoreNum.integerValue < 0) {
        str1 = model.ScoreNum;
    }
    else {
        
        str1 = [NSString stringWithFormat:@"+%@",model.ScoreNum];

    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 积分",str1]];
    NSRange range1 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range1];
    self.hositoryLab.attributedText = attStr;

}

@end
