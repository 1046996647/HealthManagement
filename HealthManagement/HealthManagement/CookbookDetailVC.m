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
#import "FoodCell.h"
#import "NSStringExt.h"


@interface CookbookDetailVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TLCollectionViewLineLayout *lineLayout;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *borderView;


// 内容视图
@property (nonatomic,strong) UILabel *lab4;
@property (nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *fitLab;

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;


@property(nonatomic,strong) UILabel *moneyLab;

@end

@implementation CookbookDetailVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.fitLab.bottom+12, self.scrollView.width-20, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor colorWithHexString:@"#FB8A00"].CGColor;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

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
    
    self.title = self.model.name;
    
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
//    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    _pageControl = pageControl;
    [scrollView addSubview:_pageControl];
    
    // 内容视图
    [self initContentView];
    
    // 底部视图
    [self initBottomView];
    
    [self getRecipeItemInfo];
}

// 请求菜谱详情页
- (void)getRecipeItemInfo
{
    [SVProgressHUD show];
    
    // 移除体质图片
    for (UIView *view in self.scrollView.subviews) {
        if (view.tag == 100) {
            [view removeFromSuperview];
        }
    }
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.model.ID forKey:@"RecipeId"];
//    [paramDic  setObject:@"2" forKey:@"UserId"];
    //    [paramDic  setObject:self.latitude forKey:@"CoordY"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:RecipeItemInfo dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            self.model = [arrM firstObject];
            
            _pageControl.numberOfPages = self.model.images.count;
            [self.collectionView reloadData];
            
            _lab4.text = self.model.name;

            // 体质
            for (int i=0; i<self.model.Constitution.count; i++) {
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-12-30-i*(30+5), _lab4.center.y-6, 30, 12)];
                //        imgView.backgroundColor = [UIColor redColor];
                imgView.tag = 100;
                imgView.image = [UIImage imageNamed:self.model.Constitution[self.model.Constitution.count-1-i]];
                [self.scrollView  addSubview:imgView];
                
            }
            [_tagsView setTagAry:self.model.Tags delegate:nil];
            
            NSInteger percentage = self.model.ConstitutionPercentage.integerValue;
            
            UIColor *color = nil;
            
            if (90 < percentage) {
                color = [UIColor colorWithHexString:@"#ff0000"];
            }
            if (80 < percentage && percentage <= 90) {
                color = [UIColor colorWithHexString:@"#107909"];
            }
            if (70 < percentage && percentage <= 80) {
                color = [UIColor colorWithHexString:@"#7d28fb"];
            }
            if (60 < percentage && percentage <= 70) {
                color = [UIColor colorWithHexString:@"#0d8bf6"];
            }
            if (60 >= percentage) {
                color = [UIColor colorWithHexString:@"#666666"];
            }
            
            NSMutableAttributedString *attr = [NSString text:self.model.ConstitutionPercentage fullText:[NSString stringWithFormat:@"匹配度%@%%",self.model.ConstitutionPercentage] location:3 color:color font:nil];
            self.fitLab.attributedText = attr;
            
            /////////////////////
            NSMutableArray *arrM1 = [NSMutableArray array];
            for (NSDictionary *dic in self.model.foodRecipe) {
                RecipeItem1Model *model = [RecipeItem1Model yy_modelWithJSON:dic];
                
                if (model.ListFood.count > 0) {
                    
                    for (NSDictionary *dic in model.ListFood) {
                        FoodModel *foodModel = [FoodModel yy_modelWithJSON:dic];
                        
                        NSInteger index = [model.ListFood indexOfObject:dic];
                        
                        NSString *text = nil;
                        if (index == 0) {
                            
                            text = [NSString stringWithFormat:@"%@    %@ %@",model.RecipeItemName,foodModel.FoodName,foodModel.FoodWeight];
                        }
                        else {
                            text = [NSString stringWithFormat:@"            %@ %@",foodModel.FoodName,foodModel.FoodWeight];
                        }
                        
                        foodModel.text = text;
//                        NSDictionary *dic = @{@"text":text,@"id":foodModel.FoodId};
                        [arrM1 addObject:foodModel];
                        
                        NSLog(@"-----%@",text);
                    }
                }
            }
            
            self.dataList = arrM1;
            [self.tableView reloadData];

            self.tableView.height = self.dataList.count*30;

            
            self.scrollView.contentSize = CGSizeMake(kScreen_Width, self.tableView.bottom+12);
            
            
            self.moneyLab.text = [NSString stringWithFormat:@"￥ %@",self.model.price];

        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
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
//    moneyLab.text = @"￥ 89";
    moneyLab.textColor = [UIColor whiteColor];
    moneyLab.textAlignment = NSTextAlignmentCenter;
//    moneyLab.backgroundColor = [UIColor whiteColor];
//    moneyLab.backgroundColor = [UIColor colorWithRed:249 green:125 blue:47 alpha:1];
    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.view addSubview:moneyLab];
    self.moneyLab = moneyLab;
    
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
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}



// 内容视图
- (void)initContentView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom+5, kScreen_Width, 20)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(12, view.bottom+10, 100, 20)];
    _lab4.font = [UIFont systemFontOfSize:14];
//    _lab1.text = @"鸡蛋蔬菜沙拉";
    _lab4.textColor = [UIColor blackColor];
    _lab4.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_lab4];
    
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _lab4.bottom+10, kScreen_Width, 1)];
    //        imgView.backgroundColor = [UIColor redColor];
    lineImgView.image = [UIImage imageNamed:@"dotted"];
    [self.scrollView  addSubview:lineImgView];
    
    UIImageView *tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(_lab4.left, lineImgView.bottom+10, 16, 16)];
    tagImg.image = [UIImage imageNamed:@"tag"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:tagImg];
    
    //单行滚动  ===============
//    NSArray *tagAry = @[@"红烧",@"油闷",@"清蒸"];
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
//    [_tagsView setTagAry:tagAry delegate:nil];
    [self.scrollView addSubview:_tagsView];
    

    UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, tagImg.center.y-7, 100, 14)];
    fitLab.font = [UIFont systemFontOfSize:12];
    fitLab.textAlignment = NSTextAlignmentRight;
    //        fitLab.text = @"";
    fitLab.textColor = [UIColor grayColor];
    //        fitLab.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:fitLab];
    self.fitLab = fitLab;
    
    // 表视图
    [self.scrollView addSubview:self.tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = self.lineLayout.itemSize.width + self.lineLayout.minimumLineSpacing;
    NSInteger item = offsetX/width;
    
    _pageControl.currentPage = item;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.reloadFoodBlock = ^{
            [self getRecipeItemInfo];
        };
    }
    
    FoodModel *model = self.dataList[indexPath.row];
    
    cell.model = model;

    return cell;
}

#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
//    NSString *imageName = [NSString stringWithFormat:@"bg%zi.jpg", indexPath.item%3];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.images[indexPath.item]]];
    
    return cell;
}

@end
