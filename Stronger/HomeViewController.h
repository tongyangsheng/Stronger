//
//  HomeViewController.h
//  Stronger
//
//  Created by 童阳升 on 2017/10/24.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableview;
}
@end
