//
//  CloudViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-21.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "CloudViewController.h"
#import "myControl.h"
#import "cloudModal.h"
#import "serveDetailViewController.h"
@interface CloudViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    cloudModal *modal;
}
@end

@implementation CloudViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"云平台管理";
    [self loadMain];
    modal=[[cloudModal alloc]initData];
}
-(void)loadMain{
    UIButton *btn=[myControl createButtonWithFrame:CGRectMake(60, 80, 100, 30) title:@"工作平台"];
    btn.tag=101;
    [btn addTarget:self action:@selector(platForm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1=[myControl createButtonWithFrame:CGRectMake(160, 80, 100, 30) title:@"服务器"];
    btn1.tag=102;
    [btn1 addTarget:self action:@selector(servelist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, HEIGHT-120) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    [self.view addSubview:_tableView];
}
-(void)platForm{
    _dataArr=modal.PlatArr;
    [_tableView reloadData];
}
-(void)servelist{
    _dataArr=modal.ServeArr;
    [_tableView reloadData];
}
#pragma mark ---table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuser=@"reuser";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
        
    }
    cell.textLabel.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"name"];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    serveDetailViewController *detail=[[serveDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];

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
