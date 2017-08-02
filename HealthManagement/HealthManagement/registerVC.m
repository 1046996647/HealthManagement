//
//  registerVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "registerVC.h"
#import "RegisterSuccessVC.h"
#import "RegexTool.h"
#import "CountDownServer.h"
#import "AppDelegate.h"
#import "LoginVC.h"


#define kCountDownForVerifyCode @"CountDownForVerifyCode"


@interface registerVC ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UITextField *validTf;
@property(nonatomic,strong) UITextField *passwordTf;
@property(nonatomic,strong) UITextField *confirmPasswordTf;
@property(nonatomic,strong) UIButton *getBtn;
@property(nonatomic,strong) UIButton *registerBtn;


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
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:tf];
    self.tf = tf;
    [tf addTarget:self action:@selector(editChangeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.keyboardType = UIKeyboardTypeNumberPad;



    
    // 获取验证码按钮
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getBtn.frame = CGRectMake((kScreen_Width-230/2), tf.bottom, 230/2, tf.height);
    getBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [getBtn setTitleColor:[UIColor colorWithHexString:@"#A4A4A4"] forState:UIControlStateNormal];
//    [getBtn setTitle:@"重新获取(32)" forState:UIControlStateNormal];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:getBtn];
    [getBtn addTarget:self action:@selector(getAction:) forControlEvents:UIControlEventTouchUpInside];
    self.getBtn = getBtn;
    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_2"];
    
    UITextField *validTf = [[UITextField alloc] initWithFrame:CGRectMake(0, tf.bottom, kScreen_Width-getBtn.width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    validTf.placeholder = @"验证码";
    validTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    validTf.font = [UIFont systemFontOfSize:14];
    [validTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [validTf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    validTf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    validTf.leftViewMode = UITextFieldViewModeAlways;
    validTf.leftView = leftView;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:validTf];
    self.validTf = validTf;
    [validTf addTarget:self action:@selector(editChangeAction:) forControlEvents:UIControlEventEditingChanged];
    validTf.keyboardType = UIKeyboardTypeNumberPad;


    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_3"];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 34)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 54/2, 34/2);
    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"password_6"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"password_5"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(isLookAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UITextField *passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(0, validTf.bottom, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    passwordTf.placeholder = @"密码";
    passwordTf.secureTextEntry = YES;
    passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTf.font = [UIFont systemFontOfSize:14];
    [passwordTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [passwordTf setValue:[UIColor colorWithHexString:@"#A4A4A4"] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTf.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    passwordTf.leftViewMode = UITextFieldViewModeAlways;
    passwordTf.rightViewMode = UITextFieldViewModeAlways;
    passwordTf.leftView = leftView;
    passwordTf.rightView = rightView;
    passwordTf.tag = 100;
    //    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:passwordTf];
    self.passwordTf = passwordTf;
    [passwordTf addTarget:self action:@selector(editChangeAction:) forControlEvents:UIControlEventEditingChanged];

    
    leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@""];
    
    
    UITextField *confirmPasswordTf = [[UITextField alloc] initWithFrame:CGRectMake(0, passwordTf.bottom, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    confirmPasswordTf.placeholder = @"确认密码";
//    confirmPasswordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPasswordTf.secureTextEntry = YES;
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
    [confirmPasswordTf addTarget:self action:@selector(editChangeAction:) forControlEvents:UIControlEventEditingChanged];


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
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//    registerBtn.userInteractionEnabled = NO;
    registerBtn.userInteractionEnabled = YES;// 测试
    self.registerBtn = registerBtn;
    
    if ([self.title isEqualToString:@"注册"]) {
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];

    }
    else {
        [registerBtn setTitle:@"确定" forState:UIControlStateNormal];

    }
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];

}


-(void)isLookAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.passwordTf.secureTextEntry = NO;
        self.confirmPasswordTf.secureTextEntry = NO;

    }
    else {
        self.passwordTf.secureTextEntry = YES;
        self.confirmPasswordTf.secureTextEntry = YES;

    }
}


-(void)getAction:(UIButton *)btn
{
    
    [self.view endEditing:YES];
    
    if (![RegexTool checkPhone:self.tf.text]) {
        [self.view makeToast:@"无效的手机号"];
        return;
    }
    
    // 开始计时
    [CountDownServer startCountDown:10 identifier:kCountDownForVerifyCode];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.tf.text forKey:@"Phone"];
    
//    NSString *sendStr = nil;
    
//    if ([self.title isEqualToString:@"注册"]) {
//        
//        sendStr = SendMail;
//        
//    } else if ([self.title isEqualToString:@"忘记密码"])
//    {
//        sendStr = ResetUserPassword;
//        
//    }

    [AFNetworking_RequestData requestMethodPOSTUrl:SendMail dic:paramDic Succed:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        
        if (200 == [code integerValue]) {
            NSString *msg = [responseObject objectForKey:@"Message"];
            
            [self.view makeToast:msg];
            
            btn.userInteractionEnabled = YES;
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
        if ([CountDownServer isCountDowning:kCountDownForVerifyCode]) {
            [CountDownServer cancelCountDowning:kCountDownForVerifyCode];
        }
        
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        btn.backgroundColor=[UIColor colorWithHexString:@"#f99740"];
        btn.userInteractionEnabled = YES;
        
    }];
}

- (void)registerAction
{


    if (![self.passwordTf.text isEqualToString:self.confirmPasswordTf.text]) {
        [self.view makeToast:@"密码不一致"];
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.tf.text forKey:@"Phone"];
    [paramDic  setValue:self.validTf.text forKey:@"Code"];
    [paramDic  setValue:self.passwordTf.text forKey:@"PassWord"];
    
    NSString *registStr = nil;
    
    if ([self.title isEqualToString:@"注册"]) {
        
        registStr = MailRegister;
        
    } else if ([self.title isEqualToString:@"忘记密码"] ||[self.title isEqualToString:@"修改密码"])
    {
        registStr = ResetUserPassword;
        
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:registStr dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];

        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            [InfoCache saveValue:self.tf.text forKey:@"phone"];
            [InfoCache saveValue:self.passwordTf.text forKey:@"password"];
            
            if ([self.title isEqualToString:@"注册"]) {
                
                NSArray *arr = [responseObject objectForKey:@"ListData"];
                
                PersonModel *model = [PersonModel yy_modelWithJSON:[arr firstObject]];
                [InfoCache archiveObject:model toFile:@"Person"];
                
                RegisterSuccessVC *vc = [[RegisterSuccessVC alloc] init];
                vc.title = @"注册成功";
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([self.title isEqualToString:@"忘记密码"])
            {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:nil];

            } else if ([self.title isEqualToString:@"修改密码"])
            {
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                LoginVC *tabVC = [[LoginVC alloc] init];
                delegate.window.rootViewController = tabVC;
            }

        }
        else {
            NSString *msg = [responseObject objectForKey:@"Message"];

            [self.view makeToast:msg];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//接收到通知实现的方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCode]) {
        NSNumber *n = [noti.userInfo objectForKey:@"SecondsCountDown"];
        
        [self performSelectorOnMainThread:@selector(updateVerifyCodeCountDown:) withObject:n waitUntilDone:YES];
    }
}

- (void)updateVerifyCodeCountDown:(NSNumber *)num{
    if ([num integerValue] == 0){
        [self.getBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getBtn.userInteractionEnabled = YES;
//        self.getBtn.backgroundColor=[UIColor colorWithHexString:@"#f99740"];
    }else{
        [self.getBtn setTitle:[NSString stringWithFormat:@"重新获取(%@)",num] forState:UIControlStateNormal];
        self.getBtn.userInteractionEnabled = NO;
//        self.getBtn.backgroundColor=[UIColor colorWithHexString:@"cccccc"];
        
    }
}

- (void)editChangeAction:(UITextField *)textField
{
    
    if (self.tf.text.length > 0 && self.validTf.text.length > 0 && self.passwordTf.text.length > 0 && self.confirmPasswordTf.text.length > 0) {
        self.registerBtn.userInteractionEnabled = YES;
        self.registerBtn.backgroundColor=[UIColor colorWithHexString:@"#BD2F3B"];
    } else {
        self.registerBtn.userInteractionEnabled = NO;
        self.registerBtn.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
    }
    
    if (textField.tag == 100) {
        self.confirmPasswordTf.text = @"";
    }
    
}

@end
