//
//  ManagerViewController.h
//  Stronger
//
//  Created by game98 on 2019/5/16.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)pressLoginBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *identyBtn;
- (IBAction)pressIdentyBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END
