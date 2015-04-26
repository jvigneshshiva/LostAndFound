//
//  ViewController.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFViewController.h"
#import "LFMainPageView.h"
#import "LFMainPagView1.h"
#import "LFLoginPageView.h"
#import "LFServerHelper.h"
#import "LFPhoneNumberRegistrationView.h"
#import "UIView+XIB.h"
#import "NSString+JSON.h"

@interface LFViewController () <LFLoginPageViewProtocol,LFPhoneNumberRegistrationViewProtocol,LFMainPageViewProtocol, LFServerHelperProtocol, LFMainPagView1Protocol>

@property (nonatomic) LFServerHelper *serverHelper;

@property (nonatomic) LFLoginPageView *logInPage;
@property (nonatomic) LFMainPageView *mainPage;
@property (nonatomic) LFMainPagView1 *mainPage1;
@property (nonatomic) LFPhoneNumberRegistrationView *phoneNumberRegistrationPage;

@property (nonatomic) NSArray *allCategoriesArray;
@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *receiverId;


@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverHelper = [LFServerHelper sharedServerHelper];
    self.serverHelper.serverHelperDelegate = self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];

    if([[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"] == nil)
    {
        [self showPhoneNumberRegistrationPage];
    }
    else if([[NSUserDefaults standardUserDefaults]boolForKey:@"userDataStoredSuccessfully"] == NO)
    {
        [self showLogInPage];
    }
    else
    {
        [self showMainPage1];
    }
    [self fetchAllCategories];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchAllCategories
{
    [self.serverHelper fetchAllCategories];
}

-(void)showLogInPage
{
    self.logInPage = [[LFLoginPageView alloc]initWithFrame:self.view.frame];
    self.logInPage.loginPageViewDelegate = self;
    [self.view addSubview:self.logInPage];
    
}

-(void)showMainPage
{
    self.mainPage = [[LFMainPageView alloc]initWithFrame:self.view.frame];
    self.mainPage.mainPageViewDelegate = self;
    [self.view addSubview:self.mainPage];
}

-(void)showMainPage1
{
    self.mainPage1 = [[LFMainPagView1 alloc]initWithFrame:self.view.frame andCategoryInfoArray:self.allCategoriesArray];
    self.mainPage1.delegate = self;
    [self.view addSubview:self.mainPage1];
}

-(void)showPhoneNumberRegistrationPage
{
    self.phoneNumberRegistrationPage = [[LFPhoneNumberRegistrationView alloc]initWithFrame:self.view.frame];
    self.phoneNumberRegistrationPage.phoneNumberRegistrationViewDelegate = self;
    [self.view addSubview:self.phoneNumberRegistrationPage];
}

-(void)userDataSubmittedWithDictionary:(NSDictionary *)dictionary
{
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    NSMutableDictionary *userDataDictionary = [dictionary mutableCopy];
    userDataDictionary[@"phoneNumber"] = phoneNumber;
    [self.serverHelper submitUserDataWithDictionary:userDataDictionary];
    [self userDataSavedSuccessFully];

}

-(void)submitChatMessage:(NSString *)chatMessage
{
    NSString *senderId = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    [self.serverHelper submitChatMessage:chatMessage receiverId:self.receiverId andSenderId:senderId];
}

-(void)chatSubmittedSuccesfully
{
    [self chatSelectedWithUserId:self.receiverId];
}

-(void)chatDataReceived:(NSString *)str;
{
    NSDictionary *dictionary = [str jsonValue];
    NSString *receiverId = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    NSArray *chatArray = dictionary[@"allMessages"];
    NSMutableArray *chatInfoArray = [NSMutableArray array];
    for(NSDictionary *someDictionary in chatArray)
    {
        NSMutableDictionary *chatInfoDictionary = [someDictionary mutableCopy];
        if([someDictionary[@"fromId"] isEqualToString:receiverId])
        {
            chatInfoDictionary[@"hasUserSentThisMessage"] = @(YES);
        }
        [chatInfoArray addObject:chatInfoDictionary];
    }
}

-(void)chatSelectedWithUserId:(NSString *)userId
{
    NSString *receiverId = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    self.receiverId = userId;
    [self.serverHelper fetchChatFromUser:userId toUser:receiverId];

}

-(void)submitPhoneNumberWith:(NSString *)phoneNumber
{
    [self.serverHelper submitPhoneNumberWith:phoneNumber];
}

-(void)verificationCodeReceived:(NSString *)verificationCode
{
    self.phoneNumberRegistrationPage.verificationCode = verificationCode;
}

-(void)fetchItemDataInfoForCategoryId:(NSString *)categoryId
{
    [self.serverHelper fetchItemDataInfoForCategoryId:categoryId];
}

-(void)fetchItemDataInfo
{
    [self fetchItemDataInfoForCategoryId:self.categoryId];
}


-(void)itemListReceived:(NSString *)str
{
    NSDictionary *dictionary = [str jsonValue];
    [self.mainPage configureItemListWith:dictionary[@"allServiceItems"]];
}

-(void)signupSuccessful
{
    [self.phoneNumberRegistrationPage removeFromSuperview];
    self.phoneNumberRegistrationPage = nil;
    [self showLogInPage];
}

-(void)userDataSavedSuccessFully
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"userDataStoredSuccessfully"];
    [self.logInPage removeFromSuperview];
    self.logInPage = nil;
    [self showMainPage1];
}

-(void)postMadeTitle:(NSString *)postTitle andDescription:(NSString *)descriptionString
{
    [self.serverHelper postMadeTitle:postTitle andDescription:descriptionString andCategoryId:self.categoryId];
}

-(void)allCategoriesFetched:(NSString *)str
{
    NSDictionary *dictionary = [str jsonValue];
    self.allCategoriesArray = dictionary[@"allCategoryItems"];
    [self.mainPage1 configureWithArray:self.allCategoriesArray];
}

-(void)cellClicked:(NSString *)categoryName
{
    self.categoryId = categoryName;
    [self closeMainPage1];
    [self showMainPage];
}

-(void)closeMainPage1
{
    [self.mainPage1 removeFromSuperview];
    self.mainPage1 = nil;
}

-(void)backButtonClicked
{
    [self.mainPage removeFromSuperview];
    self.mainPage = nil;
    [self showMainPage1];
    
}

@end
