//
//  LFItemsListPageViewTableViewCell.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFItemsListPageViewTableViewCell.h"

@interface LFItemsListPageViewTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation LFItemsListPageViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithDictionary:(NSDictionary *)dictionary
{
    self.headerLabel.text = dictionary[@"description"];
    
}


@end
