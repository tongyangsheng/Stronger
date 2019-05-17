//
//  MessageViewController.h
//  Stronger
//
//  Created by game98 on 2019/5/17.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *coachIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *coachClassTF;
@property (weak, nonatomic) IBOutlet UITextField *coachPlaceTF;
@property (weak, nonatomic) IBOutlet UITextField *coachTimeTF;

@end

NS_ASSUME_NONNULL_END
