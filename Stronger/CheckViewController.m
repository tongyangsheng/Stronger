//
//  CheckViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/10/24.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableview.delegate=self;
    
    _tableview.dataSource=self;
    
    _tableview.frame=CGRectMake(0, 500, 415, 375);
    
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellStr=@"cell";
    
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:cellStr];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSArray* myArray=@[@"主要体征",@"身体测量",@"健身记录",@"每日健身",@"数据中心"];
    
    NSString* str=[myArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=str;
    
    NSString* stt =[NSString stringWithFormat:@"小-%ld.png",indexPath.row % 5+1];
    
    UIImage* image=[UIImage imageNamed:stt];
    
    //UIImageView* iView=[[UIImageView alloc] initWithImage:image];
    
    cell.imageView.image=image;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
