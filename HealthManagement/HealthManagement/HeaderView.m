//
//  HeaderView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HeaderView.h"


@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    
    //-----------轮播-----------

    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 180*scaleX) delegate:self placeholderImage:nil];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.pageControlDotSize = CGSizeMake(9, 9);
//    cycleScrollView2.currentPageDotColor = [UIColor colorWithHexString:@"#59A43A"]; // 自定义分页控件小圆标颜色
//    cycleScrollView2.pageDotColor = [UIColor whiteColor]; // 其他分页控件小圆标颜色
    cycleScrollView2.currentPageDotImage = [UIImage imageNamed:@"dotGreen"];
    cycleScrollView2.pageDotImage = [UIImage imageNamed:@"dotWhite"];
    [self addSubview:cycleScrollView2];
    self.cycleScrollView2 = cycleScrollView2;
    
    //----------------------
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(12, cycleScrollView2.bottom+16, 80, 18);
    [_btn setImage:[UIImage imageNamed:@"home_3"] forState:UIControlStateNormal];
//    _btn.backgroundColor = [UIColor redColor];
    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn setTitle:@"生龙活虎" forState:UIControlStateNormal];
    [self addSubview:_btn];
    
    // 积分
    NSString *str1 = @"4";
//    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
//    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"升级还需%@积分",str1]];
    NSRange range1 = {4,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    
    _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(_btn.right, _btn.top, 90, 18)];
    _lab1.font = [UIFont systemFontOfSize:12];
//    _lab1.text = @"升级还需";
//    _lab1.backgroundColor = [UIColor cyanColor];
    _lab1.textColor = [UIColor colorWithHexString:@"#868788"];
    _lab1.attributedText = attStr;
    [self addSubview:_lab1];
    
    // 白竖线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width-1)/2, _btn.top, 1, 20)];
    line1.backgroundColor = [UIColor whiteColor];
    [self addSubview:line1];
    
    // 闹铃
    _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-20-12, _lab1.top, 20, 20)];
    _imgView1.image = [UIImage imageNamed:@"home_5"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView1];
    
    // 白竖线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_imgView1.left-10-1, _btn.top, 1, 20)];
    line2.backgroundColor = [UIColor whiteColor];
    [self addSubview:line2];
    
    // 运动
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(line2.left-10-120, _btn.top, 120, 18);
    [_btn1 setImage:[UIImage imageNamed:@"home_4"] forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btn1 setTitleColor:[UIColor colorWithHexString:@"#868788"] forState:UIControlStateNormal];
    [_btn1 setTitle:@"今日已做有氧运动" forState:UIControlStateNormal];
    [self addSubview:_btn1];
    
    //-----------附近餐厅-----------
    _nearbyResView = [[NearbyResView alloc] initWithFrame:CGRectMake(0, _btn1.bottom+16, kScreen_Width, 0)];
    [self addSubview:_nearbyResView];

    //-----------推荐饮食-----------
    _recommendDietView = [[RecommendDietView alloc] initWithFrame:CGRectMake(0, _nearbyResView.bottom+12, kScreen_Width, 0)];
    [self addSubview:_recommendDietView];
//    _recommendDietView.modelArr = nil;
    
    
    //-----------饮食记录-----------
    _dietRecordView = [[DietRecordView alloc] initWithFrame:CGRectMake(0, _recommendDietView.bottom+12, kScreen_Width, 0)];
    [self addSubview:_dietRecordView];
    
    // 视图的高度
    self.height = _dietRecordView.bottom;
    
    //-----------定位-----------
    UIImageView *locationView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 20, 20, 20)];
    locationView.image = [UIImage imageNamed:@"home_1"];
    [self addSubview:locationView];
    
    _userLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userLocationBtn.frame = CGRectMake(locationView.right, 20, kScreen_Width-(locationView.right+10)-12-150-12, 20);
//    [_userLocationBtn setImage:[UIImage imageNamed:@"home_1"] forState:UIControlStateNormal];
//    _userLocationBtn.backgroundColor = [UIColor redColor];
    _userLocationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _userLocationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_userLocationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _userLocationBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    //    [_btn setTitle:@"杭州" forState:UIControlStateNormal];
    [self addSubview:_userLocationBtn];
    
    
//    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(_userLocationBtn.right+10, _userLocationBtn.center.y-40/2, kScreen_Width-(_userLocationBtn.right+10)-12, 40)];
    //-----------搜索-----------
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"home_2"];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kScreen_Width-12-150, _userLocationBtn.center.y-40/2, 150, 40)];
    tf.layer.cornerRadius = tf.height/2.0;
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.layer.masksToBounds = YES;
    tf.placeholder = @"餐厅/菜谱/食物";
    tf.font = [UIFont systemFontOfSize:14];
    [tf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [tf setValue:[UIColor colorWithHexString:@"#868788"] forKeyPath:@"_placeholderLabel.textColor"];
    tf.backgroundColor = [UIColor whiteColor];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self addSubview:tf];
    self.tf = tf;

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

@end
