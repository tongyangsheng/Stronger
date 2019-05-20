//
//  ManagerViewController.m
//  Stronger
//
//  Created by game98 on 2019/5/16.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import "ManagerViewController.h"


@interface ManagerViewController ()

@end

NSString* coachIdAll;

@implementation ManagerViewController

- (void)viewDidLoad {
    
    _nameTextField.delegate=self;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    extern NSString* coachIDAll;
    
    NSString *inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    coachIdAll=inputString;
    
    NSLog(@"inputString: %@", inputString);
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressLoginBtn:(id)sender {
    NSString* uName=@"0";
    
    NSString* uPass=@"0";
    
    if ([_nameTextField.text isEqual:uName]&&[_passwordTextField.text isEqual:uPass]) {
        //从storyboard里面通过storyboardID取出对应的vc
        UITableViewController *purple = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
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
- (IBAction)pressIdentyBtn:(id)sender {
    //从storyboard里面通过storyboardID取出对应的vc
    UITableViewController *purple = [self.storyboard instantiateViewControllerWithIdentifier:@"userLogin"];
    [self presentViewController:purple animated:YES completion:nil];
}
@end
