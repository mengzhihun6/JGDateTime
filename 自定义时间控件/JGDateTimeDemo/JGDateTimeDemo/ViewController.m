//
//  ViewController.m
//  JGDateTimeDemo
//
//  Created by stkcctv on 16/12/23.
//  Copyright © 2016年 JG. All rights reserved.
//

#import "ViewController.h"
#import "FDAlertView.h"
#import "RBCustomDatePickerView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

-(void)btnClick
{
    FDAlertView *alert = [[FDAlertView alloc] init];
    RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    contentView.delegate=self;
    alert.contentView = contentView;
    [alert show];
    
}


-(void)getTimeToValue:(NSString *)theTimeStr
{
    NSLog(@"我获取到时间了，时间是===%@",theTimeStr);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
