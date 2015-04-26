//
//  PostHelpPopupView.h
//  LostAndFound
//
//  Created by Subbhaash on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostHelpPopupViewProtocol <NSObject>

-(void)postMadeTitle:(NSString *)postTitle andDescription:(NSString *)descriptionString;
-(void)postHelpPopupClosed;

@end

@interface PostHelpPopupView : UIView

@property (nonatomic) id<PostHelpPopupViewProtocol> postHelpPopupDelegate;

@end
