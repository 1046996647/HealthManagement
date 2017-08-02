//
//  PersonalCenterVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "SettingVC.h"
#import "BodyProTestVC.h"
#import "PreferenceVC.h"
#import "BodyDataVC.h"
#import "IntegrationCell.h"
#import "NavgationBarView.h"
#import "IntergrationRecordVC.h"

@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource,NavHeadTitleViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NavgationBarView *navView;

@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UILabel *userNameLab;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIImageView *sexImg;
@property(nonatomic,strong) UILabel *sexLab;
@property(nonatomic,strong) UIImageView *yearImg;
@property(nonatomic,strong) UILabel *yearLab;
@property(nonatomic,strong) UIImageView *heightImg;
@property(nonatomic,strong) UILabel *heightLab;
@property(nonatomic,strong) UIImageView *weightImg;
@property(nonatomic,strong) UILabel *weightLab;



@property (nonatomic,strong) UIButton *resBtn;
@property (nonatomic,strong) UIImageView *treeImg;

@property (nonatomic,strong) UIButton *sleepBtn;
@property (nonatomic,strong) UIButton *dietBtn;
@property (nonatomic,strong) UIButton *sportBtn;



@end

@implementation PersonalCenterVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-25)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    // 让内容置顶显示
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    
    // 创建导航栏视图
    [self createNav];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    
    UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 264/2)];
    baseImg.image = [UIImage imageNamed:@"background_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:baseImg];
    
    // 右上角按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kScreen_Width-18-12, 70/2.0, 18, 18);
    [btn2 setImage:[UIImage imageNamed:@"setting1"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:btn2];
    
//    // 体质
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-10-33, 220/2, 33, 14)];
    //        imgView.backgroundColor = [UIColor redColor];
//    imgView.tag = 100;
//    imgView.image = [UIImage imageNamed:@"气虚质"];
    [self.headView  addSubview:imgView];
    self.imgView = imgView;
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 162/2, 156/2, 156/2)];
    headImg.layer.cornerRadius = headImg.height/2.0;
    headImg.layer.masksToBounds = YES;
    headImg.image = [UIImage imageNamed:@"head"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:headImg];
    self.headImg = headImg;
    
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(headImg.right+12, headImg.top+54/2, 60, 18)];
    userNameLab.font = [UIFont boldSystemFontOfSize:17];
//    userNameLab.text = @"zcz123";
    //        _lab1.textColor = [UIColor grayColor];
    [self.headView addSubview:userNameLab];
    self.userNameLab = userNameLab;
    
//    UIImageView *bodyImg = [[UIImageView alloc] initWithFrame:CGRectMake(userNameLab.right, userNameLab.center.y-6, 33, 12)];
////    bodyImg.image = [UIImage imageNamed:@"temperament_3"];
//    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.headView addSubview:bodyImg];
//    self.bodyImg = bodyImg;
    
    
//    NSArray *imgArr = @[@"male",@"age_male",@"height_male",@"weight_male"];
    
    UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake(userNameLab.left, userNameLab.bottom+20, 16, 16)];
//    sexImg.image = [UIImage imageNamed:imgArr[0]];
    [self.headView addSubview:sexImg];
    self.sexImg = sexImg;
    
    UILabel *sexLab = [[UILabel alloc] initWithFrame:CGRectMake(sexImg.right+3, sexImg.center.y-7, 20, 15)];
    sexLab.font = [UIFont boldSystemFontOfSize:13];
//    sexLab.text = @"男";
//    sexLab.backgroundColor = [UIColor redColor];
    sexLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:sexLab];
    self.sexLab = sexLab;
    
    UIImageView *yearImg = [[UIImageView alloc] initWithFrame:CGRectMake(sexLab.right+15*scaleWidth, sexImg.top, 16, 16)];
//    yearImg.image = [UIImage imageNamed:imgArr[1]];
    [self.headView addSubview:yearImg];
    self.yearImg = yearImg;
    
    UILabel *yearLab = [[UILabel alloc] initWithFrame:CGRectMake(yearImg.right+3, yearImg.center.y-7, 40, 15)];
    yearLab.font = [UIFont boldSystemFontOfSize:13];
//    yearLab.text = @"31岁";
//    yearLab.backgroundColor = [UIColor redColor];
    yearLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:yearLab];
    self.yearLab = yearLab;
    
    UIImageView *heightImg = [[UIImageView alloc] initWithFrame:CGRectMake(yearLab.right+15*scaleWidth, sexImg.top, 16, 16)];
//    heightImg.image = [UIImage imageNamed:imgArr[2]];
    [self.headView addSubview:heightImg];
    self.heightImg = heightImg;
    
    UILabel *heightLab = [[UILabel alloc] initWithFrame:CGRectMake(heightImg.right+3, heightImg.center.y-7, 45, 15)];
    heightLab.font = [UIFont boldSystemFontOfSize:13];
//    heightLab.text = @"176cm";
//    heightLab.backgroundColor = [UIColor redColor];
    heightLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:heightLab];
    self.heightLab = heightLab;
    
    UIImageView *weightImg = [[UIImageView alloc] initWithFrame:CGRectMake(heightLab.right+15*scaleWidth, sexImg.top, 16, 16)];
//    weightImg.image = [UIImage imageNamed:imgArr[3]];
    [self.headView addSubview:weightImg];
    self.weightImg = weightImg;
    
    UILabel *weightLab = [[UILabel alloc] initWithFrame:CGRectMake(weightImg.right+3, heightImg.center.y-7, 40, 15)];
    weightLab.font = [UIFont boldSystemFontOfSize:13];
//    weightLab.text = @"72kg";
//    weightLab.backgroundColor = [UIColor redColor];
    weightLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:weightLab];
    self.weightLab = weightLab;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, headImg.bottom+10, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.headView addSubview:view];
    
    //底部按钮
    NSArray *imgArr1 = @[@"mine_1",@"mine_2",@"mine_3"];
    NSArray *titleArr = @[@"专业版测试",@"个人偏好",@"身体数据"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *resBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resBtn.tag = i;
        resBtn.frame = CGRectMake(i*kScreen_Width/3.0, view.bottom, kScreen_Width/3.0, 170/2);
        [self.headView addSubview:resBtn];
        [resBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.resBtn = resBtn;
        
        UIImageView *resImgView = [[UIImageView alloc] initWithFrame:CGRectMake((resBtn.width-35)/2.0, 8, 35, 35)];
        //        imgView.backgroundColor = [UIColor redColor];
        resImgView.image = [UIImage imageNamed:imgArr1[i]];
        [resBtn  addSubview:resImgView];
        
        UILabel *resLab = [[UILabel alloc] initWithFrame:CGRectMake(0, resImgView.bottom+9, resBtn.width, 15)];
        resLab.font = [UIFont boldSystemFontOfSize:14];
        resLab.text = titleArr[i];
        resLab.textColor = [UIColor colorWithHexString:@"#555555"];
        resLab.textAlignment = NSTextAlignmentCenter;
        [resBtn addSubview:resLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(resBtn.width, 2, 1, resBtn.height-4)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
        [resBtn addSubview:line];
        
        if (i == titleArr.count-1) {
            resImgView.frame = CGRectMake((resBtn.width-45)/2.0, 8, 45, 35);
        }
        
        
    }
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, self.resBtn.bottom, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.headView addSubview:view];
    
    UIImageView *treeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.bottom, kScreen_Width, 660/2*scaleWidth)];
    treeImg.image = [UIImage imageNamed:@"tree_1"];
    treeImg.userInteractionEnabled = YES;
//    treeImg.backgroundColor = [UIColor redColor];
    [self.headView addSubview:treeImg];
    self.treeImg = treeImg;
    
    NSString *str1 = @"+1";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ 睡眠",str1]];
    NSRange range1 = {1,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:19]
     
                   range:range1];
    _sleepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sleepBtn.frame = CGRectMake(kScreen_Width/2-95, 248/2, 100, 25);
//    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    [_sleepBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sleepBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sleepBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_sleepBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_sleepBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_sleepBtn];
//    [_sleepBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    str1 = @"+1";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ 饮食",str1]];
//    NSRange range1 = {1,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:19]
     
                   range:range1];
    _dietBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dietBtn.frame = CGRectMake(kScreen_Width/2-60, 64/2, 100, 25);
    //    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    [_dietBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _dietBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dietBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_dietBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_dietBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_dietBtn];
    
    str1 = @"+2";
    //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
    //    self.money = str1;
    attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ 运动",str1]];
    //    NSRange range1 = {1,[str1 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range1];
    [attStr addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:19]
     
                   range:range1];
    _sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sportBtn.frame = CGRectMake(kScreen_Width/2+20, 176/2, 100, 25);
    //    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    [_sportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sportBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_sportBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_sportBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_sportBtn];
    
    
    [self initSubViews];
    
    
}

- (void)initSubViews
{

     UIImageView *stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, self.treeImg.bottom+14, 20, 20)];
     stateImg.image = [UIImage imageNamed:@"LV"];
     [self.headView addSubview:stateImg];
    
     
     UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(stateImg.right+10, stateImg.center.y-15, 90, 30)];
     stateLab.font = [UIFont boldSystemFontOfSize:18];
     //    _lab1.backgroundColor = [UIColor cyanColor];
     stateLab.text = @"生龙活虎";
     stateLab.textColor = [UIColor colorWithHexString:@"#555555"];
     stateLab.textAlignment = NSTextAlignmentLeft;
     [self.headView addSubview:stateLab];
     
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(stateLab.right, stateLab.top+8, 1, stateLab.height-16)];
     view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
     [self.headView addSubview:view];
     
    NSString *str1 = @"234";
    NSString *str2 = @"4";
     //    str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
     //    self.money = str1;
     NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"积分%@  升级还需%@积分",str1,str2]];
    NSRange range1 = {2,[str1 length]};
    NSRange range2 = {attStr.length-3,[str2 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#5BA439"] range:range1];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range2];
    
     UILabel *jifenLab = [[UILabel alloc] initWithFrame:CGRectMake(view.right+12, stateImg.center.y-15, kScreen_Width-view.right-12-30, 31)];
     jifenLab.font = [UIFont boldSystemFontOfSize:14];
     jifenLab.textAlignment = NSTextAlignmentLeft;
     //    _lab1.backgroundColor = [UIColor cyanColor];
     jifenLab.textColor = [UIColor colorWithHexString:@"#555555"];
     jifenLab.attributedText = attStr;
     [self.headView addSubview:jifenLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreen_Width-50-10, stateImg.center.y-25, 50, 50);
    [btn setImage:[UIImage imageNamed:@"assistor"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn addTarget:self action:@selector(integrationAction) forControlEvents:UIControlEventTouchUpInside];
    //    btn.backgroundColor = [UIColor redColor];
    [self.headView addSubview:btn];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, stateImg.bottom+14, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
    [self.headView addSubview:view];
    
    self.headView.height = view.bottom;
    
    self.tableView.tableHeaderView = self.headView;

}

-(void)createNav{
    self.navView=[[NavgationBarView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
//    self.navView.title=self.;
//    self.navView.backTitleImage=@"error_head";
    self.navView.rightImageView=@"setting";
    self.navView.delegate=self;
    [self.view addSubview:self.navView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:person.HeadImage] placeholderImage:[UIImage imageNamed:@"error_head"]];
    self.userNameLab.text = person.name;
    self.imgView.image = [UIImage imageNamed:person.constitution];
    self.navView.title = person.name;
    self.navView.backTitleImage = person.HeadImage;

    
    if (person.sex.integerValue == 0) {
        person.sex = @"女";
        self.sexImg.image = [UIImage imageNamed:@"female"];
        self.yearImg.image = [UIImage imageNamed:@"age_female"];
        self.heightImg.image = [UIImage imageNamed:@"height_female"];
        self.weightImg.image = [UIImage imageNamed:@"weight_female"];
    }
    else {
        
        person.sex = @"男";
        self.sexImg.image = [UIImage imageNamed:@"male"];
        self.yearImg.image = [UIImage imageNamed:@"age_male"];
        self.heightImg.image = [UIImage imageNamed:@"height_male"];
        self.weightImg.image = [UIImage imageNamed:@"weight_male"];

        
    }
    self.sexLab.text = person.sex;
    
    if (!person.height) {
        person.height = @"";
    }
    if (!person.weight) {
        person.weight = @"";
    }
    
    self.yearLab.text = [NSString stringWithFormat:@"%@岁",person.age];
    self.heightLab.text = [NSString stringWithFormat:@"%@cm",person.height];
    self.weightLab.text = [NSString stringWithFormat:@"%@kg",person.weight];
    


}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)integrationAction
{
    IntergrationRecordVC *vc = [[IntergrationRecordVC alloc] init];
    vc.title = @"积分记录";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setAction
{
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];

    SettingVC *vc = [[SettingVC alloc] init];
    vc.title = @"设置";
    vc.person = person;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        BodyProTestVC *vc = [[BodyProTestVC alloc] init];
        vc.title = @"体质测试";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        PreferenceVC *vc = [[PreferenceVC alloc] init];
        vc.title = @"个人偏好";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 2) {
        PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];

        BodyDataVC *vc = [[BodyDataVC alloc] init];
        vc.title = @"身体数据";
        vc.person = person;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - NavHeadTitleViewDelegate
-(void)navHeadToRight{
    
    [self setAction];
}



#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegrationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[IntegrationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsety = scrollView.contentOffset.y;
//    NSLog(@"%ld",contentOffsety);
    
    if (contentOffsety<=170) {
        self.navView.alpha=scrollView.contentOffset.y/170;

        
    }else{
        self.navView.alpha=1;

        
    }}


@end
