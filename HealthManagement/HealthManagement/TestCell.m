//
//  TestCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        wechatBtn.frame = CGRectMake(kScreen_Width-12-20, (52-20)/2, 20, 20);
        [wechatBtn setImage:[UIImage imageNamed:@"nochoose"] forState:UIControlStateNormal];
        [wechatBtn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        [self.contentView addSubview:wechatBtn];
        [wechatBtn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
        self.wechatBtn = wechatBtn;


    }
    return self;
}

- (void)setModel:(ContenModel *)model
{
    _model = model;
    
    if (self.model.isSelected) {
        self.wechatBtn.selected = YES;
        
    }
    else {
        self.wechatBtn.selected = NO;

        
    }
}

- (void)testAction:(UIButton *)btn
{
    self.model.isSelected = !self.model.isSelected;
    
    
    if (self.block) {
        self.block(_model);
    }
}

@end
