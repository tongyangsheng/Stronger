//
//  ViewController.m
//  Stronger
//
//  Created by 童阳升 on 2018/4/9.
//  Copyright © 2018年 童阳升. All rights reserved.
//

#import "ViewController.h"
#define IDENTIFY @"identify"

@interface ViewController ()
@property (copy,nonatomic)  NSArray *datas;
@property (nonatomic) BOOL nibRegistered;
@end

@implementation ViewController
@synthesize datas;
@synthesize nibRegistered;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    datas=@[@"江西",@"贵州",@"湖南",@"安徽"];
    self.table.delegate=self;
    self.table.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell *cell=[self.table dequeueReusableCellWithIdentifier:IDENTIFY];
    if(cell==nil){
        cell =[[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil ] lastObject];
    }
    [cell.cTitle setText: [datas objectAtIndex:[indexPath row]]];
    [cell.cImage setImage:[UIImage imageNamed:@"ditu.png"]];
    [cell.cDesc setText:@"位置"];
    return cell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
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
