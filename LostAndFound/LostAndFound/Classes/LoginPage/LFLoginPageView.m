//
//  LFLoginPageView.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFLoginPageView.h"
#import "UIView+XIB.h"

@interface LFLoginPageView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end

@implementation LFLoginPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
    }
    return self;
    
}


- (IBAction)submitButtonPressed
{
    if([self isFormComplete])
    {
        NSDictionary *dictionary = @{
                                     @"fullName" : self.fullNameTextField.text,
                                     @"userName" : self.userNameTextField.text,
                                     @"email" : self.emailTextField.text
                                     };
    }
    else
    {
        self.infoLabel.text = NSLocalizedString(@"Form Incomplete Text", @"Form Info Text");
    }
}

-(BOOL)isFormComplete
{
    if(self.fullNameTextField.text && self.emailTextField.text && self.userNameTextField)
    {
        return YES;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
