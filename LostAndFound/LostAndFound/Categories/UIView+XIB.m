//
//  UIView+XIB.m
//  TestProjectGeneralPurpose
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 Vignesh Shiva. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

-(void)addSubViewWithXibName:(NSString *)xibName andFrame:(CGRect)frame
{
    [self addSubview:[self viewWithXibName:xibName andFrame:frame]];
}

-(UIView *)viewWithXibName:(NSString *)xibName andFrame:(CGRect)frame
{
    UIView* xibView = [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] objectAtIndex:0];
    if(CGRectEqualToRect(frame, CGRectZero) == FALSE)
    {
        xibView.frame = frame;
    }
    return xibView;
}

@end
