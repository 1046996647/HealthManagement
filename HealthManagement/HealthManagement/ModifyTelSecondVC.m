//
//  ModifyTelSecondVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ModifyTelSecondVC.h"
#import "CountDownServer.h"
#import "RegexTool.h"
#import "UIViewController+UIViewControllerExt.h"

#define kCountDownForVerifyCode @"CountDownForVerifyCodeSec"



@interface ModifyTelSecondVC ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UITextField *validTf;
@property(nonatomic,strong) UIButton *getBtn;
@property(nonatomic,strong) UIButton *registerBtn;


@end

@implementation ModifyTelSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 19)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"password_1"];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 25, kScreen_Width, 116/2)];
    //    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.placeholder = @"请输入新手机号";
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
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(7, tf.bottom, kScreen_Width-14, .5)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(getBtn.left, getBtn.top+2, .5, tf.height-4)];
    view2.backgroundColor = [UIColor colorWithHexString:@"#D7D8D7"];
    [self.view addSubview:view2];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(30/2, validTf.bottom+74/2, kScreen_Width-30, 98/2);
    registerBtn.layer.cornerRadius = 5;;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn setTitle:@"完成" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.userInteractionEnabled = NO;
    //    registerBtn.userInteractionEnabled = YES;// 测试
    self.registerBtn = registerBtn;
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
}


- (void)registerAction
{
    [self.view endEditing:YES];
    
    
    [SVProgressHUD show];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.tf.text forKey:@"Phone"];
    [paramDic  setValue:self.validTf.text forKey:@"VerificaCode"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:ModifyUserPhone dic:paramDic Succed:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            //            NSString *msg = [responseObject objectForKey:@"Message"];
            
            [self.view makeToast:@"修改成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewController:@"SettingVC"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshNotification" object:nil];

            });

            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];

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
    if (self.tf.text.length > 0 && self.validTf.text.length > 0) {
        self.registerBtn.userInteractionEnabled = YES;
        self.registerBtn.backgroundColor=[UIColor colorWithHexString:@"#BD2F3B"];
    } else {
        self.registerBtn.userInteractionEnabled = NO;
        self.registerBtn.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
