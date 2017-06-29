//
//  InfoCache.m
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "InfoCache.h"

@implementation InfoCache

//------------------NSUserDefaults--------------------
+ (void)saveUserID:(NSString *)str
{
    [self saveInfo:str];
}

+ (NSString *)getUserID:(NSString *)str
{

    return [self getInfo:str];
}


// 共有的
+ (void)saveInfo:(NSString *)str
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:str forKey:str];
    [userDefaultes synchronize];
}

+ (NSString *)getInfo:(NSString *)str
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    str = [userDefaultes objectForKey:str];
    return str;
}

//------------------archive/unarchive--------------------
+ (void)archiveObject:(id)obj toFile:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:obj toFile:path];
    
}

+ (id)unarchiveObjectWithFile:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
