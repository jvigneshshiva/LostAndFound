//
//  LFChatPageTableViewCell.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFChatPageTableViewCell.h"
#import "SpeechBubbleView.h"

@interface LFChatPageTableViewCell()

@property (nonatomic) SpeechBubbleView *speechBubbleView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end

@implementation LFChatPageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Create the speech bubble view

        

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithDictionary:(NSDictionary *)dictionary
{
    self.speechBubbleView = [[SpeechBubbleView alloc] initWithFrame:self.contentView.frame];
    self.speechBubbleView.backgroundColor = nil;
    self.speechBubbleView.opaque = YES;
    self.speechBubbleView.clearsContextBeforeDrawing = NO;
    self.speechBubbleView.contentMode = UIViewContentModeRedraw;
    self.speechBubbleView.autoresizingMask = 0;
    [self.contentView addSubview:self.speechBubbleView];
    self.userNameLabel.text = dictionary[@"userName"];
    self.messageLabel.text = dictionary[@"message"];
    
    if([dictionary[@"hasUserSentThisMessage"] boolValue] == true)
    {
        [self.speechBubbleView setText:dictionary[@"message"] bubbleType:BubbleTypeRighthand];
    }
    else
    {
        [self.speechBubbleView setText:dictionary[@"message"] bubbleType:BubbleTypeLefthand];

    }


}


@end
