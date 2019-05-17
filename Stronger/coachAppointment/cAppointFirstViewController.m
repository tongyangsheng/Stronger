//
//  cAppointFirstViewController.m
//  Stronger
//
//  Created by game98 on 2019/5/17.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import "cAppointFirstViewController.h"
#import "coachModel.h"
#import "coachSQL.h"
#import "coachAppointCell.h"


#define IDENTIFY1 @"identifyCoach"

@interface cAppointFirstViewController ()
//数据源-模型
@property(strong,nonatomic)NSMutableArray *coachArray;

@end

@implementation cAppointFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.coachArray=[[NSMutableArray alloc]init];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.coachArray=[[NSMutableArray alloc]init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //数据视图代理对象以及数据源
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    if ([UIScreen mainScreen].bounds.size.height ==812||[UIScreen mainScreen].bounds.size.height ==896){
        _tableview.frame=CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-145-34);
        NSLog(@"iphoneX 以上机型");
    }
    else
    {
        _tableview.frame=CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-140);
        NSLog(@"老版本机型");
    }
    
    _tableview.backgroundColor=[UIColor whiteColor];
    
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    
    [self.view addSubview:_tableview];
    
    NSArray  *result=[[coachSQL shareManager]load];
    
    [_coachArray setArray:result];
    
    [_tableview reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _coachArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     coachAppointCell *coachCell=[_tableview dequeueReusableCellWithIdentifier:IDENTIFY1];
    
    if(coachCell==nil){
        coachCell=[[[NSBundle mainBundle]loadNibNamed:@"coachAppointCell" owner:self options:nil] lastObject];
    }
   
        coachModel *model=[self.coachArray objectAtIndex:indexPath.row];
        
        coachCell.coachName.text=model.coachName;
        coachCell.coachPlace.text=model.coachPlace;
        coachCell.coachTime.text=model.coachTime;
        coachCell.coachClass.text=model.coachClass;
        
    
    return coachCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(IBAction)addCoachDone:(UIStoryboardSegue *)sender
{
    coachModel *model=[[coachModel alloc]init];
    
    NSArray  *result=[[coachSQL shareManager]reloadData:model];
    
    
    [_coachArray setArray:result];
    
    [_tableview reloadData];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
