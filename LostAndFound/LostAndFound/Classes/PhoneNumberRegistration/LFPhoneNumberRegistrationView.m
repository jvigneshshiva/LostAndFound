//
//  LFPhoneNumberRegistrationView.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFPhoneNumberRegistrationView.h"
#import "UIView+XIB.h"

@interface LFPhoneNumberRegistrationView()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextBox;
@property (weak, nonatomic) IBOutlet UITextField *verficationCodeTextBox;

@property (nonatomic) NSString *phoneNumberText;

@end

@implementation LFPhoneNumberRegistrationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
    }
    return self;
}

- (IBAction)phoneNumberSubmitted
{
    if([self canPhoneNumberBeSubmitted])
    {
        self.phoneNumberText = self.phoneNumberTextBox.text;
        [self.phoneNumberRegistrationViewDelegate submitPhoneNumberWith:self.phoneNumberTextBox.text];
    }
}

-(BOOL)canPhoneNumberBeSubmitted
{
    if([self.phoneNumberTextBox.text isEqualToString:@""])
    {
        return NO;
    }
    else if(self.phoneNumberTextBox.text == nil)
    {
        return NO;
    }
    return YES;
}

-(IBAction)verificationCodeSubmitted
{
    if([self canVerificationCodeSubmitted] == YES)
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.phoneNumberText forKey:@"phoneNumber"];
        [self.phoneNumberRegistrationViewDelegate signupSuccessful];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wrong Code" message:@"Retry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

-(BOOL)canVerificationCodeSubmitted
{

    if([self.verificationCode isEqualToString:self.verficationCodeTextBox.text] && self.verificationCode != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
