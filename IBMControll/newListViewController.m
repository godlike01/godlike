//
//  newListViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-24.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "newListViewController.h"

@interface newListViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
- (IBAction)Fadd:(id)sender;
- (IBAction)Sadd:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)upload:(id)sender;

@end

@implementation newListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"新增工单";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Fadd:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从手机相册中选取", nil];
    [sheet showInView:self.view];
    NSLog(@"222");
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];//打开相机
            break;
        case 1:
            [self localPhoto];
            break;//打开相册
        default:
            break;
    }
}
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"当前设备不支持照相功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)localPhoto{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate=self;
    //设置照片可以编辑
    picker.allowsEditing=YES;
    [self presentViewController:picker animated:YES completion:nil];

}
- (IBAction)Sadd:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从手机相册中选取", nil];
    [sheet showInView:self.view];
}
#pragma mark--photo
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    

}
- (IBAction)pause:(id)sender {
}

- (IBAction)upload:(id)sender {
}
@end
