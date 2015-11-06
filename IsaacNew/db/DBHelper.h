//
//  DBHelper.h
//  Isaac
//
//  Created by Shuwei on 15/7/2.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "User.h"
#import "ModSeedBean.h"
typedef void (^BOOLCallBack)(BOOL ret);

@interface DBHelper : NSObject
+(id)sharedInstance;
-(BOOL)openDB;
-(void)initData:(BOOLCallBack)success;
-(void)deleteData;
-(void)initModSeedData:(BOOLCallBack)success;
-(NSInteger)getCnt;
-(NSInteger)getModSeedCnt;
-(NSMutableArray *)getIsaacs:(NSString *)offset;
-(NSMutableArray *)getIsaacsByKey:(NSString *)keyword;
-(NSMutableArray *)getIsaacsByType:(NSString *)type;
-(NSMutableArray *)getBoss:(NSString *)offset;
-(NSMutableArray *)getBossByKey:(NSString *)keyword;
-(NSMutableArray *)getSmall:(NSString *)offset;
-(NSMutableArray *)getOtherByType:(NSString *)type;
-(NSMutableArray *)getOther;
-(User *)getUser;
-(void)saveUser:(User *)user;
-(NSMutableArray *)getModOrSeed:(NSString *)type;
@end
