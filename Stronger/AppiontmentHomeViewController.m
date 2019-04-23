//
//  AppiontmentHomeViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/12/3.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "AppiontmentHomeViewController.h"
#import "UserModel.h"
#import "SQLManager.h"

@interface AppiontmentHomeViewController ()
@property(strong,nonatomic)NSMutableArray *userArray;
#define HomeCellIdentifier (@"UserCell")
@end

@implementation AppiontmentHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userArray=[[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated {
    /* 加载数据 */
    NSArray  *result=[[SQLManager shareManager]load];
    [_userArray setArray:result];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _userArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.userArray.count>0) {
        UserModel *model=[self.userArray objectAtIndex:indexPath.row];
        cell.textLabel.text=model.date;
        cell.detailTextLabel.text=model.machineType;
    }
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}
-(IBAction)addUserDone:(UIStoryboardSegue *)sender
{
    UserModel *model=[[UserModel alloc]init];
    
    NSArray  *result=[[SQLManager shareManager]reloadData:model];
    
    
    [_userArray setArray:result];
    
    [self.tableView reloadData];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"预约成功" message:@"恭喜您成功预约" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    //加载alert控制器。
}
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
