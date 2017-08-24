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
#import "CAAnimation+HCAnimation.h"
#import "IntergrationModel.h"


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


@property (nonatomic,strong) PersonModel *personModel;
@property (nonatomic,strong) IntergrationModel *dietModel;
@property (nonatomic,strong) IntergrationModel *sleepModel;
@property (nonatomic,strong) IntergrationModel *sportModel;

@property (nonatomic,strong) UILabel *stateLab;
@property (nonatomic,strong) UILabel *jifenLab;



@property(nonatomic,strong) NSMutableArray *dataArray;


//@property (nonatomic,copy) NSString *scoreIds;




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
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    
    UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 264/2)];
    baseImg.image = [UIImage imageNamed:@"background_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:baseImg];
    
    
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
    
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(headImg.right+12, headImg.top+54/2, 150, 19)];
    userNameLab.font = [UIFont boldSystemFontOfSize:17];
//    userNameLab.text = @"zcz123";
    //        _lab1.textColor = [UIColor grayColor];
    [self.headView addSubview:userNameLab];
    self.userNameLab = userNameLab;
    
    
    UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake(userNameLab.left, userNameLab.bottom+20, 16*scaleWidth, 16*scaleWidth)];
//    sexImg.image = [UIImage imageNamed:imgArr[0]];
    [self.headView addSubview:sexImg];
    self.sexImg = sexImg;
    
    UILabel *sexLab = [[UILabel alloc] initWithFrame:CGRectMake(sexImg.right+3, sexImg.center.y-7, 20*scaleWidth, 15)];
    sexLab.font = [UIFont boldSystemFontOfSize:13*scaleWidth];
//    sexLab.text = @"男";
//    sexLab.backgroundColor = [UIColor redColor];
    sexLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:sexLab];
    self.sexLab = sexLab;
    
    UIImageView *yearImg = [[UIImageView alloc] initWithFrame:CGRectMake(sexLab.right+13*scaleWidth, sexImg.top, 16*scaleWidth, 16*scaleWidth)];
//    yearImg.image = [UIImage imageNamed:imgArr[1]];
    [self.headView addSubview:yearImg];
    self.yearImg = yearImg;
    
    UILabel *yearLab = [[UILabel alloc] initWithFrame:CGRectMake(yearImg.right+3, yearImg.center.y-7, 35*scaleWidth, 15)];
    yearLab.font = [UIFont boldSystemFontOfSize:13*scaleWidth];
//    yearLab.text = @"311岁";
//    yearLab.backgroundColor = [UIColor redColor];
    yearLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:yearLab];
    self.yearLab = yearLab;
    
    UIImageView *heightImg = [[UIImageView alloc] initWithFrame:CGRectMake(yearLab.right+13*scaleWidth, sexImg.top, 16*scaleWidth, 16*scaleWidth)];
//    heightImg.image = [UIImage imageNamed:imgArr[2]];
    [self.headView addSubview:heightImg];
    self.heightImg = heightImg;
    
    UILabel *heightLab = [[UILabel alloc] initWithFrame:CGRectMake(heightImg.right+3, heightImg.center.y-7, 45*scaleWidth, 15)];
    heightLab.font = [UIFont boldSystemFontOfSize:13*scaleWidth];
//    heightLab.text = @"176cm";
//    heightLab.backgroundColor = [UIColor redColor];
    heightLab.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.headView addSubview:heightLab];
    self.heightLab = heightLab;
    
    UIImageView *weightImg = [[UIImageView alloc] initWithFrame:CGRectMake(heightLab.right+13*scaleWidth, sexImg.top, 16*scaleWidth, 16*scaleWidth)];
//    weightImg.image = [UIImage imageNamed:imgArr[3]];
    [self.headView addSubview:weightImg];
    self.weightImg = weightImg;
    
    UILabel *weightLab = [[UILabel alloc] initWithFrame:CGRectMake(weightImg.right+3, heightImg.center.y-7, 40*scaleWidth, 15)];
    weightLab.font = [UIFont boldSystemFontOfSize:13*scaleWidth];
//    weightLab.text = @"722kg";
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
//    treeImg.image = [UIImage imageNamed:@"tree_1"];
    treeImg.userInteractionEnabled = YES;
//    treeImg.hidden = YES;
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
//    _sleepBtn.frame = CGRectMake(kScreen_Width/2-95, 248/2, 100, 25);
//    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    _sleepBtn.tag = 0;
    _sleepBtn.hidden = YES;

    [_sleepBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sleepBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sleepBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_sleepBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_sleepBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_sleepBtn];
    [_sleepBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [CAAnimation showMoveAnimationInView:_sleepBtn Position:CGPointMake(_sleepBtn.layer.position.x, _sleepBtn.layer.position.y+5) Repeat:0 Autoreverses:YES Duration:1.5];
    
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
//    _dietBtn.frame = CGRectMake(kScreen_Width/2-60, 64/2, 100, 25);
    //    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    _dietBtn.tag = 1;
    _dietBtn.hidden = YES;
    [_dietBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _dietBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dietBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_dietBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_dietBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_dietBtn];
    [_dietBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [CAAnimation showMoveAnimationInView:_dietBtn Position:CGPointMake(_dietBtn.layer.position.x, _dietBtn.layer.position.y+5) Repeat:0 Autoreverses:YES Duration:0.8];

    
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
//    _sportBtn.frame = CGRectMake(kScreen_Width/2+20, 176/2, 100, 25);
    _sportBtn.tag = 2;
    _sportBtn.hidden = YES;

    //    [_sleepBtn setTitle:@" +1 饮食" forState:UIControlStateNormal];
    [_sportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sportBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_sportBtn setImage:[UIImage imageNamed:@"leaf"] forState:UIControlStateNormal];
    [_sportBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [treeImg addSubview:_sportBtn];
    [_sportBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [CAAnimation showMoveAnimationInView:_sportBtn Position:CGPointMake(_sportBtn.layer.position.x, _sportBtn.layer.position.y+5) Repeat:0 Autoreverses:YES Duration:1.0];

    // 创建导航栏视图
    [self createNav];
    
    [self initSubViews];
    

    
}


- (void)addAction:(UIButton *)btn
{
    
    if (btn.tag == 0) {
        
        [self clickScore:self.sleepModel.ListId button:btn];
        
    }
    if (btn.tag == 1) {
        [self clickScore:self.dietModel.ListId button:btn];

    }
    if (btn.tag == 2) {
        [self clickScore:self.sportModel.ListId button:btn];

    }

}

- (void)refreshAction:(UIButton *)btn enabled:(BOOL)enabled
{
    btn.userInteractionEnabled = enabled;
    [CAAnimation clearAnimationInView:btn];
    [CAAnimation showMoveAnimationInView:btn Position:CGPointMake(btn.layer.position.x, btn.layer.position.y+5) Repeat:0 Autoreverses:YES Duration:1.0];
}

- (void)initSubViews
{

     UIImageView *stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, self.treeImg.bottom+14, 20, 20)];
     stateImg.image = [UIImage imageNamed:@"LV"];
     [self.headView addSubview:stateImg];
    
     
     UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(stateImg.right+10, stateImg.center.y-15, 120, 30)];
     stateLab.font = [UIFont boldSystemFontOfSize:18];
     //    _lab1.backgroundColor = [UIColor cyanColor];
//     stateLab.text = @"生龙活虎活虎";
     stateLab.textColor = [UIColor colorWithHexString:@"#555555"];
     stateLab.textAlignment = NSTextAlignmentLeft;
     [self.headView addSubview:stateLab];
    self.stateLab = stateLab;
     
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(stateLab.right+10*scaleWidth, stateLab.top+8, 1, stateLab.height-16)];
     view.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
     [self.headView addSubview:view];
    
    
    UILabel *jifenLab = [[UILabel alloc] initWithFrame:CGRectMake(view.right+12*scaleWidth, stateImg.center.y-15, kScreen_Width-view.right-12-30, 31)];
     jifenLab.font = [UIFont boldSystemFontOfSize:14];
     jifenLab.textAlignment = NSTextAlignmentLeft;
     //    _lab1.backgroundColor = [UIColor cyanColor];
     jifenLab.textColor = [UIColor colorWithHexString:@"#555555"];
     [self.headView addSubview:jifenLab];
    self.jifenLab = jifenLab;
    
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
    
    [self getUserScoreInfo];
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    
}

- (void)headerRefresh
{
    [self getUserScoreInfo];

}

// 用户积分信息
- (void)getUserScoreInfo
{
//    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:UserScoreInfo dic:paramDic Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            NSDictionary *dic = responseObject[@"Model1"];
            
            if (dic) {
                PersonModel *personModel = [PersonModel yy_modelWithJSON:dic];
                self.personModel = personModel;
                
                if (personModel.Current_Lv.integerValue == 1) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_1"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-60, 64/2, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-95, 248/2, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+20, 176/2, 100, 25);
                    
                    
                }
                
                if (personModel.Current_Lv.integerValue == 2) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_2"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-272/2*scaleWidth, 226/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-88/2*scaleWidth, 94/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+130/2*scaleWidth, 482/2*scaleWidth, 100, 25);
                    
                    
                }
                if (personModel.Current_Lv.integerValue == 3) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_3"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-272/2*scaleWidth, 226/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-88/2*scaleWidth, 94/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+130/2*scaleWidth, 482/2*scaleWidth, 100, 25);
                    
                    
                    
                }
                if (personModel.Current_Lv.integerValue == 4) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_4"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-320/2*scaleWidth, 60/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-240/2*scaleWidth, 444/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+156/2*scaleWidth, 514/2*scaleWidth, 100, 25);
                    
                    
                    
                }
                if (personModel.Current_Lv.integerValue == 5) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_5"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-316/2*scaleWidth, 430/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-230/2*scaleWidth, 526/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+156/2*scaleWidth, 514/2*scaleWidth, 100, 25);
                    
                }
                if (personModel.Current_Lv.integerValue == 6) {
                    self.treeImg.image = [UIImage imageNamed:@"tree_6"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-316/2*scaleWidth, 430/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-230/2*scaleWidth, 526/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+156/2*scaleWidth, 514/2*scaleWidth, 100, 25);
                    
                }
                if (personModel.Current_Lv.integerValue == 7) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_7"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-316/2*scaleWidth, 430/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-230/2*scaleWidth, 526/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+156/2*scaleWidth, 514/2*scaleWidth, 100, 25);
                    
                }
                if (personModel.Current_Lv.integerValue == 8) {
                    
                    self.treeImg.image = [UIImage imageNamed:@"tree_8"];
                    
                    _dietBtn.frame = CGRectMake(kScreen_Width/2-316/2*scaleWidth, 430/2*scaleWidth, 100, 25);
                    
                    _sleepBtn.frame = CGRectMake(kScreen_Width/2-230/2*scaleWidth, 526/2*scaleWidth, 100, 25);
                    _sportBtn.frame = CGRectMake(kScreen_Width/2+156/2*scaleWidth, 514/2*scaleWidth, 100, 25);
                    
                }
                
                self.stateLab.text = personModel.Current_Name;
                
                NSString *str1 = personModel.Current_Score;
                NSString *str2 = personModel.Next_Score;
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"积分%@  升级还需%@积分",str1,str2]];
                NSRange range1 = {2,[str1 length]};
                NSRange range2 = {attStr.length-[str2 length]-2,[str2 length]};
                [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#5BA439"] range:range1];
                [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#C5021A"] range:range2];
                self.jifenLab.attributedText = attStr;

            }

            [self getClickScore];

        }
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];

    }];
}

// 获得未获取分数列表
- (void)getClickScore
{
//    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [AFNetworking_RequestData requestMethodPOSTUrl:GetClickScore dic:paramDic Succed:^(id responseObject) {
        
//        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            IntergrationModel *dietModel = [IntergrationModel yy_modelWithJSON:[responseObject objectForKey:@"Model1"]];
            self.dietModel = dietModel;
            
            IntergrationModel *sleepModel = [IntergrationModel yy_modelWithJSON:[responseObject objectForKey:@"Model2"]];
            self.sleepModel = sleepModel;

            IntergrationModel *sportModel = [IntergrationModel yy_modelWithJSON:[responseObject objectForKey:@"Model3"]];
            self.sportModel = sportModel;

            if (dietModel) {
                
                _dietBtn.hidden = NO;
                [self refreshAction:_dietBtn enabled:YES];

            }
            else {
                _dietBtn.hidden = YES;

            }
            
            if (sleepModel) {
                
                _sleepBtn.hidden = NO;
                [self refreshAction:_sleepBtn enabled:YES];

            }
            else {
                _sleepBtn.hidden = YES;
                
            }
            
            if (sportModel) {
                
                _sportBtn.hidden = NO;

                [self refreshAction:_sportBtn enabled:YES];
            }
            else {
                _sportBtn.hidden = YES;
                
            }
            
            [self getScoreList];

        }
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}

// 积分点击
- (void)clickScore:(NSString *)scoreIds button:(UIButton *)btn
{
//        [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:scoreIds forKey:@"ScoreIds"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:ClickScore dic:paramDic Succed:^(id responseObject) {
        
        //        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        if (200 == [code integerValue]) {
            
            
            btn.userInteractionEnabled = NO;
            
            [CAAnimation clearAnimationInView:btn];
            
            [CAAnimation showScaleAnimationInView:btn Repeat:1 Autoreverses:NO FromValue:(float)1.0 ToValue:(float)0.5 Duration:1.0];
            [CAAnimation showOpacityAnimationInView:btn Alpha:0 Repeat:1 Autoreverses:NO Duration:1.0];
            [CAAnimation showMoveAnimationInView:btn Position:CGPointMake(self.treeImg.width/2, self.treeImg.height/2) Repeat:1 Autoreverses:NO Duration:1.0];
            
//            [self getScoreList];
            [self getUserScoreInfo];

        }
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",error);
        //        [SVProgressHUD dismiss];
        
    }];
}


// 获得积分记录
- (void)getScoreList
{
    //    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:@1 forKey:@"PageNo"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetScoreList dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            NSArray *arr = responseObject[@"ListData"];
            
            NSMutableArray *arrM = [NSMutableArray array];
            if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                
                for (NSDictionary *dic in arr) {
                    
                    IntergrationModel *model = [IntergrationModel yy_modelWithJSON:dic];
                    [arrM addObject:model];
                }
                
                self.dataArray = arrM;
                [self.tableView reloadData];
            }
            
        }
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}


-(void)createNav{
    self.navView=[[NavgationBarView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
//    self.navView.title=self.;
//    self.navView.backTitleImage=@"error_head";
    self.navView.rightImageView=@"setting1";
    self.navView.delegate=self;
    [self.view addSubview:self.navView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:person.HeadImage] placeholderImage:[UIImage imageNamed:@""]];
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
    if (self.dataArray.count > 3) {
        return 3;

    }
    else {
        return self.dataArray.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegrationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[IntegrationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsety = scrollView.contentOffset.y;
//    NSLog(@"%ld",contentOffsety);
    
    if (contentOffsety<=170) {
        self.navView.headBgView.alpha = scrollView.contentOffset.y/170;
        self.navView.rightImageView=@"setting1";

        
    }else{
        self.navView.headBgView.alpha=1;
        self.navView.rightImageView=@"setting";

        
    }}


@end
