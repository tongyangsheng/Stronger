//
//  cAppointFirstViewController.h
//  Stronger
//
//  Created by game98 on 2019/5/17.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface cAppointFirstViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableview;
    NSMutableArray* _arrayTest;
}
@end

NS_ASSUME_NONNULL_END
