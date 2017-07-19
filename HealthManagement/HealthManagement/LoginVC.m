//
//  LoginVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LoginVC.h"
#import "registerVC.h"

@interface LoginVC ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UITextField *passwordTf;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    baseImg.image = [UIImage imageNamed:@"Login_1"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:baseImg];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(80, 312/2, kScreen_Width-160, 43)];
    tf.layer.cornerRadius = 3;
    tf.layer.borderColor = [UIColor colorWithHexString:@"#79A72B"].CGColor;
    tf.layer.borderWidth = .5;
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.layer.masksToBounds = YES;
    tf.placeholder = @"  手机号";
    tf.backgroundColor = [UIColor whiteColor];
    tf.font = [UIFont systemFontOfSize:18];
    [tf setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    [tf setValue:[UIColor colorWithHexString:@"#C8C7C8"] forKeyPath:@"_placeholderLabel.textColor"];
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:tf];
    self.tf = tf;
    
    UITextField *passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(tf.left, tf.bottom+16, tf.width, 43)];
    passwordTf.layer.cornerRadius = 3;
    passwordTf.layer.borderColor = [UIColor colorWithHexString:@"#79A72B"].CGColor;
    passwordTf.layer.borderWidth = .5;
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    passwordTf.layer.masksToBounds = YES;
    passwordTf.placeholder = @"  密码";
    passwordTf.backgroundColor = [UIColor whiteColor];
    passwordTf.font = [UIFont systemFontOfSize:18];
    [passwordTf setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    [passwordTf setValue:[UIColor colorWithHexString:@"#C8C7C8"] forKeyPath:@"_placeholderLabel.textColor"];
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:passwordTf];
    self.passwordTf = passwordTf;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(190/2, passwordTf.bottom+20, kScreen_Width-190, 35);
    loginBtn.layer.cornerRadius = 5;;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#79A72B"];
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
//    [loginBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 灰色条
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width-1)/2.0, loginBtn.bottom+24, 1, 15)];
    line.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:line];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(line.left-19-100, line.center.y-15/2, 100, 15);
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(line.right+19, forgetBtn.top, 100, 15);
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#AD323E"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"点我注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-65)/2.0, registerBtn.bottom+178/2, 65, 14)];
    otherLab.font = [UIFont systemFontOfSize:9];
    otherLab.text = @"其他登录方式";
    otherLab.textAlignment = NSTextAlignmentCenter;
    otherLab.textColor = [UIColor colorWithHexString:@"#919191"];
    [self.view addSubview:otherLab];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(otherLab.left-10-124*scaleWidth, otherLab.center.y-1/2.0, 124*scaleWidth, 1)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(otherLab.right+10, view1.top, 124*scaleWidth, 1)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view2];
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatBtn.frame = CGRectMake((kScreen_Width-92/2)/2, otherLab.bottom+30, 92/2.0, 92/2.0);
    [wechatBtn setImage:[UIImage imageNamed:@"Login_3"] forState:UIControlStateNormal];
    [self.view addSubview:wechatBtn];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {

    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 忘记密码
- (void)forgetAction
{
    registerVC *vc = [[registerVC alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

// 注册
- (void)registerAction
{
    registerVC *vc = [[registerVC alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
