//
//  ZWLSlider.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ZWLSlider.h"

@implementation ZWLSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 - (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y, 10, 10);
}

@end
