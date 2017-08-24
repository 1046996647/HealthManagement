//
//  AppDelegate.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TabBarController *tabVC;



+ (AppDelegate *)share;

- (CMPedometer *)sharedPedometer;

// 添加闹钟
+ (void)postLocalNotification:(NSString *)clockID clockTime:(NSString *)clockTime weekArr:(NSArray *)array alertBody:(NSString *)alertBody clockMusic:(NSString *)clockMusic;

// 删除闹钟
+ (void)shutdownClock:(NSString *)clockID;


@end

