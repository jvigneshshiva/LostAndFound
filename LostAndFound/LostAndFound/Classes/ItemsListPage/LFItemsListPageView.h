//
//  ItemsListPageView.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFItemsListPageViewProtocol <NSObject>

-(void)chatSelectedWithUserId:(NSString *)userId;
-(void)postButtonClicked;

@end

@interface LFItemsListPageView : UIView

-(void)configureItemListWith:(NSArray *)itemListArray;
@property (nonatomic) id<LFItemsListPageViewProtocol> itemsListPageViewDelegate;

@end
