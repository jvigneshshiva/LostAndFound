//
//  LFPanoramaViewWidgetPage.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPanoramaViewWidgetPage : UIView

-(void)setHeadingToView:(NSString *)heading;
-(void)addSubviewToDetailView:(UIView *)subview;
-(CGRect)detailViewBounds;


@end
