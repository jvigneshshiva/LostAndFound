//
//  LFMainPagView1.h
//  LostAndFound
//
//  Created by Subbhaash on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFMainPagView1Protocol <NSObject>

-(void)cellClicked:(NSString *)categoryName;

@end

@interface LFMainPagView1 : UIView

@property (nonatomic, weak) id<LFMainPagView1Protocol> delegate;

@end
