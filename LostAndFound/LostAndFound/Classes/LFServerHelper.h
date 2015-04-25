//
//  LFServerHelper.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFServerHelperProtocol <NSObject>

-(void)verificationCodeReceived:(NSString *)verificationCode;
-(void)userDataSavedSuccessFully;


@end

@interface LFServerHelper : NSObject

+(LFServerHelper *)sharedServerHelper;

-(void)fetchChatFromUser:(NSString *)senderID toUser:(NSString *)receiverID;
-(void)submitUserDataWithDictionary:(NSDictionary *)dictionary;
-(void)submitPhoneNumberWith:(NSString *)phoneNumber;

@property (nonatomic) id<LFServerHelperProtocol> serverHelperDelegate;

@end
