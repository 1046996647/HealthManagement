//
//  NearbyResView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kWidth (kScreen_Width-12*2-10*2)/3.0


@interface NearbyResView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *viewArr;
@property(nonatomic,strong) NSArray *modelArr;

//@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl * pageControl;


@end
