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

@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSelection;

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
                                     @"name" : self.fullNameTextField.text,
                                     @"email" : self.emailTextField.text,
                                     @"sex" : @(self.genderSelection.selectedSegmentIndex)
                                     };
        [self.loginPageViewDelegate userDataSubmittedWithDictionary:dictionary];
    }
    else
    {
        self.infoLabel.text = NSLocalizedString(@"Form Incomplete", @"Form Info Text");
    }
}

-(BOOL)isFormComplete
{
    if([self.fullNameTextField.text isEqualToString:@""] || [self.emailTextField.text isEqualToString:@""])
    {
        return NO;
    }
    else if(self.fullNameTextField.text == nil || self.emailTextField.text == nil)
    {
        return NO;
    }

    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
