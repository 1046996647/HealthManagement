//
//  TLCollectionViewCell.m
//  TLCollectionViewLineLayout-Demo
//
//  Created by andezhou on 15/7/16.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLCollectionViewCell.h"

@implementation TLCollectionViewCell

#pragma mark -
#pragma mark init methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.width-4, self.height-4)];
        _imageView.layer.cornerRadius = 6;
        _imageView.layer.masksToBounds = YES;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

@end
