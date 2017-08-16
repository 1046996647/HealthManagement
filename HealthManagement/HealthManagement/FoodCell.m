//
//  FoodCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = [UIColor redColor];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _lab1.font = [UIFont boldSystemFontOfSize:12];
//        _lab1.text = text;
        _lab1.textColor = [UIColor colorWithHexString:@"#676767"];
        _lab1.textAlignment = NSTextAlignmentLeft;
        //                _lab1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lab1];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        img1.image = [UIImage imageNamed:@"xian"];
        //        _imgView.backgroundColor = [UIColor redColor];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_lab1 addSubview:img1];
        self.img1 = img1;
        
        _unLikeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        //        imgView.backgroundColor = [UIColor redColor];
        [_unLikeBtn setImage:[UIImage imageNamed:@"recipes_6"] forState:UIControlStateNormal];
        [_unLikeBtn setImage:[UIImage imageNamed:@"recipes_2"] forState:UIControlStateSelected];
        _unLikeBtn.tag = 0;
        [_unLikeBtn addTarget:self action:@selector(isLikeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_unLikeBtn];
        
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        //        imgView.backgroundColor = [UIColor redColor];
        [_likeBtn setImage:[UIImage imageNamed:@"recipes_1"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"recipes_5"] forState:UIControlStateSelected];
        _likeBtn.tag = 1;

        [_likeBtn addTarget:self action:@selector(isLikeAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_likeBtn];
        
        
    }
 
    return self;
}

- (void)isLikeAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.Opertion = @"Insert";
        
    }
    else {
        self.Opertion = @"Delete";
        
    }
    
    if (btn.tag == 0) {
        self.Type_Like = @"foodunlike";
        

    }
    else {
        self.Type_Like = @"foodlike";

    }
    
    [self getCustomerLikeOrNot];
}

// 喜好请求
- (void)getCustomerLikeOrNot
{
    [SVProgressHUD show];
    
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.model.FoodId forKey:@"OtherId"];
//    [paramDic  setObject:@"2" forKey:@"UserId"];
    [paramDic  setObject:self.Type_Like forKey:@"Type_Like"];
    [paramDic  setObject:self.Opertion forKey:@"Opertion"];
    //    [paramDic  setObject:self.latitude forKey:@"CoordY"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:CustomerLikeOrNot dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        if (self.reloadFoodBlock) {
            self.reloadFoodBlock();
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}

- (void)setModel:(FoodModel *)model
{
    _model = model;
    
    if (model.type == 1) {
        _lab1.frame = CGRectMake(8, (35-16)/2.0, kScreen_Width-20-60, 16);
        _lab1.font = [UIFont boldSystemFontOfSize:15];
        _lab1.text = model.text;
        
        _img1.frame = CGRectMake(36, 0, 1, _lab1.height);
        
        _unLikeBtn.hidden = YES;
        _likeBtn.hidden = YES;
        
        NSString *subText = [model.text substringToIndex:1];
        
        if (![subText isEqualToString:@" "]) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:model.text];
            NSRange range2 = {0,2};
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [attStr addAttribute:NSFontAttributeName
             
                           value:[UIFont boldSystemFontOfSize:15]
             
                           range:range2];
            
            _lab1.attributedText = attStr;
            
            _img1.hidden = NO;
        }
        else {
            _img1.hidden = YES;
            
        }
    }
    else {
        // self.width不起作用
        _lab1.frame = CGRectMake(10, (30-14)/2.0, kScreen_Width-20-60, 14);
        _lab1.text = model.text;
        
        _img1.frame = CGRectMake(30, 0, 1, _lab1.height);
        
        _unLikeBtn.frame = CGRectMake(kScreen_Width-20-12-15, _lab1.center.y-7.5, 15, 15);
        
        _likeBtn.frame = CGRectMake(_unLikeBtn.left-10-15, _lab1.center.y-7.5, 15, 15);
        
        NSString *subText = [model.text substringToIndex:1];
        
        if (![subText isEqualToString:@" "]) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:model.text];
            NSRange range2 = {0,2};
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [attStr addAttribute:NSFontAttributeName
             
                           value:[UIFont boldSystemFontOfSize:13]
             
                           range:range2];
            
            _lab1.attributedText = attStr;
            
            _img1.hidden = NO;
        }
        else {
            _img1.hidden = YES;
            
        }
        
        if (model.WhetherLike.integerValue == 0) {
            _unLikeBtn.selected = NO;
            _likeBtn.selected = NO;
        }
        else if (model.WhetherLike.integerValue == 1) {
            
            _unLikeBtn.selected = YES;
            _likeBtn.selected = NO;
            
        } else {
            
            _unLikeBtn.selected = NO;
            _likeBtn.selected = YES;
            
        }

    }
    
    


}

@end
