//
//  MessageViewController.m
//  Stronger
//
//  Created by game98 on 2019/5/17.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import "MessageViewController.h"
#import "coachModel.h"
#import "coachSQL.h"
#import "JiaoViewController.h"
#import "Cell.h"

@interface MessageViewController ()

@end

@implementation MessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    extern NSIndexPath *cellRow;
    
    NSIndexPath *IndexPath=cellRow;
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)IndexPath.row];
    
    
    
        _coachIDLabel.text=inStr;
    
    
    NSArray* myArray=@[@"Tony",@"Jack",@"Jessic",@"Herry",@"LuLu"];
    
    _coachNameLabel.text=[myArray objectAtIndex:IndexPath.row];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"AddCoach"])
    {
        //写入数据库
        coachModel *model=[[coachModel alloc]init];
        model.coachID=self.coachIDLabel.text;
        model.coachName=self.coachNameLabel.text;
        model.coachClass=self.coachClassTF.text;
        model.coachTime=self.coachTimeTF.text;
        model.coachPlace=self.coachPlaceTF.text;
        
        [[coachSQL shareManager]insert:model];
    }
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
