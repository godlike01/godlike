//
//  NewMainViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-24.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "NewMainViewController.h"
#import "newListViewController.h"
@interface NewMainViewController ()
- (IBAction)detail:(id)sender;

@end

@implementation NewMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detail:(id)sender {
    newListViewController *list=[[newListViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
@end
