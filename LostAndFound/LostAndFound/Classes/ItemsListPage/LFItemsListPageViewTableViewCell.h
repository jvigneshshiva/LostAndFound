//
//  LFItemsListPageViewTableViewCell.h
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFItemsListPageViewTableViewCellProtocol <NSObject>

-(void)contactButtonPressedWithTag:(int)tag;

@end

@interface LFItemsListPageViewTableViewCell : UITableViewCell

@property (nonatomic) id<LFItemsListPageViewTableViewCellProtocol> LFItemsListPageViewTableViewCellDelegate;
-(void)configureCellWithDictionary:(NSDictionary *)dictionary;


@end
