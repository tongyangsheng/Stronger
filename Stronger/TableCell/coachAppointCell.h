//
//  coachAppointCell.h
//  Stronger
//
//  Created by game98 on 2019/5/17.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface coachAppointCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (weak, nonatomic) IBOutlet UILabel *coachPlace;
@property (weak, nonatomic) IBOutlet UILabel *coachClass;
@property (weak, nonatomic) IBOutlet UILabel *coachTime;


@end

NS_ASSUME_NONNULL_END
