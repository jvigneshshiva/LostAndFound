//
//  LFChatPageView.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFChatPageView.h"
#import "UIView+XIB.h"
#import "LFChatPageTableViewCell.h"



@interface LFChatPageView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatMessagesTableView;
@property (nonatomic) NSArray *chatMessagesArray;

@end

@implementation LFChatPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
        [self.chatMessagesTableView registerNib:[UINib nibWithNibName:@"LFChatPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LFChatPageTableViewCell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatMessagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LFChatPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFChatPageTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LFChatPageTableViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell configureCellWithDictionary:self.chatMessagesArray[indexPath.row]];
    return cell;
}

-(void)configureChatMessages:(NSArray *)chatMessagesArray
{
    self.chatMessagesArray = chatMessagesArray;
    [self.chatMessagesTableView reloadData];
}

-(void)contactButtonPressedWithTag:(int)tag
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
