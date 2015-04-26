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
#import "PostHelpPopupView.h"

#import "UIView+XIB.h"

@interface LFMainPageView()<LFChatPageViewProtocol>

@property (weak, nonatomic) IBOutlet UIView *panoramaViewHolder;
@property (weak, nonatomic) IBOutlet UIView *pageViewHolder;

@property (nonatomic) LFItemsListPageView *itemsListPageView;
@property (nonatomic) LFChatPageView *chatPageView;
@property (nonatomic) LFPanoramaViewWidget *panoramaView;
@property (nonatomic) LFPanoramaViewWidgetPage *pageOne;
@property (nonatomic) LFPanoramaViewWidgetPage *pageTwo;
@property (nonatomic) LFPanoramaViewWidgetPage *pageThree;
@property (nonatomic) PostHelpPopupView *postHelpPopupView;

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
    [self.mainPageViewDelegate fetchItemDataInfo];
    self.itemsListPageView = [[LFItemsListPageView alloc]initWithFrame:[self.pageOne detailViewBounds]];
    [self.itemsListPageView  configureItemListWith:nil];
    [self.pageOne addSubviewToDetailView:self.itemsListPageView];
}

-(void)configurePageTwo
{
    self.pageTwo = [[LFPanoramaViewWidgetPage alloc]initWithFrame:self.pageViewHolder.frame];
    [self.pageTwo setHeadingToView:@"Chat"];
    self.chatPageView = [[LFChatPageView alloc]initWithFrame:[self.pageOne detailViewBounds]];
    self.chatPageView.chatPageViewDelegate = self;
    [self.chatPageView  configureChatMessages:nil];
    [self.pageTwo addSubviewToDetailView:self.chatPageView];
}

-(void)submitChatMessage:(NSString *)chatMessage
{
    [self.mainPageViewDelegate submitChatMessage:chatMessage];
}

-(void)chatSelectedWithUserId:(NSString *)userId
{
    [self.mainPageViewDelegate chatSelectedWithUserId:userId];
}

-(void)postButtonClicked
{
    self.postHelpPopupView = [[PostHelpPopupView alloc]initWithFrame:CGRectMake(0, 0, 300, 381)];
    self.postHelpPopupView.center = self.center;
    [self addSubview:self.postHelpPopupView];
}

-(void)postMadeTitle:(NSString *)postTitle andDescription:(NSString *)descriptionString
{
    [self.mainPageViewDelegate postMadeTitle:postTitle andDescription:descriptionString];
    [self postHelpPopupView];
}

-(void)postHelpPopupClosed
{
    [self.postHelpPopupView removeFromSuperview];
    self.postHelpPopupView = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
