//
//  FirstViewController.m
//  Stronger
//
//  Created by game98 on 2019/5/16.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import "FirstViewController.h"
#import "ManagerViewController.h"
#import "coachModel.h"
#import "coachSQL.h"

@interface FirstViewController ()

@property(strong,nonatomic)NSMutableArray *coachArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    
    self.coachArray=[[NSMutableArray alloc]init];
    
    coachModel* model=[[coachModel alloc]init];
    
    extern NSString* coachIdAll;
    
    model.coachID=coachIdAll;
    

    
    coachModel *result=[[coachSQL shareManager]searchWithUserId:model];
    
    _catTime.text=result.coachTime;
    

    
    _catClass.text=result.coachClass;
    
    _catPlace.text=result.coachPlace;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
