//
//  ViewController.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFViewController.h"
#import "LFMainPageView.h"
#import "LFLoginPageView.h"
#import "LFServerHelper.h"
#import "UIView+XIB.h"

@interface LFViewController () <LFLoginPageViewProtocol>

@property (nonatomic) LFServerHelper *serverHelper;

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverHelper = [LFServerHelper sharedServerHelper];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [self showLogInPage];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLogInPage
{
    LFLoginPageView *logInPage = [[LFLoginPageView alloc]initWithFrame:self.view.frame];
    logInPage.loginPageViewDelegate = self;
//    [self.view addSubview:logInPage];
    [self.view addSubViewWithXibName:@"ItemStateView" andFrame:CGRectMake(0, 15, 320, 450)];
}

-(void)showMainPage
{
    LFMainPageView *mainPage = [[LFMainPageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mainPage];
}

-(void)userDataSubmittedWithDictionary:(NSDictionary *)dictionary
{
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    NSMutableDictionary *userDataDictionary = [dictionary mutableCopy];
    userDataDictionary[@"phoneNumber"] = phoneNumber;

}

-(void)submitChatMessage:(NSString *)chatMessage
{
    
}

-(void)chatSelectedWithUserId:(NSString *)userId
{
    
}



@end
