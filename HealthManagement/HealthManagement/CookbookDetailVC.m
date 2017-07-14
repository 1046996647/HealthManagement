//
//  CookbookDetailVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CookbookDetailVC.h"
#import "TLCollectionViewCell.h"
#import "TLCollectionViewLineLayout.h"
#import "HXTagsView.h"
#import "PaymentVC.h"


@interface CookbookDetailVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TLCollectionViewLineLayout *lineLayout;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollView;


// 内容视图
@property (nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) HXTagsView *tagsView;


@end

@implementation CookbookDetailVC

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _lineLayout = [[TLCollectionViewLineLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, (kScreen_Height-64)/2)
                                             collectionViewLayout:_lineLayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
//        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //        _collectionView.backgroundView = self.imageView;
        [_collectionView registerClass:[TLCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
//        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]
//                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
//                                        animated:YES];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"鸡蛋蔬菜沙拉";
    
//    [self.view addSubview:self.collectionView];
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-70)];
//    scrollView.pagingEnabled = YES;
//    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [scrollView addSubview:self.collectionView];

    
    // 添加pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, self.collectionView.bottom-10, kScreen_Width, 20);
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#B8B9BA"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#59A43A"];
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    _pageControl = pageControl;
    [scrollView addSubview:_pageControl];
    
    // 内容视图
    [self initContentView];
    
    // 底部视图
    [self initBottomView];
}

// 底部视图
- (void)initBottomView
{
    // 餐厅
    UIButton *resBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resBtn.frame = CGRectMake(0, kScreen_Height-64-40, 60, 40);
//    [resBtn setImage:[UIImage imageNamed:@"recipes_4"] forState:UIControlStateNormal];
    resBtn.backgroundColor = [UIColor colorWithHexString:@"#0F8EDE"];
    [self.view addSubview:resBtn];
    
    UIImageView *resImgView = [[UIImageView alloc] initWithFrame:CGRectMake((resBtn.width-15)/2.0, 5, 15, 15)];
    //        imgView.backgroundColor = [UIColor redColor];
    resImgView.image = [UIImage imageNamed:@"recipes_4"];
    [resBtn  addSubview:resImgView];
    
    UILabel *resLab = [[UILabel alloc] initWithFrame:CGRectMake(0, resImgView.bottom, resBtn.width, 14)];
    resLab.font = [UIFont systemFontOfSize:12];
    resLab.text = @"餐厅";
    resLab.textColor = [UIColor whiteColor];
    resLab.textAlignment = NSTextAlignmentCenter;
    [resBtn addSubview:resLab];
    
    // 费用
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(resBtn.right, resBtn.top, kScreen_Width-resBtn.width, resBtn.height)];
    moneyLab.font = [UIFont boldSystemFontOfSize:18];
    moneyLab.text = @"￥ 89";
    moneyLab.textColor = [UIColor whiteColor];
    moneyLab.textAlignment = NSTextAlignmentCenter;
//    moneyLab.backgroundColor = [UIColor whiteColor];
//    moneyLab.backgroundColor = [UIColor colorWithRed:249 green:125 blue:47 alpha:1];
    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.view addSubview:moneyLab];
    
    // 购物车
    UIButton *shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBtn.frame = CGRectMake(kScreen_Width-12-60, kScreen_Height-64-60, 60, 55);
    [shopBtn setImage:[UIImage imageNamed:@"shopCar"] forState:UIControlStateNormal];
    [shopBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopBtn];

    
}

- (void)btnAction
{
    
    PaymentVC *vc = [[PaymentVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



// 内容视图
- (void)initContentView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom+5, kScreen_Width, 20)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, view.bottom+10, 100, 20)];
    _lab1.font = [UIFont systemFontOfSize:14];
    _lab1.text = @"鸡蛋蔬菜沙拉";
    _lab1.textColor = [UIColor blackColor];
    _lab1.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_lab1];
    
    // 体质
    NSArray *bodyArr = @[@"temperament_1",@"temperament_2",@"temperament_3"];
    for (int i=0; i<bodyArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-12-30-i*(30+5), _lab1.center.y-5, 30, 10)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:bodyArr[i]];
        [self.scrollView  addSubview:imgView];
        
    }
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _lab1.bottom+10, kScreen_Width, 1)];
    //        imgView.backgroundColor = [UIColor redColor];
    lineImgView.image = [UIImage imageNamed:@"dotted"];
    [self.scrollView  addSubview:lineImgView];
    
    UIImageView *tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.left, lineImgView.bottom+10, 16, 16)];
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
    
    // 有色边框
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(10, fitLab.bottom+12, self.scrollView.width-20, 0)];
    borderView.layer.borderWidth = 1;
    borderView.layer.borderColor = [UIColor colorWithHexString:@"#FB8A00"].CGColor;
    borderView.layer.cornerRadius = 5;
    borderView.layer.masksToBounds = YES;
    [self.scrollView addSubview:borderView];
    
    //--------------------------------------------
    str1 = @"主食";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    米饭290g",str1]];
    NSRange range2 = {0,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
    
    _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, borderView.width-20, 14)];
    _lab1.font = [UIFont systemFontOfSize:12];
    //        _lab1.text = @"匹配度 58%";
    _lab1.textColor = [UIColor grayColor];
    _lab1.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [borderView addSubview:_lab1];
    _lab1.attributedText = attStr;
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab1.height)];
    img1.image = [UIImage imageNamed:@"xian"];
    //        _imgView.backgroundColor = [UIColor redColor];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_lab1 addSubview:img1];
    
    NSArray *likeArr = @[@"recipes_2",@"recipes_1"];
    for (int i=0; i<likeArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.width-15-i*(15+10), (14-15)/2, 15, 15)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:likeArr[i]];
        [_lab1  addSubview:imgView];
        
    }
    
    //--------------------------------------------
    str1 = @"配菜";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    黑木耳292g",str1]];
    //        range1 = {2,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
    
    _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_lab1.left, _lab1.bottom+10, _lab1.width, 14)];
    _lab2.font = [UIFont systemFontOfSize:12];
    //        _lab1.text = @"匹配度 58%";
    _lab2.textColor = [UIColor grayColor];
    _lab2.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [borderView addSubview:_lab2];
    _lab2.attributedText = attStr;
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab2.height)];
    img2.image = [UIImage imageNamed:@"xian"];
    //        _imgView.backgroundColor = [UIColor redColor];
    [_lab2 addSubview:img2];
    
    for (int i=0; i<likeArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab2.width-15-i*(15+10), (14-15)/2, 15, 15)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:likeArr[i]];
        [_lab2  addSubview:imgView];
        
    }
    
    //--------------------------------------------
    str1 = @"水果";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    水果沙拉292g",str1]];
    //        range1 = {2,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];

    _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab1.left, _lab2.bottom+10, _lab1.width, 14)];
    _lab3.font = [UIFont systemFontOfSize:12];
    //        _lab1.text = @"匹配度 58%";
    _lab3.textColor = [UIColor grayColor];
    //        _lab1.textAlignment = NSTextAlignmentRight;
    //        _lab1.backgroundColor = [UIColor redColor];
    [borderView addSubview:_lab3];
    _lab3.attributedText = attStr;
    
    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 1, _lab3.height)];
    img3.image = [UIImage imageNamed:@"xian"];
    //        _imgView.backgroundColor = [UIColor redColor];
    [_lab3 addSubview:img3];
    
    for (int i=0; i<likeArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab3.width-15-i*(15+10), (14-15)/2, 15, 15)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.image = [UIImage imageNamed:likeArr[i]];
        [_lab3  addSubview:imgView];
        
    }

    borderView.height = _lab3.bottom+12;
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, borderView.bottom+12);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat width = self.lineLayout.itemSize.width + self.lineLayout.minimumLineSpacing;
//    NSInteger item = offsetX/width;
//    
//    _pageControl.currentPage = item;
//    
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = self.lineLayout.itemSize.width + self.lineLayout.minimumLineSpacing;
    NSInteger item = offsetX/width;
    
    _pageControl.currentPage = item;
}

#pragma mark -
#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
//    NSString *imageName = [NSString stringWithFormat:@"bg%zi.jpg", indexPath.item%3];
    cell.imageView.image = [UIImage imageNamed:@"cook"];
    
    return cell;
}

@end
