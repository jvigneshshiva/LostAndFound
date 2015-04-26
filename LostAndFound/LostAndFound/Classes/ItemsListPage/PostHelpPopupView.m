//
//  PostHelpPopupView.m
//  LostAndFound
//
//  Created by Subbhaash on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "PostHelpPopupView.h"
#import "UIView+XIB.h"

@interface PostHelpPopupView()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation PostHelpPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubViewWithXibName:@"PostHelpPopupView" andFrame:self.bounds];
    }
    return self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField // this method get called when you tap "Go"
{
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

-(IBAction)postButtonClicked
{
    [self.postHelpPopupDelegate postMadeTitle:self.titleTextField.text andDescription:self.descriptionTextView.text];
    
}

-(IBAction)backButtonClicked
{
    [self.postHelpPopupDelegate postHelpPopupClosed];
}

@end
