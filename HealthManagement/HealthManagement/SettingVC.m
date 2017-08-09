//
//  SettingVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "NavigationController.h"
#import "registerVC.h"
#import "PopViewVC.h"
#import "UIImage+UIImageExt.h"
#import "InfoChangeController.h"


@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) UIImageView *headImg;


@end

@implementation SettingVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, kScreen_Height-64-20-45)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftDataList = @[@"头像",@"名字",@"手机",@"密码"];
    
    if (!self.person.name) {
        self.person.name = @"";
    }
    if (!self.person.phone) {
        self.person.phone = @"尚未绑定";
    }
    self.rightDataList = @[@"",self.person.name,self.person.phone,@"修改"];
    
    [self.view addSubview:self.tableView];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(0, kScreen_Height-45-64, kScreen_Width, 45);
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:exitBtn];
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)exitAction
{
    [InfoCache saveValue:@0 forKey:@"LoginedState"];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LoginVC *loginVC = [[LoginVC alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
    delegate.window.rootViewController = nav;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 232/2;

    }
    return 116/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取单元格
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        PopViewVC *popViewVC  = [[PopViewVC alloc] init];
        popViewVC.titleArr = @[@"相册",@"拍照"];
        popViewVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        //淡出淡入
        popViewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //  self.definesPresentationContext = YES; //不盖住整个屏幕
        popViewVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        [self presentViewController:popViewVC animated:YES completion:nil];
        popViewVC.clickBlock = ^(NSInteger indexRow) {
            
            // 创建相册控制器
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            
            // 设置代理对象
            pickerController.delegate = self;
            // 设置选择后的图片可以被编辑
            //            pickerController.allowsEditing=YES;
            
            // 跳转到相册页面
            [self presentViewController:pickerController animated:YES completion:nil];
            
            if (indexRow == 0) {
                

                // 设置类型
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                // 设置为静态图像类型
                pickerController.mediaTypes = @[@"public.image"];

                
            } else {
                NSLog(@"打开摄像头");
                // 判断当前设备是否有摄像头
                if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {

                    // 设置类型
                    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

                }
            }
        };

        
    }
    if (indexPath.row == 1) {
        
        InfoChangeController *vc = [[InfoChangeController alloc] init];
        vc.title = @"名字";
        vc.text = cell.detailTextLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *str) {
            
            self.person.name = str;
            [self saveAction];
            
        };
        
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {
        
        registerVC *vc = [[registerVC alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor whiteColor];

    }
    
    if (indexPath.row == 0) {
        
        if (!self.headImg) {
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-156/2-30, (232/2-156/2)/2, 156/2, 156/2)];
            headImg.layer.cornerRadius = headImg.height/2.0;
            headImg.layer.masksToBounds = YES;
            [cell.contentView addSubview:headImg];
            self.headImg = headImg;
        }
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.person.HeadImage] placeholderImage:[UIImage imageNamed:@""]];

    }

    cell.textLabel.text = self.leftDataList[indexPath.row];
//    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    cell.detailTextLabel.text = self.rightDataList[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#898989"];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

//选取后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info:%@",info[UIImagePickerControllerOriginalImage]);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];

    
//    NSData *data = [UIImage imageCompressForWidth:img targetWidth:100];
    
    NSData *data = [UIImage imageOrientation:img];
    

    [self uploadImage:data];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    NSDictionary *dict = @{@"username":@"Saup"};
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:UploadImage parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        UIImage *image =[UIImage imageNamed:@"moon"];
//        NSData *data = UIImagePNGRepresentation(img);
        NSData *data = UIImageJPEGRepresentation(img,.5);
        
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
        NSLog(@"------%@",formData);

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败 %@", error);
    }];
    
    
}

//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)uploadImage:(NSData *)data
{
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
//    NSLog(@"!!!!!!%@",encodedImageStr);

    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:encodedImageStr forKey:@"imageStr"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:UploadUserHeadImage dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        self.person.HeadImage = responseObject[@"Model1"];
        [self saveAction];
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

//- (void)uploadImage:(NSString *)base64Str
//{
//    
//    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
//    [paramDic  setObject:base64Str forKey:@"imageStr"];
//    
//    [AFNetworking_RequestData requestMethodPOSTUrl:UploadUserHeadImage dic:paramDic Succed:^(id responseObject) {
//        
//        [SVProgressHUD dismiss];
//        
//        NSLog(@"%@",responseObject);
//        
//        self.person.HeadImage = responseObject[@"Model1"];
//        [self saveAction];
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
//}

// 保存用户信息
- (void)saveAction
{
    [SVProgressHUD show];
    
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.person.name
                 forKey:@"UserName"];
    [paramDic  setValue:self.person.HeadImage
                 forKey:@"HeadImage"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            [self getUserBodyInfo];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}

// 获取用户信息
- (void)getUserBodyInfo
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.person.UserId forKey:@"Id"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            NSArray *arr = [responseObject objectForKey:@"ListData"];
            PersonModel *model = [PersonModel yy_modelWithJSON:[arr firstObject]];
            self.person = model;
            [InfoCache archiveObject:model toFile:@"Person"];
            
            if (!self.person.name) {
                self.person.name = @"";
            }
            if (!self.person.phone) {
                self.person.phone = @"尚未绑定";
            }
            self.rightDataList = @[@"",self.person.name,self.person.phone,@"修改"];
            
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.person.HeadImage] placeholderImage:[UIImage imageNamed:@"error_head"]];

            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}

@end
