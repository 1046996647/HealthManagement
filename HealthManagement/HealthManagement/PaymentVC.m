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
#import "NSStringExt.h"
#import "ZWLDatePickerView.h"


@interface PaymentVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab5;

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *btn4;
@property(nonatomic,strong) UILabel *fitLab;
@property(nonatomic,strong) UILabel *moneyLab;

@property(nonatomic,strong) UILabel *countLab;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UILabel *timeLab;

@property (nonatomic,strong) UIScrollView *bodyScrollView;



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
//    _lab1.text = @"鸡蛋蔬菜沙拉";
    _lab1.text = self.model.name;
    _lab1.textColor = [UIColor blackColor];
    _lab1.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_lab1];
    
    // 滑动视图
    UIScrollView *bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    bodyScrollView.backgroundColor = [UIColor whiteColor];
    bodyScrollView.showsHorizontalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.scrollView addSubview:bodyScrollView];
    self.bodyScrollView = bodyScrollView;
    
    
    // 费用
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, _lab1.center.y-10, 100, 20)];
    moneyLab.font = [UIFont boldSystemFontOfSize:16];
//    moneyLab.text = @"￥ 89";
//    moneyLab.text = [NSString stringWithFormat:@"￥ %@",self.model.price];
    moneyLab.textColor = [UIColor colorWithHexString:@"#F97A23"];
    moneyLab.textAlignment = NSTextAlignmentRight;
    //    moneyLab.backgroundColor = [UIColor whiteColor];
//    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.scrollView addSubview:moneyLab];
    self.moneyLab = moneyLab;
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, moneyLab.bottom+15, 100, 20)];
    countLab.font = [UIFont boldSystemFontOfSize:12];
//    countLab.text = @"本月销售3434份";
    countLab.textColor = [UIColor grayColor];
    countLab.textAlignment = NSTextAlignmentRight;
    //    moneyLab.backgroundColor = [UIColor whiteColor];
    //    moneyLab.backgroundColor = [UIColor colorWithHexString:@"#F97A23"];
    [self.scrollView addSubview:countLab];
    self.countLab = countLab;
    
    UIImageView *tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(_lab1.left, countLab.bottom+15, 16, 16)];
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
//    [_tagsView setTagAry:self.model.Tags delegate:nil];
    [self.scrollView addSubview:_tagsView];
    

    UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, tagImg.center.y-7, 100, 14)];
    fitLab.font = [UIFont systemFontOfSize:12];
    fitLab.textAlignment = NSTextAlignmentRight;
    //        fitLab.text = @"";
    fitLab.textColor = [UIColor grayColor];
    //        fitLab.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:fitLab];
    self.fitLab = fitLab;

    [self getRecipeItemInfoForPay];

}

// 请求菜谱详情页
- (void)getRecipeItemInfoForPay
{
    [SVProgressHUD show];
    
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    
    if (self.model.ID) {
        [paramDic  setObject:self.model.ID forKey:@"RecipeId"];

    }
    if (self.model.RecipeId) {
        [paramDic  setObject:self.model.RecipeId forKey:@"RecipeId"];
        
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:RecipeItemInfoForPay dic:paramDic Succed:^(id responseObject) {
        
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
            
            _lab1.text = self.model.name;
            
            self.moneyLab.text = [NSString stringWithFormat:@"￥ %@",self.model.price];

            CGSize textSize = [[NSString stringWithFormat:@"本月销售%@份",self.model.sales] sizeWithAttributes:@{NSFontAttributeName:self.countLab.font}];
            self.countLab.frame = CGRectMake(kScreen_Width-textSize.width-12, self.lab1.bottom+15, textSize.width, 20);
            self.countLab.text = [NSString stringWithFormat:@"本月销售%@份",self.model.sales];
            
            self.bodyScrollView.frame = CGRectMake(12, self.countLab.top, self.countLab.left-12-5, 20);
            self.bodyScrollView.contentSize = CGSizeMake(self.model.Constitution.count*(30+5), 0);
            
            // 体质
            for (int i=0; i<self.model.Constitution.count; i++) {
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(30+5), 4, 30, 12)];
                //        imgView.backgroundColor = [UIColor redColor];
                imgView.tag = 100;
                imgView.image = [UIImage imageNamed:self.model.Constitution[i]];
                [self.bodyScrollView  addSubview:imgView];
                
            }
            
            [_tagsView setTagAry:self.model.Tags delegate:nil];
            
            self.model.images = self.model.images;
            [self.collectionView reloadData];

            
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
            
            
        }
        
        NSArray *arr2 = responseObject[@"ListData2"];
        if ([arr2 isKindOfClass:[NSArray class]] && arr2.count > 0) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr2) {
                ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            ResDetailModel *model1 = [arrM firstObject];
            self.model1 = model1;
            
            //CollectionView
            [self initCollectionView:model1];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}


- (void)initCollectionView:(ResDetailModel *)model1
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(242/2, 192/2);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _tagsView.bottom+15, kScreen_Width,192/2) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //        collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[ResDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.scrollView addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, collectionView.bottom+15, kScreen_Width, 10)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view1];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, view1.bottom+15, 70, 70)];
//    _imgView.image = [UIImage imageNamed:@"food"];
//    _imgView.backgroundColor = [UIColor redColor];
    _imgView.layer.cornerRadius = 6;
    _imgView.layer.masksToBounds = YES;
    [self.scrollView addSubview:_imgView];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top+5,kScreen_Width-(_imgView.right+12)-12, 16)];
    _lab2.font = [UIFont systemFontOfSize:14];
    _lab2.text = self.model.name;
    //        _lab1.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab2];
    
    
    _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+12, _lab2.width, 12)];
    _lab3.font = [UIFont systemFontOfSize:12];
//    _lab3.text = @"中餐 1.1km";


    _lab3.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab3];
    
    _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(40, _imgView.bottom+15, kScreen_Width-40-80, 30)];
    _lab5.font = [UIFont systemFontOfSize:12];
//    _lab5.text = @"拱墅区祥园路28号";
    //        _lab2.textAlignment = NSTextAlignmentRight;
    //        _lab5.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab5];
    
    UIImageView *addrssImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, _lab5.center.y-8, 15, 18)];
    addrssImg.image = [UIImage imageNamed:@"address"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:addrssImg];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kScreen_Width-17-12, addrssImg.center.y-8.5, 17, 17);
    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.scrollView addSubview:btn2];
    [btn2 addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width-35-12, btn2.center.y-15, .5, 25)];
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
    [btn3 addTarget:self action:@selector(selectTimeAction) forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView addSubview:btn3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-12-12, (50-12)/2.0, 12, 15)];
    //            imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"assistor"];
    [btn3 addSubview:imgView];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-200-40, 0,200, btn3.height)];
    timeLab.font = [UIFont systemFontOfSize:14];
//    timeLab.text = @"2017年7月7日12:12:12";
    timeLab.textAlignment = NSTextAlignmentRight;
    //        _lab1.textColor = [UIColor grayColor];
    [btn3 addSubview:timeLab];
    self.timeLab = timeLab;
    
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
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model1.titleImage]];
    _lab2.text = model1.name;
    _lab3.text = [NSString stringWithFormat:@"%@ %@",model1.category,[NSString meterToKilometer:model1.distance]];
    _lab5.text = model1.address;
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, self.btn4.bottom+12);


}

- (void)selectTimeAction
{
    ZWLDatePickerView *datepickerView = [[ZWLDatePickerView alloc] initWithFrame:CGRectMake(0,kScreen_Height - 270, kScreen_Width, 270) datePickerMode:UIDatePickerModeDateAndTime];
    datepickerView.dataBlock = ^(NSString *str,NSString *str1) {
        self.timeLab.text = str;
    };
    
    UIViewController *birthdayCtrl = [[UIViewController alloc] init];
    birthdayCtrl.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //淡出淡入
    birthdayCtrl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //            self.definesPresentationContext = YES; //不盖住整个屏幕
    //            birthdayCtrl.dateStr = cell.dataLab.text;
    birthdayCtrl.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [birthdayCtrl.view addSubview:datepickerView];
    
    [self presentViewController:birthdayCtrl animated:YES completion:nil];
}

- (void)callAction
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model1.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

- (void)btnAction:(UIButton *)btn
{
    if (!self.timeLab.text) {
        
        [self.view makeToast:@"请选择到店时间"];
        return;
        
    }
    
    if (btn.tag == 0) {
        
        
        [self payAtShopOrder];
    }
    else {
        
        PayOnlineVC *vc = [[PayOnlineVC alloc] init];
        vc.title = @"在线支付";
        vc.money = [NSString stringWithFormat:@"￥ %@",self.model.price];;
        vc.resName = self.model1.name;
        vc.time = self.timeLab.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)payAtShopOrder
{
    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.timeLab.text forKey:@"AtShopTime"];
    [paramDic  setValue:self.model.ID
                 forKey:@"RecipeId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:PayAtShopOrder dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];

        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            [self.view makeToast:@"下单成功"];
            
            // 下订单成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kAddOrderNotification" object:nil];

            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }
        else {
            [self.view makeToast:[responseObject objectForKey:@"Message"]];

        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
