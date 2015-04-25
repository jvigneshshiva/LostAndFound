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
#import "LFChatPageView.h"

#import "UIView+XIB.h"

@interface LFMainPageView()

@property (weak, nonatomic) IBOutlet UIView *panoramaViewHolder;
@property (weak, nonatomic) IBOutlet UIView *pageViewHolder;

@property (nonatomic) LFItemsListPageView *itemsListPageView;
@property (nonatomic) LFChatPageView *chatPageView;
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
    [self configurePageOne];
    [self configurePageTwo];
    self.panoramaView = [[LFPanoramaViewWidget alloc]initWithFrame:self.panoramaViewHolder.frame andViewsArray:@[self.pageOne,self.pageTwo]];

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
    self.itemsListPageView = [[LFItemsListPageView alloc]initWithFrame:[self.pageOne detailViewBounds]];
    [self.itemsListPageView  configureItemListWith:@[itemDictionary,itemDictionary,itemDictionary,itemDictionary,itemDictionary]];
    [self.pageOne addSubviewToDetailView:self.itemsListPageView];
}

-(void)configurePageTwo
{
    self.pageTwo = [[LFPanoramaViewWidgetPage alloc]initWithFrame:self.pageViewHolder.frame];
    [self.pageTwo setHeadingToView:@"Chat"];
    NSDictionary *chatMessage = @{
                                     @"userName" : @"Vignesh",
                                     @"message" : @"HIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIII",
                                     @"hasUserSentThisMessage" : @(NO)
                                     };
    NSDictionary *chatMessage1 = @{
                                  @"userName" : @"Shiva",
                                  @"message" : @"HIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIIIHIIII",
                                  @"hasUserSentThisMessage" : @(YES)
                                  };
    self.chatPageView = [[LFChatPageView alloc]initWithFrame:[self.pageOne detailViewBounds]];
    [self.chatPageView  configureChatMessages:@[chatMessage,chatMessage1,chatMessage,chatMessage1,chatMessage]];
    [self.pageTwo addSubviewToDetailView:self.chatPageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
