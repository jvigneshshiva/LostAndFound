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



@interface LFChatPageView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatMessagesTableView;
@property (nonatomic) NSMutableArray *chatMessagesArray;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;

@end

@implementation LFChatPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
        self.chatMessagesArray = [[NSMutableArray alloc]init];
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
    if(chatMessagesArray.count > 0)
    {
        self.chatMessagesArray = [chatMessagesArray mutableCopy];
        [self.chatMessagesTableView reloadData];
    }

}

- (IBAction)sendButtonPressed
{
    if([self canChatMessageBeSent] == YES)
    {
        [self.chatPageViewDelegate submitChatMessage:self.chatTextField.text];
        [self addMessage:self.chatTextField.text];
    }

}

-(void)addMessage:(NSString *)string
{
    NSDictionary *dictionary = @{
                                 @"text" : string,
                                 @"hasUserSentThisMessage" : @(YES)
                                 };
    [self.chatMessagesArray addObject:dictionary];
    [self.chatMessagesTableView reloadData];
    self.chatTextField.text = nil;
}

-(BOOL)canChatMessageBeSent
{
    if([self.chatTextField.text isEqualToString:@""])
    {
        return NO;
    }
    else if(self.chatTextField.text == nil)
    {
        return NO;
    }
    
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
