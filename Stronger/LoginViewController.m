//
//  LoginViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/10/22.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressLogin:(id)sender {
    NSString* uName=@"11";
    NSString* uPass=@"11";
    
    if ([_nameTextField.text isEqual:uName]&&[_passwordTextField.text isEqual:uPass]) {
        //从storyboard里面通过storyboardID取出对应的vc
        UITableViewController *purple = [self.storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self presentViewController:purple animated:YES completion:nil];
        
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
        
        
        [alert addAction:[UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *str = [NSHomeDirectory() stringByAppendingPathComponent: @"Library/Caches/com.hackemist.SDWebImageCache.default"];
            
            NSFileManager *file = [NSFileManager defaultManager];
            
            [file removeItemAtPath:str error:nil];
            
        }]];
        
        [self presentViewController:alert animated:YES completion:NULL];
        //加载alert控制器。
        
    }
    

}
@end
