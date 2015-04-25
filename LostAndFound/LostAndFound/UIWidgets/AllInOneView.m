//
//  AllInOneView.m
//  AllInOneView
//
//  Created by Subbhaash on 9/12/14.
//  Copyright (c) 2014 Subbhaash. All rights reserved.
//

#import "AllInOneView.h"
#define TEXTURE_VIEW_TAG 1234567890

@interface AllInOneView ()

@property (retain, nonatomic) NSMutableArray *colorsArray;

@end

@implementation AllInOneView

- (id)initWithFrame:(CGRect)frame cornerRadius:(int)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(int)borderWidth patternImageName:(NSString *)patternImageName andColors:(NSArray *)colorsArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBorderColor:borderColor withBorderWidth:borderWidth];
        [self setGradientColorsArray:colorsArray];
        [self setPatternImageName:patternImageName];
        [self setCornerRadius:cornerRadius];
    }
    return self;
}

-(void)setCornerRadius:(int)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

-(void)setGradientColorsArray:(NSArray *)gradientColorsArray
{
    if(gradientColorsArray.count > 1)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addGradientLayerToView:self withColorArray:gradientColorsArray locationsArray:nil atFrame:self.bounds];
    }
}

-(NSMutableArray *)colorsArray
{
    if(_colorsArray == nil)
    {
        _colorsArray = [[NSMutableArray alloc]init];
    }
    return _colorsArray;
}

-(void)setGradientColor:(UIColor *)gradientColor
{
    [self addGradientColor:gradientColor];
}

-(void)addGradientColor:(UIColor *)gradientColor
{
    if(gradientColor != nil)
    {
        [self.colorsArray addObject:(id)gradientColor.CGColor];
    }
}

-(void)setGradientView:(BOOL)identifier
{
    [[self viewWithTag:TEXTURE_VIEW_TAG]removeFromSuperview];
    NSArray *layersArray = [self.layer.sublayers copy];
    for(CALayer * layer in layersArray)
    {
        if([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    [self addGradientLayerToView:self withColorArray:self.colorsArray locationsArray:nil atFrame:self.bounds];
}

-(void) addGradientLayerToView: (UIView *)view withColorArray:(NSArray *) colorArray locationsArray:(NSArray *)locationsArray atFrame:(CGRect) frame
{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = frame;
    gradientLayer.colors = colorArray;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    if((borderColor == nil || borderColor == [UIColor clearColor]) == FALSE)
    {
        self.layer.borderColor = borderColor.CGColor;
    }
}

-(void)setBorderColor:(UIColor *)borderColor withBorderWidth:(int)borderWith
{
    [self setBorderColor:borderColor];
    self.layer.borderWidth = borderWith;
}

-(void)setPatternImageName:(NSString *)patternImageName
{
    if(patternImageName != nil)
    {
        UIImage *patternImage = [UIImage imageNamed:patternImageName];
        if(patternImage != nil)
        {
            [self setPatternImage:patternImage];
        }
    }
}

-(void)setPatternImage:(UIImage *)patternImage
{
    UIView *textureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    textureView.tag = TEXTURE_VIEW_TAG;
    [textureView setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [self insertSubview:textureView atIndex:1];
    textureView = nil;
}

@end
