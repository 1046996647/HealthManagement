//
//  PaymentVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PaymentVC.h"
#import "HXTagsView.h"
#import "ResDetailCollectionViewCell.h"
#import "PayOnlineVC.h"


@interface PaymentVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab5;

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *btn4;


@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.title = @"支付";
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 100, 20)];
    _lab1.font = [UIFont systemFontOfSize:14];
    _lab1.text = @"鸡蛋蔬菜沙拉";
    _lab1.textColor = [UIColor blackColor];
    _lab1.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_lab1];
    
    // 体质
    NSArray *bodyArr = @[@"temperament_1",@"temperament_2",@"temperament_3"];
    for (int i=0; i<bodyArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12+i*(30+5), _lab1.bottom+15, 30, 10)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:bodyArr[i]];
        [self.scrollView  addSubview:imgView];
        
    }
    
    // 费用
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-50-12, _lab1.center.y-10, 50, 20)];
    moneyLab.font = [UIFont boldSystemFontOfSize:16];
    moneyLab.text = @"￥ 89";
    moneyLab.textColor = [UIColor colorWithHexString:@"#F97A23"];
    moneyLab.textAlignment = NSTextAlignmentRight;
    //    moneyLab.backgroundColor = [UIColor whiteColor];
//    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.scrollView addSubview:moneyLab];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, moneyLab.bottom+15, 100, 20)];
    countLab.font = [UIFont boldSystemFontOfSize:12];
    countLab.text = @"本月销售3434份";
    countLab.textColor = [UIColor grayColor];
    countLab.textAlignment = NSTextAlignmentRight;
    //    moneyLab.backgroundColor = [UIColor whiteColor];
    //    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.scrollView addSubview:countLab];
    
    UIImageView *tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.left, countLab.bottom+15, 16, 16)];
    tagImg.image = [UIImage imageNamed:@"tag"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:tagImg];
    
    //单行滚动  ===============
    NSArray *tagAry = @[@"红烧",@"油闷",@"清蒸"];
    //    单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(tagImg.right+12, tagImg.top-12, kScreen_Width-tagImg.right-12-12, 0)];
    _tagsView.type = 1;
    _tagsView.tagSpace = 5;
    _tagsView.showsHorizontalScrollIndicator = NO;
    _tagsView.tagHeight = 20.0;
    _tagsView.titleSize = 12.0;
    _tagsView.tagOriginX = 0.0;
    _tagsView.titleColor = [UIColor grayColor];
    _tagsView.cornerRadius = 3;
    _tagsView.backgroundColor = [UIColor clearColor];
    _tagsView.borderColor = [UIColor grayColor];
    [_tagsView setTagAry:tagAry delegate:nil];
    [self.scrollView addSubview:_tagsView];
    
    NSString *str1 = @"88";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度%@%%",str1]];
    NSRange range1 = {3,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#107909"] range:range1];
    UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, tagImg.center.y-7, 100, 14)];
    fitLab.font = [UIFont systemFontOfSize:12];
    fitLab.textAlignment = NSTextAlignmentRight;
    //        fitLab.text = @"";
    fitLab.textColor = [UIColor grayColor];
    //        fitLab.backgroundColor = [UIColor yellowColor];
    fitLab.attributedText = attStr;
    [self.scrollView addSubview:fitLab];
    
    //CollectionView
    [self initCollectionView];

}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 80);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _tagsView.bottom+15, kScreen_Width,80) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //        collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[ResDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.scrollView addSubview:collectionView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, collectionView.bottom+15, kScreen_Width, 10)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view1];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, view1.bottom+15, 70, 70)];
    _imgView.image = [UIImage imageNamed:@"food"];
    _imgView.backgroundColor = [UIColor redColor];
    _imgView.layer.cornerRadius = 6;
    _imgView.layer.masksToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:_imgView];
    
    _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top+5,kScreen_Width-(_imgView.right+12)-12, 16)];
    _lab2.font = [UIFont systemFontOfSize:14];
    _lab2.text = @"必胜（城北店万达店）";
    //        _lab1.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab2];
    
    _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+12, _lab2.width, 12)];
    _lab3.font = [UIFont systemFontOfSize:12];
    _lab3.text = @"中餐 1.1km";
    _lab3.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab3];
    
    _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(40, _imgView.bottom+15, kScreen_Width-40-80, 30)];
    _lab5.font = [UIFont systemFontOfSize:12];
    _lab5.text = @"拱墅区祥园路28号";
    //        _lab2.textAlignment = NSTextAlignmentRight;
    //        _lab5.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab5];
    
    UIImageView *addrssImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, _lab5.center.y-8, 16, 16)];
    addrssImg.image = [UIImage imageNamed:@"address"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:addrssImg];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kScreen_Width-20-12, _imgView.bottom+15, 20, 20);
    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.scrollView addSubview:btn2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btn2.left-12-1, btn2.center.y-15, 1, 30)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:line];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom+20, kScreen_Width, 10)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, view2.bottom, kScreen_Width, 50);
//    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn3 setTitle:@"  选择到店时间" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:btn3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-12-12, (50-12)/2.0, 12, 15)];
    //            imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"assistor"];
    [btn3 addSubview:imgView];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-200-40, 0,200, btn3.height)];
    timeLab.font = [UIFont systemFontOfSize:14];
    timeLab.text = @"2017年7月7日12:12:12";
    timeLab.textAlignment = NSTextAlignmentRight;
    //        _lab1.textColor = [UIColor grayColor];
    [btn3 addSubview:timeLab];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, btn3.bottom, kScreen_Width, 10)];
    view3.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view3];
    
    NSArray *payArr = @[@"pay_2",@"pay_1"];
    NSArray *titleArr = @[@"到店支付",@"在线支付"];
    for (int i=0; i<payArr.count; i++) {
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame = CGRectMake((kScreen_Width/2)*i, view3.bottom, kScreen_Width/2, 150);
        [btn4 setImage:[UIImage imageNamed:payArr[i]] forState:UIControlStateNormal];
        btn4.tag = i;
        //    _nearbyBtn.backgroundColor = [UIColor redColor];
        btn4.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        btn4.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
        btn4.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn4 setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn4];
        [btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        if (i == 0) {
            UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width/2, 10, 1, 130)];
            view3.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
            [btn4 addSubview:view3];
            self.btn4 = btn4;
        }
        
    }
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, self.btn4.bottom+12);


}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
    }
    else {
        PayOnlineVC *vc = [[PayOnlineVC alloc] init];
        vc.title = @"在线支付";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ResDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    return cell;
    
}

@end
