//
//  ResDetailCollectionViewCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailCollectionViewCell.h"

@implementation ResDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
        _imgView.image = [UIImage imageNamed:@"food"];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = 6;
        _imgView.layer.masksToBounds = YES;
//        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
    }
    return self;
}

@end
