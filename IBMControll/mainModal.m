//
//  mainModal.m
//  IBMControll
//
//  Created by maweiheng on 14-3-20.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "mainModal.h"
#import "ASIFormDataRequest.h"
@implementation mainModal
-(id)initData{
    if (self=[super init]) {
        self.arr=[NSMutableArray array];
        [self startUrl];
    }
    return self;
}
-(void)startUrl{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    NSString *finalStr1=[NSString stringWithFormat:@"%@/server/list",BASEURL];
    ASIFormDataRequest *requset=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:finalStr1]];
    NSString *token=[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [requset setPostValue:token forKey:@"access_token"];
    [requset startAsynchronous];
        NSData *data=[requset responseData];
        if (data.length>1) {
        NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array1=[NSArray arrayWithObject:@"empty"];
        if (dic) {
            array1=[dic objectForKey:@"data"];
        }
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:array1,@"list",@"服务器",@"name",nil];
            [self.arr addObject:serveDic];
        }
        else{
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"list",@"服务器",@"name",nil];
        [self.arr addObject:serveDic];
            }
    });
    NSLog(@"%@",self.arr);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *finalStr1=[NSString stringWithFormat:@"%@/user/app/list",BASEURL];
        ASIFormDataRequest *requset=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:finalStr1]];
        NSString *token=[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [requset setPostValue:token forKey:@"access_token"];
        [requset startAsynchronous];
        NSData *data=[requset responseData];
        if (data.length>1) {
            NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *array1=[NSArray arrayWithObject:@"empty"];
            if (dic) {
                array1=[dic objectForKey:@"data"];
            }
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:array1,@"list",@"应用查询",@"name",nil];
            [self.arr addObject:serveDic];
        }
        else{
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"list",@"应用查询",@"name",nil];
            [self.arr addObject:serveDic];
        }
    });
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *finalStr1=[NSString stringWithFormat:@"%@/workOrder/undone/list",BASEURL];
        ASIFormDataRequest *requset=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:finalStr1]];
        NSString *token=[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [requset setPostValue:token forKey:@"access_token"];
        [requset startAsynchronous];
        NSData *data=[requset responseData];
        if (data.length>1) {
            NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *array1=[NSArray arrayWithObject:@"empty"];
            if (dic) {
                array1=[dic objectForKey:@"data"];
            }
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:array1,@"list",@"未关闭工单",@"name",nil];
            [self.arr addObject:serveDic];
        }
        else{
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"list",@"未关闭工单",@"name",nil];
            [self.arr addObject:serveDic];
        }
    });

    NSLog(@"%@",self.arr);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *finalStr1=[NSString stringWithFormat:@"%@/message/unread/list",BASEURL];
        ASIFormDataRequest *requset=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:finalStr1]];
        NSString *token=[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [requset setPostValue:token forKey:@"access_token"];
        [requset startAsynchronous];
        NSData *data=[requset responseData];
        if (data.length>1) {
            NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",string);
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *array1=[NSArray arrayWithObject:@"empty"];
            if (dic) {
                array1=[dic objectForKey:@"data"];
            }
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:array1,@"list",@"未阅读消息",@"name",nil];
            [self.arr addObject:serveDic];
        }
        else{
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"list",@"未阅读消息",@"name",nil];
            [self.arr addObject:serveDic];
        }
    });
    NSLog(@"%@",self.arr);
}
@end
