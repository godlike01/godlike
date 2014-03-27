//
//  myControl.m
//  IBMControll
//
//  Created by maweiheng on 14-3-21.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "myControl.h"

@implementation myControl
+(UIButton *)createButtonWithFrame:(CGRect)rect title:(NSString *)title{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return button;
}
@end
