//
//  JiaoViewController.h
//  Stronger
//
//  Created by 童阳升 on 2018/4/9.
//  Copyright © 2018年 童阳升. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import "ViewController.h"
#import "ViewController2.h"
@interface JiaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end
