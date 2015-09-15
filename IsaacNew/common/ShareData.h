//
//  ShareData.h
//  Isaac
//
//  Created by Shuwei on 15/7/23.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BossBean.h"
#import "IsaacBean.h"
@interface ShareData : NSObject

@property(atomic,retain) IsaacBean *isaacBean;
@property(atomic,retain) BossBean *bossBean;
@property(atomic,retain) NSString *type;
@property(atomic,retain) NSString *urltype;
@property(atomic,retain) NSString *title;
+(ShareData *) shareInstance;
@end
