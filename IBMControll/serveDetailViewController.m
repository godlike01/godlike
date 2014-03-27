//
//  serveDetailViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-21.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "serveDetailViewController.h"
#import "myControl.h"
#import "Cell1.h"
#import "Cell2.h"
@interface serveDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
//    UITableView *self.tableView;
    NSMutableArray *_dataList;
}
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property(retain,nonatomic)UITableView *tableView;
@end

@implementation serveDetailViewController

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
    // Do any additional setup after loading the view.
    self.title=@"服务器详情";
    self.isOpen=NO;
    [self createBTNS];
    _dataList=[NSMutableArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"1", nil],@"list",@"serve",@"name",nil], nil];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, HEIGHT-60) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionFooterHeight=0;
    self.tableView.sectionHeaderHeight=0;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    [self.view addSubview:self.tableView];

}
-(void)createBTNS{
    int a=10;
    UIButton *btn1=[myControl createButtonWithFrame:CGRectMake(30, a+50, 50, 30) title:@"重启"];
    [self.view addSubview:btn1];
    UIButton *btn2=[myControl createButtonWithFrame:CGRectMake(100, a+50, 50, 30) title:@"关机"];
    [self.view addSubview:btn2];
    UIButton *btn3=[myControl createButtonWithFrame:CGRectMake(150, a+50, 150, 30) title:@"发送管理员密码"];
    [self.view addSubview:btn3];
    UIButton *btn4=[myControl createButtonWithFrame:CGRectMake(200, a+110, 50, 30) title:@"访问"];
    [self.view addSubview:btn4];
    UIButton *btn5=[myControl createButtonWithFrame:CGRectMake(250, a+110, 50, 30) title:@"Ping"];
    [self.view addSubview:btn5];
    
}
#pragma mark--table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[_dataList objectAtIndex:section] objectForKey:@"list"] count]+1;;
        }
    }
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id Cell=[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    if ([Cell isKindOfClass:[Cell1 class]]) {
        return 40;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
        if (self.selectIndex.row==0) {
//            UIButton *btn=[myControl createButtonWithFrame:CGRectMake(@"", <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) title:<#(NSString *)#>
        }
    cell.textLabel.text=@"1";
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"name"];
        cell.titleLabel.text = name;
        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }
        else
        {
            if (!self.selectIndex)
            {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }
            else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }
    else
    {
        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
        NSArray *list = [dic objectForKey:@"list"];
        NSString *item = [list objectAtIndex:indexPath.row-1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    Cell1 *cell = (Cell1 *)[self.tableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.tableView beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	
	[self.tableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
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
