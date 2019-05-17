//
//  JiaoViewController.m
//  Stronger
//
//  Created by 童阳升 on 2018/4/9.
//  Copyright © 2018年 童阳升. All rights reserved.
//

#import "JiaoViewController.h"
#import "cAppointFirstViewController.h"
#define IDENTIFY @"identify"

NSIndexPath *cellRow;

@interface JiaoViewController ()
@property (copy,nonatomic)  NSArray *datas;
@property (nonatomic) BOOL nibRegistered;
@end

@implementation JiaoViewController

@synthesize datas;

@synthesize nibRegistered;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datas=@[@"Tony",@"Jack",@"Jessic",@"Herry",@"LuLu"];
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
    NSArray* myArray=@[@"氧适堡健身房",@"优+健身房",@"飞特健身房",@"周一健身房",@"韬博健身房"];
    NSString* str=[myArray objectAtIndex:indexPath.row];
    NSString* stt =[NSString stringWithFormat:@"头像 男孩-%ld.png",indexPath.row % 5+1];
    [cell.cTitle setText: [datas objectAtIndex:[indexPath row]]];
    [cell.cImage setImage:[UIImage imageNamed:stt]];
    [cell.cDesc setText:str];
    tableView.rowHeight=94;
    return cell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[self.table cellForRowAtIndexPath:indexPath];
    
    NSIndexPath *indexPath1=[self.table indexPathForCell:cell];
    
    cellRow=indexPath1;
    
    cAppointFirstViewController *one=[[self storyboard]instantiateViewControllerWithIdentifier:@"view2"];
    [[self navigationController]pushViewController:one animated:YES];
    
    
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
