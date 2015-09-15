//
//  WebService.m
//  Isaac
//
//  Created by Shuwei on 15/9/11.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "WebService.h"
#import "SWDefine.h"

@implementation WebService

+(void)getAllTopicsWithPage:(NSInteger )page andTag:(NSString *)tag andSuc:(CallBack)callBack andErr:(ErrorCallBack)err;
{
    NSURL *baseURL = [NSURL URLWithString:WEB_BASE_URL];
    RKObjectManager *manager =  [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *WebResponse = [RKObjectMapping mappingForClass:[Topic class]];
    
    [WebResponse addAttributeMappingsFromDictionary:@{
                                                      @"Id":@"Id",
                                                      @"Title" : @"Title",
                                                      @"Title" : @"Title",
                                                      @"Body" : @"Body",
                                                      @"Tag" : @"Tag",
                                                      @"CreateDate" : @"CreateDate",
                                                      @"Status" : @"Status",
                                                      @"LastUpdate" : @"LastUpdate",
                                                      @"Read" : @"Read",
                                                      @"Comment" : @"Comment"
                                                      }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:WebResponse
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:@"/m/topics"
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // Add the above response descriptor to the manager
    [manager addResponseDescriptor:responseDescriptor];
    manager.HTTPClient.allowsInvalidSSLCertificate=YES;
    NSDictionary * params=@{
                            @"page":[NSString stringWithFormat:@"%ld",page],@"tag":tag };
    // the getObject makes the call using the stuff assembled into the manager Object and drops into either the success or the failure routines.
    [manager postObject:nil path:@"/m/topics" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         
         if(callBack){
             NSArray *respArray = [result array];
             callBack(respArray);
         }
     }  failure:^(RKObjectRequestOperation * operation, NSError * error)
     {
         if(err){
             NSInteger code = operation.HTTPRequestOperation.response.statusCode;
             err(code);
         }
     }];
}
+(void)getUser:(NSString * )name andSuc:(CallBack)callBack andErr:(ErrorCallBack)err{
    NSURL *baseURL = [NSURL URLWithString:WEB_BASE_URL];
    RKObjectManager *manager =  [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *WebResponse = [RKObjectMapping mappingForClass:[User class]];
    
    [WebResponse addAttributeMappingsFromDictionary:@{
                                                      @"Name":@"Name",
                                                      @"Email" : @"Email",
                                                      @"Phone" : @"Phone",
                                                      @"CreateDate" : @"CreateDate",
                                                      @"Logo" : @"Logo"
                                                      }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:WebResponse
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:@"/m/user"
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // Add the above response descriptor to the manager
    [manager addResponseDescriptor:responseDescriptor];
    manager.HTTPClient.allowsInvalidSSLCertificate=YES;
    NSDictionary * params=@{@"name":name};
    // the getObject makes the call using the stuff assembled into the manager Object and drops into either the success or the failure routines.
    [manager postObject:nil path:@"/m/user" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         
         if(callBack){
             NSArray *respArray = [result array];
             callBack(respArray);
         }
     }  failure:^(RKObjectRequestOperation * operation, NSError * error)
     {
         if(err){
             NSInteger code = operation.HTTPRequestOperation.response.statusCode;
             err(code);
         }
     }];
}
+(void)login:(NSString * )name andPass:(NSString * )pass andSuc:(CallBack)callBack andErr:(ErrorCallBack)err{
    NSURL *baseURL = [NSURL URLWithString:WEB_BASE_URL];
    RKObjectManager *manager =  [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *WebResponse = [RKObjectMapping mappingForClass:[User class]];
    
    [WebResponse addAttributeMappingsFromDictionary:@{
                                                      @"Name":@"Name",
                                                      @"Email" : @"Email",
                                                      @"CreateDate" : @"CreateDate",
                                                      @"Logo" : @"Logo"
                                                      }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:WebResponse
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:@"/m/login"
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // Add the above response descriptor to the manager
    [manager addResponseDescriptor:responseDescriptor];
    manager.HTTPClient.allowsInvalidSSLCertificate=YES;
    NSDictionary * params=@{@"name":name,@"pass":pass};
    // the getObject makes the call using the stuff assembled into the manager Object and drops into either the success or the failure routines.
    [manager postObject:nil path:@"/m/login" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         
         if(callBack){
             NSArray *respArray = [result array];
             callBack(respArray);
         }
     }  failure:^(RKObjectRequestOperation * operation, NSError * error)
     {
         if(err){
             NSInteger code = operation.HTTPRequestOperation.response.statusCode;
             err(code);
         }
     }];
}
+(void)regist:(NSString * )name andPass:(NSString * )pass andEmail:(NSString * )email andSuc:(CallBack)callBack andErr:(ErrorCallBack)err{

    NSURL *baseURL = [NSURL URLWithString:WEB_BASE_URL];
    RKObjectManager *manager =  [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *WebResponse = [RKObjectMapping mappingForClass:[User class]];
    
    [WebResponse addAttributeMappingsFromDictionary:@{
                                                      @"Name":@"Name",
                                                      @"Email" : @"Email",
                                                      @"CreateDate" : @"CreateDate",
                                                      @"Logo" : @"Logo"
                                                      }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:WebResponse
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:@"/m/regist"
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // Add the above response descriptor to the manager
    [manager addResponseDescriptor:responseDescriptor];
    manager.HTTPClient.allowsInvalidSSLCertificate=YES;
    NSDictionary * params=@{@"name":name,@"pass":pass,@"email":email};
    // the getObject makes the call using the stuff assembled into the manager Object and drops into either the success or the failure routines.
    [manager postObject:nil path:@"/m/regist" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         
         if(callBack){
             NSArray *respArray = [result array];
             callBack(respArray);
         }
     }  failure:^(RKObjectRequestOperation * operation, NSError * error)
     {
         if(err){
             NSInteger code = operation.HTTPRequestOperation.response.statusCode;
             err(code);
         }
     }];
}
@end
