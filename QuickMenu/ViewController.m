//
//  ViewController.m
//  QuickMenu
//
//  Created by Marlon on 16/1/28.
//  Copyright © 2016年 superman. All rights reserved.
//

#import "ViewController.h"
#import "QuickNavigationBar.h"

@interface ViewController ()<QuickNavigationBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuickNavigationBar *bar = [[QuickNavigationBar alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    bar.delegate = self;
    
    [bar addSubPath:@"长江e家"];
    [bar addSubPath:@"ewqeqweqwiii"];

    [bar addSubPath:@"iOS开发组－两个人"];
    [bar addSubPath:@"iOS开发组－冷豫蕲"];

    
    [self.view addSubview:bar];
    
}

- (void)didClickButton:(NSInteger)index{

    
    NSLog(@"index = %ld",index);
    
//    进行跳转界面操作
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
