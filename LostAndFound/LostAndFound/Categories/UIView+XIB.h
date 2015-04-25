//
//  UIView+XIB.h
//  TestProjectGeneralPurpose
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 Vignesh Shiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIB)

-(void)addSubViewWithXibName:(NSString *)xibName andFrame:(CGRect)frame;
-(UIView *)viewWithXibName:(NSString *)xibName andFrame:(CGRect)frame;;

@end
