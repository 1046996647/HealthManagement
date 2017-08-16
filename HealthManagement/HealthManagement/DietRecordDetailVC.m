//
//  DietRecordDetailVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietRecordDetailVC.h"
#import "HXTagsView.h"
#import "FoodCell.h"
#import "NSStringExt.h"

@interface DietRecordDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UILabel *fitLab;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab5;


@end

@implementation DietRecordDetailVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.fitLab.bottom+12, self.scrollView.width-20, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.layer.borderWidth = 1;
//        _tableView.layer.borderColor = [UIColor colorWithHexString:@"#FB8A00"].CGColor;
//        _tableView.layer.cornerRadius = 5;
//        _tableView.layer.masksToBounds = YES;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *arrM1 = [NSMutableArray array];
    for (int i=0;i<3;i++) {
//        FoodModel *foodModel = [FoodModel yy_modelWithJSON:dic];
        FoodModel *foodModel = [[FoodModel alloc] init];
        
//        text = [NSString stringWithFormat:@"%@    %@ %@",@"主食",@"米饭",@"270g"];
//
        foodModel.text = [NSString stringWithFormat:@"%@    %@ %@",@"主食",@"米饭",@"270g"];
        [arrM1 addObject:foodModel];
//        
//        NSLog(@"-----%@",text);
    }
    
    self.dataList = arrM1;
    
    [self initSubviews];


}

- (void)initSubviews
{
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-45)];
    //    scrollView.pagingEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 12)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(12, view.bottom+12, 100, 20)];
    _lab4.font = [UIFont boldSystemFontOfSize:16];
    _lab4.text = @"鸡蛋蔬菜沙拉";
    _lab4.textColor = [UIColor blackColor];
    _lab4.textAlignment = NSTextAlignmentLeft;
    //        _lab1.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_lab4];
    
    NSArray *arr = @[@"湿热质",@"气虚质",@"阴虚质"];
    // 体质
    for (int i=0; i<arr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-12-35-i*(35+5), _lab4.center.y-6.5, 35, 13)];
        //        imgView.backgroundColor = [UIColor redColor];
        imgView.tag = 100;
        imgView.image = [UIImage imageNamed:arr[arr.count-1-i]];
        [self.scrollView  addSubview:imgView];
        
    }
    
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _lab4.bottom+12, kScreen_Width, 1)];
    lineImgView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
//    lineImgView.image = [UIImage imageNamed:@"dotted"];
    [self.scrollView  addSubview:lineImgView];
    
    UIImageView *tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(_lab4.left, lineImgView.bottom+10, 16, 16)];
    tagImg.image = [UIImage imageNamed:@"tag"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:tagImg];
    
    //单行滚动  ===============
    NSArray *tagAry = @[@"红烧",@"油闷",@"清蒸"];
    //    单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(tagImg.right+12, tagImg.top-10, kScreen_Width-tagImg.right-12-12, 0)];
    _tagsView.type = 1;
    _tagsView.tagSpace = 5;
    _tagsView.tagHorizontalSpace = 5;
    _tagsView.showsHorizontalScrollIndicator = NO;
    _tagsView.tagHeight = 15.0;
    _tagsView.titleSize = 10.0;
    _tagsView.tagOriginX = 0.0;
    _tagsView.titleColor = [UIColor grayColor];
    _tagsView.cornerRadius = 3;
    _tagsView.backgroundColor = [UIColor clearColor];
    _tagsView.borderColor = [UIColor grayColor];
    [_tagsView setTagAry:tagAry delegate:nil];
    [self.scrollView addSubview:_tagsView];
    
    
    UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-100-12, tagImg.center.y-7, 100, 14)];
    fitLab.font = [UIFont systemFontOfSize:13];
    fitLab.textAlignment = NSTextAlignmentRight;
    //        fitLab.text = @"";
    fitLab.textColor = [UIColor grayColor];
    //        fitLab.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:fitLab];
    self.fitLab = fitLab;
    
    NSInteger percentage = 68;

    
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
    
    NSMutableAttributedString *attr = [NSString text:@"68" fullText:[NSString stringWithFormat:@"匹配度%@%%",@"68"] location:3 color:color font:nil];
    self.fitLab.attributedText = attr;
    
    // 表视图
    [self.scrollView addSubview:self.tableView];
    self.tableView.height = self.dataList.count*35;

    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom+21, kScreen_Width, 12)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    UILabel *priceLab = [UILabel labelWithframe:CGRectMake(0, view.bottom+15, 100, 18) text:@"  价格" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#000000"];
    [self.scrollView addSubview:priceLab];
    
    UILabel *priceLab1 = [UILabel labelWithframe:CGRectMake(kScreen_Width-150-10, view.bottom+15, 150, priceLab.height) text:@"￥ 65" font:priceLab.font textAlignment:NSTextAlignmentRight textColor:@"#FA6900"];
    [self.scrollView addSubview:priceLab1];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, priceLab1.bottom+15, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];

    UILabel *timeLab = [UILabel labelWithframe:CGRectMake(0, view.bottom+15, 100, priceLab.height) text:@"  时间" font:priceLab.font textAlignment:NSTextAlignmentLeft textColor:@"#000000"];
    [self.scrollView addSubview:timeLab];
    
    UILabel *timeLab1 = [UILabel labelWithframe:CGRectMake(kScreen_Width-200-10, view.bottom+15, 200, priceLab.height) text:@"2017-08-17 12:12:12" font:priceLab.font textAlignment:NSTextAlignmentRight textColor:@"#515151"];
    [self.scrollView addSubview:timeLab1];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, timeLab1.bottom+15, kScreen_Width, 12)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, view.bottom+6, 50, 50)];
    _imgView.image = [UIImage imageNamed:@"food"];
    //    _imgView.backgroundColor = [UIColor redColor];
    _imgView.layer.cornerRadius = 6;
    _imgView.layer.masksToBounds = YES;
    [self.scrollView addSubview:_imgView];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+12, _imgView.top+5,kScreen_Width-(_imgView.right+12)-12, 17)];
    _lab2.font = [UIFont boldSystemFontOfSize:16];
    _lab2.text = @"必胜";
//    _lab2.text = self.model.name;
    //        _lab1.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab2];
    
    
    _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_lab2.left, _lab2.bottom+11, _lab2.width, 13)];
    _lab3.font = [UIFont boldSystemFontOfSize:12];
    _lab3.text = @"中餐 1.1km";
    _lab3.textColor = [UIColor colorWithHexString:@"#555555"];
    [self.scrollView addSubview:_lab3];
    
    _lab5 = [[UILabel alloc] initWithFrame:CGRectMake(40, _imgView.bottom+15, kScreen_Width-40-80, 30)];
    _lab5.font = [UIFont boldSystemFontOfSize:12];
    _lab5.text = @"拱墅区祥园路28号";
    //        _lab2.textAlignment = NSTextAlignmentRight;
    //        _lab5.textColor = [UIColor grayColor];
    [self.scrollView addSubview:_lab5];
    
    UIImageView *addrssImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, _lab5.center.y-8, 15, 18)];
    addrssImg.image = [UIImage imageNamed:@"address"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:addrssImg];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kScreen_Width-17-24, addrssImg.center.y-8.5, 17, 17);
    [btn2 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.scrollView addSubview:btn2];
    [btn2 addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width-35-24, btn2.center.y-15, .5, 25)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:line];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, addrssImg.bottom+20, kScreen_Width, self.scrollView.height-(addrssImg.bottom+20))];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
    [self.scrollView addSubview:view];
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, addrssImg.bottom+20);
    
    UIButton *orderBtn = [UIButton buttonWithframe:CGRectMake(0, self.scrollView.bottom, kScreen_Width, 45) text:@"再来一单" font:[UIFont boldSystemFontOfSize:20] textColor:@"#FFFFFF" backgroundColor:@"#FB7923" normal:nil selected:nil];
    [orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];

}

- (void)orderAction
{
    
}

- (void)callAction
{
//    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
//    UIWebView *callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3;
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[FoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    FoodModel *model = self.dataList[indexPath.row];
    model.type = 1;
    cell.model = model;
    
    return cell;
}


@end
