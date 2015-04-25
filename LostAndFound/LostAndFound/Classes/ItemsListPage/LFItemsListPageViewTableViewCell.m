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
    NSString *itemStatus = nil;
    if([dictionary[@"itemStatus"] isEqualToString:@"found"])
    {
        itemStatus = NSLocalizedString(@"Found", @"Item Status");
    }
    else if([dictionary[@"itemStatus"] isEqualToString:@"lost"])
    {
        itemStatus = NSLocalizedString(@"Lost", @"Item Status");
    }
    NSString *headerString = [NSString stringWithFormat:@"%@ %@ %@ %@",dictionary[@"name"],itemStatus,dictionary[@"itemName"],dictionary[@"location"]];
    self.headerLabel.text = headerString;
    
}
- (IBAction)contactButtonPressed
{
    [self.LFItemsListPageViewTableViewCellDelegate contactButtonPressedWithTag:(int)self.tag];
}

@end
