//
//  PanoromaViewWidget.m
//  TestProjectGeneralPurpose
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 Vignesh Shiva. All rights reserved.
//

#import "LFPanoramaViewWidget.h"
#import "SwipeView.h"

@interface LFPanoramaViewWidget()<SwipeViewDelegate,SwipeViewDataSource>

@property (nonatomic, strong) SwipeView *swipeView;
@property (nonatomic) NSArray *viewsArray;

@end

@implementation LFPanoramaViewWidget

-(instancetype)initWithFrame:(CGRect)frame andViewsArray:(NSArray *)viewsArray
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self configureSwipeView];
        self.viewsArray = viewsArray;
        [self addSubview:self.swipeView];
    }
    return self;
}

-(void)configureSwipeView
{
    self.swipeView = [[SwipeView alloc]initWithFrame:self.bounds];
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
    self.swipeView.alignment = SwipeViewAlignmentEdge;
    self.swipeView.pagingEnabled = YES;
    self.swipeView.wrapEnabled = NO;
}

- (NSInteger)numberOfItemsInSwipeView:(__unused SwipeView *)swipeView
{
    return [self.viewsArray count];
}

- (UIView *)swipeView:(__unused SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    //return view
    return self.viewsArray[index];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
