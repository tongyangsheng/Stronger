//
//  HomeViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/10/24.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView* sv=[[UIScrollView alloc]init];
    
    sv.frame=CGRectMake(0, 92, 415, 200);
    
    sv.pagingEnabled=YES;
    sv.scrollEnabled=YES;
    sv.contentSize=CGSizeMake(415*2, 200);
    sv.bounces=YES;
    sv.alwaysBounceHorizontal=YES;
    sv.alwaysBounceVertical=NO;
    sv.showsVerticalScrollIndicator=YES;
    sv.showsVerticalScrollIndicator=YES;
    
    sv.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<2; i++) {
        NSString* strName=[NSString stringWithFormat:@"%d.jpg",i+1];
        
        UIImage* image=[UIImage imageNamed:strName];
        
        UIImageView* iView=[[UIImageView alloc]initWithImage:image];
        
        iView.frame=CGRectMake(415*i, 0, 415, 200);
        
        [sv addSubview:iView];
    }
    
    [self.view addSubview:sv];
    
    _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //数据视图代理对象以及数据源
    _tableview.delegate=self;
    _tableview.dataSource=self;
   
    _tableview.frame=CGRectMake(0, 400, 415, 300);
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self.view addSubview:_tableview];
    
    
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellStr=@"cell";
    
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:cellStr];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    NSArray* myArray=@[@"氧适堡健身房",@"优+健身房",@"飞特健身房",@"周一健身房",@"韬博健身房"];
    NSArray* myArray2=@[@"评分：🌟🌟🌟🌟",@"评分：🌟🌟🌟🌟🌟",@"评分：🌟🌟🌟",@"评分：🌟🌟🌟🌟",@"评分：🌟🌟🌟🌟🌟"];
    NSString* str=[myArray objectAtIndex:indexPath.row];
    NSString* str2=[myArray2 objectAtIndex:indexPath.row];
    
    cell.textLabel.text=str;
    cell.detailTextLabel.text=str2;
    
    NSString* stt =[NSString stringWithFormat:@"%ld-1.png",indexPath.row % 5+1];
    
    UIImage* image=[UIImage imageNamed:stt];
    
    //UIImageView* iView=[[UIImageView alloc] initWithImage:image];
    
    cell.imageView.image=image;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
