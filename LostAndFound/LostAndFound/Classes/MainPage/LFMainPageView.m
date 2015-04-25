//
//  LFMainPageView.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFMainPageView.h"
#import "LFPanoramaViewWidget.h"
#import "LFPanoramaViewWidgetPage.h"
#import "LFItemsListPageView.h"

#import "UIView+XIB.h"

@interface LFMainPageView()

@property (weak, nonatomic) IBOutlet UIView *panoramaViewHolder;
@property (weak, nonatomic) IBOutlet UIView *pageViewHolder;

@property (nonatomic) LFItemsListPageView *itemsListPageView;
@property (nonatomic) LFPanoramaViewWidget *panoramaView;
@property (nonatomic) LFPanoramaViewWidgetPage *pageOne;
@property (nonatomic) LFPanoramaViewWidgetPage *pageTwo;
@property (nonatomic) LFPanoramaViewWidgetPage *pageThree;

@end

@implementation LFMainPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
        [self configurePanoramaView];
    }
    return self;
    
}


-(void)configurePanoramaView
{
    self.panoramaView = [[LFPanoramaViewWidget alloc]initWithFrame:self.panoramaViewHolder.frame andViewsArray:@[self.pageOne]];
    [self addSubview:self.panoramaView];
}

-(void)configurePageOne
{
    self.pageOne = [[LFPanoramaViewWidgetPage alloc]initWithFrame:self.pageViewHolder.frame];
    [self.pageOne setHeadingToView:@"News"];
    NSDictionary *itemDictionary = @{
                                     @"name" : @"Vignesh",
                                     @"itemStatus" : @"found",
                                     @"itemName" : @"Ring",
                                     @"location" : @"bangalore"
                                     };
    self.itemsListPageView = [[LFItemsListPageView alloc]initWithFrame:self.pageOne.frame];
    [self.itemsListPageView  configureItemListWith:@[itemDictionary,itemDictionary,itemDictionary,itemDictionary,itemDictionary]];
    [self.pageOne addSubviewToDetailView:self.itemsListPageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
