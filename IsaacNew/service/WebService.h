//
//  WebService.h
//  Isaac
//
//  Created by Shuwei on 15/9/11.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"
#import "User.h"

@interface WebService : NSObject

@property  NSInteger lastRetcode;
@property  NSInteger status;
typedef void (^CallBack)(NSArray *_ret);
typedef void (^ErrorCallBack)(NSInteger code);
typedef void (^StringCallBack)(NSString *_ret);

+(void)getAllTopicsWithPage:(NSInteger )page andTag:(NSString *)tag andSuc:(CallBack)callBack andErr:(ErrorCallBack)err;
+(void)getUser:(NSString * )name andSuc:(CallBack)callBack andErr:(ErrorCallBack)err;
+(void)login:(NSString * )name andPass:(NSString * )pass andSuc:(CallBack)callBack andErr:(ErrorCallBack)err;
+(void)regist:(NSString * )name andPass:(NSString * )pass andEmail:(NSString * )email andSuc:(CallBack)callBack andErr:(ErrorCallBack)err;


@end
