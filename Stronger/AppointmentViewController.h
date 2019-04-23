//
//  AppointmentViewController.h
//  Stronger
//
//  Created by 童阳升 on 2017/11/21.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *mainNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *machineTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *machineTypeTextField;
@property (weak, nonatomic) IBOutlet UILabel *machineIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *machineIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@end
