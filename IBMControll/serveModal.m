//
//  serveModal.m
//  IBMControll
//
//  Created by maweiheng on 14-3-24.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "serveModal.h"
#import "ASIFormDataRequest.h"
@implementation serveModal
-(id)initData{
    if (self=[super init]) {
        self.dataArr=[NSMutableArray array];
        [self startURL];
    }
    return self;
    
}
-(void)startURL{

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
            [self.dataArr addObject:serveDic];
        }
        else{
            NSMutableDictionary *serveDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"list",@"未关闭工单",@"name",nil];
            [self.dataArr addObject:serveDic];
        }
    });
    NSLog(@"%@",self.dataArr);

}
@end
