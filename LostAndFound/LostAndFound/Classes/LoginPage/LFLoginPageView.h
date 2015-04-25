//
//  LFLoginPageView.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFLoginPageViewProtocol <NSObject>

-(void)userDataSubmittedWithDictionary:(NSDictionary *)dictionary;

@end

@interface LFLoginPageView : UIView

@property (nonatomic) id<LFLoginPageViewProtocol> loginPageViewDelegate;

@end
