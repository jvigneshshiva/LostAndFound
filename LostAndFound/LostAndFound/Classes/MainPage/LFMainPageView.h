//
//  LFMainPageView.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFMainPageViewProtocol <NSObject>

-(void)submitChatMessage:(NSString *)chatMessage;
-(void)chatSelectedWithUserId:(NSString *)userId;
-(void)postMadeTitle:(NSString *)postTitle andDescription:(NSString *)descriptionString;
-(void)fetchItemDataInfo;

@end

@interface LFMainPageView : UIView

@property (nonatomic) id<LFMainPageViewProtocol> mainPageViewDelegate;
-(void)configureItemListWith:(NSArray *)array;
-(void)configureChatWith:(NSArray *)array;

@end
