//
//  LFPanoramaViewWidgetPage.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFPanoramaViewWidgetPage.h"
#import "UIView+XIB.h"


@interface LFPanoramaViewWidgetPage()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end

@implementation LFPanoramaViewWidgetPage


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];

    }
    return self;
}

-(void)setHeadingToView:(NSString *)heading
{
    self.headerLabel.text = NSLocalizedString(heading, @"Heading for Page");
}

-(void)addSubviewToDetailView:(UIView *)subview
{
    [self.detailView addSubview:subview];
}

-(CGRect)detailViewBounds
{
    return self.detailView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
