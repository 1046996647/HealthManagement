//
//  AFNetworking_RequestData.m
//  AFNetworking_RequestData
//
//  Created by 余晋龙 on 2016/10/31.
//  Copyright © 2016年 余晋龙. All rights reserved.
//


#import "AFNetworking_RequestData.h"
#import "LoginVC.h"
#import "NavigationController.h"


@implementation AFNetworking_RequestData


//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 20;

#pragma GET请求--------------
+(void)requestMethodGetUrl:(NSString*)url
                       dic:(NSMutableDictionary*)dic
                    Succed:(Success)succed
                   failure:(Failure)failure{
    //1.数据请求接口 2.请求方法 3.参数
    //请求成功   返回数据
    //请求失败   返回错误
    [AFNetworking_RequestData Manager:url Method:@"GET"  dic:dic requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
        
    }];
}
#pragma POST请求--------------
+(void)requestMethodPOSTUrl:(NSString*)url
                  dic:(NSMutableDictionary*)dic
               Succed:(Success)succed
              failure:(Failure)failure{
    
    [AFNetworking_RequestData Manager:url Method:@"POST"  dic:dic requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
    }];
}

//=====================
+(void)Manager:(NSString*)url Method:(NSString*)Method dic:(NSMutableDictionary*)dic requestSucced:(Success)Succed requestfailure:(Failure)failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval; //默认网络请求时间
     manager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明返回的结果是json类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    
    //======POST=====
    if ([Method isEqualToString:@"POST"]) {
        
        if (person) {
            [dic  setValue:person.Token forKey:@"Token"];
            [dic  setValue:person.UserId forKey:@"UserId"];
        }

        
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSNumber *code = [responseObject objectForKey:@"HttpCode"];
            
            if (700 == code.integerValue) {
                
                if ([[InfoCache getValueForKey:@"LoginedState"] integerValue]) {
                    
                    [[UIApplication sharedApplication].keyWindow makeToast:@"您已被挤下线!"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        LoginVC *loginVC = [[LoginVC alloc] init];
                        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
                        
                        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                        
                        [InfoCache saveValue:@0 forKey:@"LoginedState"];
                    });
                    

                }
                

                

            }
            
            Succed(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:@"网络似乎已断开!"];
            
            failure(error);
        }];
        
        
    //=========GET======
    }else{
        
        [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            Succed(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:@"网络似乎已断开!"];

            failure(error);
            
        }];
    }
    
}

@end
