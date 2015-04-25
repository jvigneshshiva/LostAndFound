//
//  ViewController.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFViewController.h"
#import "LFMainPageView.h"

@interface LFViewController ()

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFMainPageView *mainPage = [[LFMainPageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mainPage];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
