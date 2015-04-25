//
//  LFServerHelper.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFServerHelper : NSObject

+(LFServerHelper *)sharedServerHelper;


-(void)fetchChatFromUser:(NSString *)senderID toUser:(NSString *)receiverID;
-(void)submitUserDataWithDictionary:(NSDictionary *)dictionary;




@end
