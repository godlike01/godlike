//
//  LoginViewController.m
//  IBMControll
//
//  Created by maweiheng on 14-3-19.
//  Copyright (c) 2014年 maweiheng. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "mainViewController.h"
#import "LeftViewController.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonCryptor.h>
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)login:(id)sender;
@end

@implementation LoginViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quit) name:@"quit" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewUp) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewDown) name:UIKeyboardWillHideNotification object:nil];
    [self addObserver:self forKeyPath:@"userName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@",change);
    NSLog(@"%@",[change valueForKey:NSKeyValueChangeNewKey]);
}
-(void)quit{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewUp
{
    [UIView animateWithDuration:0.2 animations:^{
    self.view.center=CGPointMake(160,HEIGHT/2-130);}];
}
-(void)viewDown{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.center=CGPointMake(160, HEIGHT/2);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)login:(id)sender {
    MBProgressHUD *    mbd=[[MBProgressHUD alloc]initWithView:self.view];
    mbd.dimBackground=YES;
    mbd.labelText=@"正在登录";
    [mbd show:YES];
    NSString *finalString=[NSString stringWithFormat:@"%@/user/login",BASEURL];
    NSDateFormatter *dateFromate=[[NSDateFormatter alloc]init];
    [dateFromate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curreentStr=[dateFromate stringFromDate:[NSDate date]];
    NSLog(@"%@",curreentStr);
  //时间戳
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter2 setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"hh:mm:ss"]
    [dateFormatter2 setDateFormat:@"SSS"];
    NSString *stamp = [dateFormatter2 stringFromDate:[NSDate date]];
    NSString *encodeString=[NSString stringWithFormat:@"%@+%@+%@",self.passWord.text,@"01",stamp];
    NSLog(@"%@",encodeString);
    NSString *final=[LoginViewController encryptUseDES:encodeString key:@"SDFA234YY"];
    NSLog(@"%@",final);
    NSLog(@"%@",[LoginViewController decryptUseDES:final key:@"SDFA234YY"]);

    ASIFormDataRequest *requset=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:finalString]];
    [requset setPostValue:self.userName.text forKey:@"username"];
    [requset setPostValue:self.passWord.text forKey:@"password"];
    [requset startSynchronous];
//    NSData *data=[requset responseData];
//    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    if ([[dic objectForKey:@"code"]isEqualToString:@"200"]) {
//        //success
//        NSString *String=[[dic objectForKey:@"data"]objectForKey:@"access_token"];
//        [[NSUserDefaults standardUserDefaults]setObject:String forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults]setObject:@"uuuuuuusaaaaaaaaadf7879" forKey:@"access_token"];
        mainViewController *main=[[mainViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:main];

        DDMenuController *rootController=[[DDMenuController alloc]initWithRootViewController:nav];
        _menuController=rootController;
        
        LeftViewController *leftController=[[LeftViewController alloc]init];
        rootController.leftViewController=leftController;
    if (mbd) {
        [mbd removeFromSuperview];
        mbd=nil;
    }
        [self presentViewController:rootController animated:YES completion:nil];
    //}
}
#pragma mark makeSeverToken

const Byte iv[] = {1,2,3,4,5,6,7,8};
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding,[key UTF8String], kCCKeySizeDES,iv,[textData bytes], dataLength,buffer, 1024,&numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [LoginViewController encode:data];
    }
    return ciphertext;
}
+(NSString *)encode:(NSData *)data
{
    if (data.length == 0)
        return nil;
    
    char *characters = malloc(data.length * 3 / 2);
    
    if (characters == NULL)
        return nil;
    
    NSInteger end = data.length - 3;
    int index = 0;
    int charCount = 0;
    int n = 0;
    
    while (index <= end) {
        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[data bytes])[index + 1]) & 0x0ff) << 8)
        | ((int)(((char *)[data bytes])[index + 2]) & 0x0ff);
        
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = encodingTable[d & 63];
        
        index += 3;
        
        if(n++ >= 14)
        {
            n = 0;
            characters[charCount++] = ' ';
        }
    }
    
    if(index == data.length - 2)
    {
        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[data bytes])[index + 1]) & 255) << 8);
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = '=';
    }
    else if(index == data.length - 1)
    {
        int d = ((int)(((char *)[data bytes])[index]) & 0x0ff) << 16;
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = '=';
        characters[charCount++] = '=';
    }
    NSString * rtnStr = [[NSString alloc] initWithBytesNoCopy:characters length:charCount encoding:NSUTF8StringEncoding freeWhenDone:YES];
    return rtnStr;
    
}
#pragma mark ----des
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [LoginViewController decode:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}
+(NSData *)decode:(NSString *)data
{
    if(data == nil || data.length <= 0) {
        return nil;
    }
    NSMutableData *rtnData = [[NSMutableData alloc]init];
    NSInteger slen = data.length;
    int index = 0;
    while (true) {
        while (index < slen && [data characterAtIndex:index] <= ' ') {
            index++;
        }
        if (index >= slen || index  + 3 >= slen) {
            break;
        }
        
        int byte = ([self char2Int:[data characterAtIndex:index]] << 18) + ([self char2Int:[data characterAtIndex:index + 1]] << 12) + ([self char2Int:[data characterAtIndex:index + 2]] << 6) + [self char2Int:[data characterAtIndex:index + 3]];
        Byte temp1 = (byte >> 16) & 255;
        [rtnData appendBytes:&temp1 length:1];
        if([data characterAtIndex:index + 2] == '=') {
            break;
        }
        Byte temp2 = (byte >> 8) & 255;
        [rtnData appendBytes:&temp2 length:1];
        if([data characterAtIndex:index + 3] == '=') {
            break;
        }
        Byte temp3 = byte & 255;
        [rtnData appendBytes:&temp3 length:1];
        index += 4;
        
    }
    return rtnData;
}

+(int)char2Int:(char)c
{
    if (c >= 'A' && c <= 'Z') {
        return c - 65;
    } else if (c >= 'a' && c <= 'z') {
        return c - 97 + 26;
    } else if (c >= '0' && c <= '9') {
        return c - 48 + 26 + 26;
    } else {
        switch(c) {
            case '+':
                return 62;
            case '/':
                return 63;
            case '=':
                return 0;
            default:
                return -1;
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];//ARC下要移除通知中心和time计时器等无法遵守arc的对象
}

@end
