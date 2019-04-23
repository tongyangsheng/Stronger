//
//  AppointmentViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/11/21.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "AppointmentViewController.h"
#import "UserModel.h"
#import "SQLManager.h"
#import "AppiontmentHomeViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"AddUser"]) {
        UserModel *model=[[UserModel alloc]init];
        
        model.idUserNumber = self.userIdTextField.text;
        model.userName=self.userNameTextField.text;
        model.machineType=self.machineTypeTextField.text;
        model.machineId=self.machineIdTextField.text;
        model.date=self.dateTextField.text;
        model.place=self.placeTextField.text;
        model.time=self.timeTextField.text;
        UserModel *result=[[SQLManager shareManager]searchWithUserId:model];
         [[SQLManager shareManager]insert:model];
        AppiontmentHomeViewController *honeView = segue.destinationViewController;
    }
}

@end
