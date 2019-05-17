//
//  AppiontmentHomeViewController.h
//  Stronger
//
//  Created by 童阳升 on 2017/12/3.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppiontmentHomeViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableview;
    NSMutableArray* _arrayTest;
}
@end
