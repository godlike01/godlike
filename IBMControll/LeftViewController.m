//
//  LeftViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-20.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "CloudViewController.h"
#import "serveListViewController.h"
#import "SYSInfoViewController.h"
#import "mainViewController.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *controlArr;
}
@end

@implementation LeftViewController

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
    controlArr=[NSMutableArray arrayWithObjects:@"主控台",@"云平台管理",@"服务工单",@"系统信息", nil];
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320,200) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    [self loadDownView];
    // Do any additional setup after loading the view.
}
-(void)loadDownView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-60, 320, 60)];
    [self.view addSubview:view];
    view.backgroundColor=[UIColor redColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(100, HEIGHT-30, 80, 30);
    [self.view addSubview:btn];
}
-(void)quit{
    NSLog(@"2");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"quit" object:nil];
}
#pragma mark---table 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return controlArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse=@"reuse";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text=[controlArr objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // LoginViewController *login=[[LoginViewController alloc]init];
    LoginViewController * login=(LoginViewController *)[[[UIApplication sharedApplication]keyWindow]rootViewController];
    DDMenuController *menu=login.menuController;
    switch (indexPath.row) {
        case 0:
        {
            mainViewController *main=[[mainViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:main];
            [menu setRootController:nav animated:YES];
        }
            break;
        case 1:{
            CloudViewController *viewa=[[CloudViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:viewa];
            [menu setRootController:nav animated:YES];
        }
            break;
        case 2:
        {
            serveListViewController *list=[[serveListViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:list];
            [menu setRootController:nav animated:YES];
        }
            break;
        case 3:
        {
            SYSInfoViewController *info=[[SYSInfoViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:info];
            [menu setRootController:nav animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
