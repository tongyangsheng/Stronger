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
#import "contentCell.h"

#define IDENTIFY @"identify"

@interface AppiontmentHomeViewController ()

@property(strong,nonatomic)NSMutableArray *userArray;

@end

@implementation AppiontmentHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.userArray=[[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated {
    /* 加载数据 */
    
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
    
    NSArray  *result=[[SQLManager shareManager]load];
    
    [_userArray setArray:result];
    
    [_tableview reloadData];
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
   
   
    
    contentCell *conCell=[_tableview dequeueReusableCellWithIdentifier:IDENTIFY];
    
    if(conCell==nil){
    conCell=[[[NSBundle mainBundle]loadNibNamed:@"contentCell" owner:self options:nil] lastObject];
    }

    // Configure the cell...
   
        UserModel *model=[self.userArray objectAtIndex:indexPath.row];
      
        conCell.name.text=model.userName;
        conCell.starttime.text=model.time;
        conCell.place.text=model.place;
        conCell.machineType.text=model.machineType;
        conCell.machineID.text=model.machineId;
    
    
    return conCell;
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UserModel *model=[[UserModel alloc]init];
        
        NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        model.idUserNumber=stringInt;
        
        [[SQLManager shareManager]deleteData:model];
        
        NSLog(@"执行删除");
        
        NSArray  *result=[[SQLManager shareManager]reloadData:model];
        
        
        [_userArray setArray:result];
        
        [_tableview reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
//移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *tem=[_userArray objectAtIndex:fromIndexPath.row];
    [_userArray removeObject:tem];
    [_userArray insertObject:tem atIndex:toIndexPath.row];
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(IBAction)addUserDone:(UIStoryboardSegue *)sender
{
    UserModel *model=[[UserModel alloc]init];
    
    NSArray  *result=[[SQLManager shareManager]reloadData:model];
    
    
    [_userArray setArray:result];
    
    [_tableview reloadData];
    
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
