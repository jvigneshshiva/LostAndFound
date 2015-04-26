//
//  LFServerHelper.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFServerHelper.h"
#import "ApURLConnection.h"

typedef enum
{
    CHAT_GET_URL_CONNECTION_TAG,
    CHAT_SEND_URL_CONNECTION_TAG,
    ITEM_LIST_DATA_FETCH_URL_CONNECTION_TAG,
    USERDATA_SUBMISSION_URL_CONNECTION_TAG,
    PHONE_NUMBER_SUBMIT_URL_CONNECTION_TAG,
    POSTDATA_SUBMISSION_URL_CONNECTION_TAG
}URL_CONNECTION_TYPE;

#define CHAT_FETCH_URL @"https://dynamic-chiller-92609.appspot.com/hack?"
#define ITEM_LIST_DATA_FETCH @"https://dynamic-chiller-92609.appspot.com/hack?"
#define PHONE_NUMBER_SUBMIT_URL @"https://dynamic-chiller-92609.appspot.com/hack?"
#define USERDATA_SUBMISSION_URL @"https://dynamic-chiller-92609.appspot.com/hack?"
#define POSTDATA_SUBMISSION_URL @"https://dynamic-chiller-92609.appspot.com/hack?"

@implementation LFServerHelper

+(LFServerHelper *)sharedServerHelper
{
    static LFServerHelper * sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[LFServerHelper alloc]init];
    }
    return sharedInstance;
}


-(void)connectionSuccessful:(ApURLConnection *)apURLConnection withString:(NSString *)str withData:(NSData *)data
{
    switch (apURLConnection.tag) {
        case CHAT_GET_URL_CONNECTION_TAG:
            
            break;
            
        case CHAT_SEND_URL_CONNECTION_TAG:
            
            break;
            
        case ITEM_LIST_DATA_FETCH_URL_CONNECTION_TAG:
            [self.serverHelperDelegate verificationCodeReceived:str];

            break;
            
        case USERDATA_SUBMISSION_URL_CONNECTION_TAG:
            [self.serverHelperDelegate userDataSavedSuccessFully];
            break;
            
        case PHONE_NUMBER_SUBMIT_URL_CONNECTION_TAG:
            [self.serverHelperDelegate verificationCodeReceived:str];
            break;
            
        case POSTDATA_SUBMISSION_URL_CONNECTION_TAG:
            break;
            
        default:
            break;
    }
    
}

-(void)fetchChatData
{
    /*
    
    NSMutableString *postParameter = [NSMutableString stringWithFormat:@"%@", @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"message"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&command="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"20put"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&fromUserId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", senderID]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&toUserId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", receiverID]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&text="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", message]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&messageType="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"0"]]; */
}

-(void)submitUserDataWithDictionary:(NSDictionary *)dictionary
{
    
    NSMutableString *postParameter = [NSMutableString stringWithFormat:@"%@", @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@",@"userRegistration"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&name="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", dictionary[@"name"]]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&phoneNumber="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", dictionary[@"phoneNumber"]]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&email="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", dictionary[@"email"]]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&sex="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", dictionary[@"sex"]]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&imageURL="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"imageURL"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&pushNotificationId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"xx"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&userOS="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"1"]];
    ApURLConnection *userDataSubmissionURLConnection =[[ApURLConnection alloc]  initWithURL:USERDATA_SUBMISSION_URL withDelegate:self withOnlyCheck:FALSE withData:postParameter];
    userDataSubmissionURLConnection.tag = USERDATA_SUBMISSION_URL_CONNECTION_TAG;

}

-(void)fetchChatFromUser:(NSString *)senderID toUser:(NSString *)receiverID
{
    
    NSMutableString *postParameter = [NSMutableString stringWithFormat:@"%@", @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"message"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&command="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"get"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&fromUserId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", senderID]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&toUserId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", receiverID]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&messageType="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"0"]];
    ApURLConnection *fetchChatURLConnection =[[ApURLConnection alloc]  initWithURL:CHAT_FETCH_URL withDelegate:self withOnlyCheck:FALSE withData:postParameter];
    fetchChatURLConnection.tag = CHAT_GET_URL_CONNECTION_TAG;
}

-(void)submitPhoneNumberWith:(NSString *)phoneNumber
{
    NSMutableString *postParameter = [NSMutableString stringWithFormat:@"%@", @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"sendVerificationCode"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&phoneNumber="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", phoneNumber]];
    ApURLConnection *phoneNumberSubmissionURLConnection =[[ApURLConnection alloc]  initWithURL:PHONE_NUMBER_SUBMIT_URL withDelegate:self withOnlyCheck:FALSE withData:postParameter];
    phoneNumberSubmissionURLConnection.tag = PHONE_NUMBER_SUBMIT_URL_CONNECTION_TAG;
}

-(void)postMadeTitle:(NSString *)postTitle andDescription:(NSString *)descriptionString
{
    
    NSMutableString *postParameter = [NSMutableString stringWithFormat:@"%@", @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"serviceRequest"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&command="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"put"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&name="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", postTitle]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&description="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", descriptionString]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&categoryId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"12"]];
    
    ApURLConnection *phoneNumberSubmissionURLConnection =[[ApURLConnection alloc]  initWithURL:POSTDATA_SUBMISSION_URL withDelegate:self withOnlyCheck:FALSE withData:postParameter];
    phoneNumberSubmissionURLConnection.tag = POSTDATA_SUBMISSION_URL_CONNECTION_TAG;
}

-(void)fetchItemData
{
    //https://dynamic-chiller-92609.appspot.com/hack?txType=serviceRequest&command=get&categoryId=12
    NSString *categoryId = nil;//hack
    NSMutableString *postParameter = [NSMutableString stringWithString: @"txType="];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"serviceRequest"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&command="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"get"]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", @"&categoryId="]];
    [postParameter appendString:[NSString stringWithFormat:@"%@", categoryId]];
    ApURLConnection *itemFetchConnection =[[ApURLConnection alloc]  initWithURL:POSTDATA_SUBMISSION_URL withDelegate:self withOnlyCheck:FALSE withData:postParameter];
    itemFetchConnection.tag = ITEM_LIST_DATA_FETCH_URL_CONNECTION_TAG;
}


-(void)connectionFailed:(ApURLConnection *)apURLconnection
{
    
}

@end
