//
//  ResDetailHeaderView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailHeaderView.h"
#import "ResDetailCollectionViewCell.h"
#import "NSStringExt.h"

@implementation ResDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self addSubview:view];
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, view.bottom+12,kScreen_Width-90-12-12, 16)];
        _lab1.font = [UIFont boldSystemFontOfSize:14];
//        _lab1.text = @"必胜（城北店万达店）";
        //        _lab1.textColor = [UIColor grayColor];
        [self addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_lab1.left, _lab1.bottom+12, kScreen_Width-12-12, 12)];
        _lab2.font = [UIFont systemFontOfSize:12];
//        _lab2.text = @"中餐 1.1km";
        _lab2.textColor = [UIColor colorWithHexString:@"#606060"];
        [self addSubview:_lab2];
    
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+12, _lab2.width, 14)];
//        _lab3.text = @"本月销售5861份    人均 ￥56";
        _lab3.textColor = [UIColor colorWithHexString:@"#606060"];
        _lab3.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lab3];
        
        
        // 
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(242/2, 192/2);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _lab3.bottom+12, kScreen_Width,192/2) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
//        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[ResDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(40, collectionView.bottom+12, kScreen_Width-40-80, 30)];
        _lab5.font = [UIFont systemFontOfSize:12];
        _lab5.text = @"拱墅区祥园路28号";
        //        _lab2.textAlignment = NSTextAlignmentRight;
//        _lab5.textColor = [UIColor grayColor];
        [self addSubview:_lab5];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, _lab5.center.y-9, 15, 18)];
        _imgView.image = [UIImage imageNamed:@"address"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreen_Width-20-12, _lab1.top, 20, 20);
        [btn setImage:[UIImage imageNamed:@"Restaurant_7"] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(btn.left-btn.width-10, _lab1.top, btn.width, btn.height);
        // Restaurant_9
        [btn1 setImage:[UIImage imageNamed:@"Restaurant_8"] forState:UIControlStateNormal];
        [self addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(kScreen_Width-17-12, collectionView.bottom+22, 17, 17);
        [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self addSubview:btn2];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width-35-12, btn2.center.y-15, .5, 25)];
        line.backgroundColor = [UIColor colorWithHexString:@"#D1D1D1"];
        [self addSubview:line];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom+12, kScreen_Width, 5)];
        view1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [self addSubview:view1];
        
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(12, view1.bottom, 100, 40);
        btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitle:@"本店食谱" forState:UIControlStateNormal];
        [self addSubview:btn3];
        
        UIImageView *resImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, btn3.center.y-7, 14, 14)];
        //        imgView.backgroundColor = [UIColor redColor];
        resImgView.image = [UIImage imageNamed:@"Restaurant_6"];
        [view addSubview:resImgView];
        
        
        self.height = btn3.bottom;

    }
    
    return self;
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.images.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ResDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.images[indexPath.item]]];
    return cell;
    
}


- (void)setModel:(ResDetailModel *)model
{
    _model = model;
    _lab1.text = model.name;
    _lab2.text = [NSString stringWithFormat:@"%@ %@",model.category,[NSString meterToKilometer:model.distance]];
    _lab3.text = [NSString stringWithFormat:@"本月销售%@份    人均 ￥%@",model.sales,model.consumption];
    _lab5.text = model.address;

    [self.collectionView reloadData];
    
}



@end
