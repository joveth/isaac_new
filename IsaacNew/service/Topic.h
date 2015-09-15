//
//  Topic.h
//  Isaac
//
//  Created by Shuwei on 15/9/11.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *UName;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *Body;
@property (nonatomic,copy) NSString *Tag;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *Status;
@property (nonatomic,copy) NSString *LastUpdate;
@property (nonatomic,copy) NSNumber *Read;
@property (nonatomic,copy) NSNumber *Comment;

@end
