//
//  LoginViewController.h
//  IBMControll
//
//  Created by maweiheng on 14-3-19.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@interface LoginViewController : UIViewController
@property (strong, nonatomic) DDMenuController *menuController;

@end
