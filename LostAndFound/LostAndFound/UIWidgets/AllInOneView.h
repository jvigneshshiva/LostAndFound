//
//  AllInOneView.h
//  AllInOneView
//
//  Created by Subbhaash on 9/12/14.
//  Copyright (c) 2014 Subbhaash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllInOneView : UIView

- (id)initWithFrame:(CGRect)frame cornerRadius:(int)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(int)borderWidth patternImageName:(NSString *)patternImageName andColors:(NSArray *)colorsArray;
-(void)setPatternImageName:(NSString *)patternImageName;
-(void)setBorderColor:(UIColor *)borderColor;
-(void)setGradientColor:(UIColor *)gradientColor;
-(void)setGradientColorsArray:(NSArray *)gradientColorsArray;
-(void)setGradientView:(BOOL)identifier;

@end
