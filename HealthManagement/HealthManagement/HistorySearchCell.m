//
//  HistorySearchCell.m
//  
//
//  Created by ZhangWeiLiang on 2017/7/20.
//
//

#import "HistorySearchCell.h"

@implementation HistorySearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *hositoryImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, (35-15)/2, 15, 15)];
        //    leftView.contentMode = UIViewContentModeScaleAspectFit;
        hositoryImg.image = [UIImage imageNamed:@"search_3"];
        [self.contentView addSubview:hositoryImg];
        self.hositoryImg = hositoryImg;
        
        UILabel *hositoryLab = [[UILabel alloc] initWithFrame:CGRectMake(hositoryImg.right+10, hositoryImg.center.y-7,250, 15)];
//        hositoryLab.backgroundColor = [UIColor redColor];
        hositoryLab.font = [UIFont boldSystemFontOfSize:13];
        hositoryLab.textAlignment = NSTextAlignmentLeft;
        //        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:hositoryLab];
        self.hositoryLab = hositoryLab;
    }
    return self;
}

@end
