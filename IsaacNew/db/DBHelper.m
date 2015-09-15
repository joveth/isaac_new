//
//  DBHelper.m
//  Isaac
//
//  Created by Shuwei on 15/7/2.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "Common.h"
#import "IsaacBean.h"
#import "BossBean.h"

@interface DBHelper(){
    FMDatabase *db;
}
@end

static const NSString *TB_ISAAC = @"tb_isaac";
static const NSString *TB_BOSS = @"tb_isaac_boss";
static const NSString *TB_SMALL = @"tb_isaac_small";
static const NSString *TB_OTHER = @"tb_other";
static const NSString *TB_USER = @"tb_user";

@implementation DBHelper
+(id)sharedInstance{
    static DBHelper *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[super alloc]init];
    });
    return sharedInstance;
}
-(BOOL)openDB{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"isaac.sqlite"];
    
    // 1.获得数据库对象
    db = [FMDatabase databaseWithPath:fileName];
    
    // 2.打开数据库
    if ([db open]) {
        NSLog(@"打开成功");
        // 2.1创建表
        NSString *sql = @"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, image varchar(20),name varchar(60),enname varchar(60) ,content varchar(1200),power varchar(20),unlock varchar(200),type char(1) )";
        BOOL success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_ISAAC]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, image varchar(20),name varchar(60),enname varchar(60) ,content varchar(1200),score varchar(5))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_BOSS]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, image varchar(20),name varchar(60),enname varchar(60) ,content varchar(500))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_SMALL]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, image varchar(20),name varchar(60),enname varchar(60) ,content varchar(1000),type char(1))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_OTHER]];
        
        sql = @"CREATE TABLE IF NOT EXISTS %@ (Name varchar(100),Email varchar(100),Logo  varchar(100), CreateDate  varchar(100))";
        
        success =  [db executeUpdate:[NSString stringWithFormat:sql,TB_USER]];
        
        return success;
    }else{
        return NO;
    }
}
-(void)initData:(BOOLCallBack)success{
    NSArray *aArray = [@"atore.db" componentsSeparatedByString:@"."];
    NSString *filename = [aArray objectAtIndex:0];
    NSString *sufix = [aArray objectAtIndex:1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
    NSString* myString = [NSString stringWithContentsOfFile:filePath usedEncoding:NULL error:NULL];
    NSArray *result = [myString componentsSeparatedByString:@"\n"];
    if(![db open]){
        if(success){
            success(NO);
        }
        return;
    }
    for(int i=0;i<[result count];i++){
        myString = [result objectAtIndex:i];
        if([Common isEmptyString:myString]){
            continue;
        }
        NSLog(@"sql=%@",myString);
        [db executeUpdate:myString];
    }
    [db close];
    if(success){
        success(YES);
    }
}
-(NSInteger)getCnt{
    if(![db open])
    {
        return 0;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) as total from %@ ",TB_ISAAC]];
    NSString *temp =@"0";
    if ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        temp = dict[@"total"];
    }
    [rs close];
    [db close];
    return temp.integerValue;
}
-(NSMutableArray *)getIsaacs:(NSString *)offset{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ",TB_ISAAC]];
    IsaacBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        bean.power = dict[@"power"];
        bean.unlock = dict[@"unlock"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getIsaacsByKey:(NSString *)keyword{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where enname like '%%%@%%' or  name like '%%%@%%'   ",TB_ISAAC,keyword,keyword]];
    IsaacBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        bean.type=@"0";
        [ret addObject:bean];
    }
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where enname like '%%%@%%' or  name like '%%%@%%'  ",TB_BOSS,keyword,keyword]];
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where enname like '%%%@%%' or  name like '%%%@%%'  ",TB_SMALL,keyword,keyword]];
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }
    
    rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where enname like '%%%@%%' or  name like '%%%@%%'  ",TB_OTHER,keyword,keyword]];
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }

    rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where  content like '%%%@%%' or power like '%%%@%%' or unlock like '%%%@%%' ",TB_ISAAC,keyword,keyword,keyword]];
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }
    
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getIsaacsByType:(NSString *)type{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where type=? ",TB_ISAAC],type];
    IsaacBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        bean.power = dict[@"power"];
        bean.unlock = dict[@"unlock"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getBoss:(NSString *)offset{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ",TB_BOSS]];
    BossBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[BossBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        bean.score = dict[@"score"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getSmall:(NSString *)offset{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ",TB_SMALL]];
    BossBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[BossBean alloc] init];
        bean.sid = dict[@"id"];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(NSMutableArray *)getOtherByType:(NSString *)type{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if(![db open])
    {
        return ret;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  where type=? ",TB_OTHER],type];
    IsaacBean *bean;
    while ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[IsaacBean alloc] init];
        bean.image = dict[@"image"];
        bean.name = dict[@"name"];
        bean.enName = dict[@"enname"];
        bean.content = dict[@"content"];
        [ret addObject:bean];
    }
    [rs close];
    [db close];
    return ret;
}
-(User *)getUser{
    if(![db open])
    {
        return nil;
    }
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@  ",TB_USER]];
    User *bean;
    if ([rs next]) {
        NSDictionary *dict = [rs resultDictionary];
        bean = [[User alloc] init];
        bean.Name = dict[@"Name"];
        bean.Email = dict[@"Email"];
        bean.Logo = dict[@"Logo"];
        bean.CreateDate = dict[@"CreateDate"];
    }
    [rs close];
    [db close];
    return bean;
}
-(void)saveUser:(User *)user{
    if(![db open])
    {
        return ;
    }
    [db executeUpdate:[NSString stringWithFormat:@"delete  from %@  ",TB_USER]];
    NSString *sql = [NSString stringWithFormat:@"insert into %@(Name,Email,Logo,CreateDate) values(?,?,?,?)",TB_USER];
    [db executeUpdate:sql,user.Name,user.Email,user.Logo,user.CreateDate];
    [db close];
    return;
}

@end
