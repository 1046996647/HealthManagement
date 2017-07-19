//
//  registerVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "registerVC.h"
#import "RegisterSuccessVC.h"

@interface registerVC ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UITextField *validTf;
@property(nonatomic,strong) UITextField *passwordTf;
@property(nonatomic,strong) UITextField *confirmPasswordTf;


@end

@implementation registerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_1"];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 25, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.placeholder = @"手机号";
    tf.font = [UIFont systemFontOfSize:14];
    [tf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [tf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    tf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:tf];
    self.tf = tf;

    
    // 获取验证码按钮
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getBtn.frame = CGRectMake((kScreen_Width-230/2), tf.bottom, 230/2, tf.height);
    //    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [getBtn setTitleColor:[UIColor colorWithHexString:@"#A4A4A4"] forState:UIControlStateNormal];
    [getBtn setTitle:@"重新获取(32)" forState:UIControlStateNormal];
    getBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:getBtn];
    //    [getBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_2"];
    
    UITextField *validTf = [[UITextField alloc] initWithFrame:CGRectMake(0, tf.bottom, kScreen_Width-getBtn.width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    validTf.placeholder = @"验证码";
    validTf.font = [UIFont systemFontOfSize:14];
    [validTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [validTf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    validTf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    validTf.leftViewMode = UITextFieldViewModeAlways;
    validTf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:validTf];
    self.validTf = validTf;
    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_3"];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 34)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 54/2, 34/2);
    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"password_6"] forState:UIControlStateNormal];
    [rightView addSubview:rightBtn];
    
    UITextField *passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(0, validTf.bottom, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    passwordTf.placeholder = @"密码";
    passwordTf.font = [UIFont systemFontOfSize:14];
    [passwordTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [passwordTf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    passwordTf.leftViewMode = UITextFieldViewModeAlways;
    passwordTf.rightViewMode = UITextFieldViewModeAlways;
    passwordTf.leftView = leftView;
    passwordTf.rightView = rightView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:passwordTf];
    self.passwordTf = passwordTf;
    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@""];
    
    
    UITextField *confirmPasswordTf = [[UITextField alloc] initWithFrame:CGRectMake(0, passwordTf.bottom, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    confirmPasswordTf.placeholder = @"确认密码";
    confirmPasswordTf.font = [UIFont systemFontOfSize:14];
    [confirmPasswordTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [confirmPasswordTf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    confirmPasswordTf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    confirmPasswordTf.leftViewMode = UITextFieldViewModeAlways;
    confirmPasswordTf.rightViewMode = UITextFieldViewModeAlways;
    confirmPasswordTf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:confirmPasswordTf];
    self.confirmPasswordTf = confirmPasswordTf;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(7, tf.bottom, kScreen_Width-14, .5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(getBtn.left, getBtn.top+2, .5, tf.height-4)];
    view.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(7, validTf.bottom, kScreen_Width-14, .5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(50, passwordTf.bottom, kScreen_Width-50-7, .5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view];
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(30/2, confirmPasswordTf.bottom+69, kScreen_Width-30, 98/2);
    registerBtn.layer.cornerRadius = 5;;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#BD2F3B"];
    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.title isEqualToString:@"注册"]) {
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];

    }
    else {
        [registerBtn setTitle:@"确定" forState:UIControlStateNormal];

    }

}

- (void)registerAction
{
    RegisterSuccessVC *vc = [[RegisterSuccessVC alloc] init];
    vc.title = @"注册成功";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
