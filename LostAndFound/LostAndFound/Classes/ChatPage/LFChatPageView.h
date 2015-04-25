//
//  LFChatPageView.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFChatPageViewProtocol <NSObject>

-(void)submitChatMessage:(NSString *)chatMessage;

@end

@interface LFChatPageView : UIView

-(void)configureChatMessages:(NSArray *)chatMessagesArray;
@property (nonatomic) id<LFChatPageViewProtocol> chatPageViewDelegate;

@end
