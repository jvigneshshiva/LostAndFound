//
//  LFPhoneNumberRegistrationView.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFPhoneNumberRegistrationViewProtocol <NSObject>

-(void)signupSuccessful;
-(void)submitPhoneNumberWith:(NSString *)phoneNumber;


@end

@interface LFPhoneNumberRegistrationView : UIView

@property (nonatomic) id<LFPhoneNumberRegistrationViewProtocol> phoneNumberRegistrationViewDelegate;

@property (nonatomic) NSString *verificationCode;

@end
