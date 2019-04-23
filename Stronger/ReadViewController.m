//
//  ReadViewController.m
//  Stronger
//
//  Created by 童阳升 on 2017/10/24.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView* sv=[[UIScrollView alloc]init];
    
    sv.frame=CGRectMake(0, 93, 415, 200);
    
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
        NSString* strName=[NSString stringWithFormat:@"直播%d.png",i+1];
        
        UIImage* image=[UIImage imageNamed:strName];
        
        UIImageView* iView=[[UIImageView alloc]initWithImage:image];
        
        iView.frame=CGRectMake(415*i, 0, 415, 200);
        
        [sv addSubview:iView];
    }
    
    [self.view addSubview:sv];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
