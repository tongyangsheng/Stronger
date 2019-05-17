//
//  Cell.h
//  Stronger
//
//  Created by 童阳升 on 2018/4/9.
//  Copyright © 2018年 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cImage;
@property (weak, nonatomic) IBOutlet UILabel *cTitle;
@property (weak, nonatomic) IBOutlet UILabel *cDesc;

@end
