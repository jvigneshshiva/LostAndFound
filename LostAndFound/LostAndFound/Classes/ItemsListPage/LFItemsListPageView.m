//
//  ItemsListPageView.m
//  LostAndFound
//
//  Created by Vignesh Shiva on 25/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFItemsListPageView.h"
#import "UIView+XIB.h"
#import "LFItemsListPageViewTableViewCell.h"

@interface LFItemsListPageView()<UITableViewDataSource,UITableViewDelegate,LFItemsListPageViewTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *itemsListTableView;
@property (nonatomic) NSArray *itemsListArray;

@end

@implementation LFItemsListPageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubViewWithXibName:NSStringFromClass([self class]) andFrame:self.bounds];
        [self.itemsListTableView registerNib:[UINib nibWithNibName:@"LFItemsListPageViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"LFItemsListPageViewTableViewCell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LFItemsListPageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFItemsListPageViewTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LFItemsListPageViewTableViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.LFItemsListPageViewTableViewCellDelegate = self;
    [cell configureCellWithDictionary:self.itemsListArray[indexPath.row]];
    return cell;
}

-(void)configureItemListWith:(NSArray *)itemListArray
{
    self.itemsListArray = itemListArray;
    [self.itemsListTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *itemInfoDictionary = self.itemsListArray[indexPath.row];
    [self.itemsListPageViewDelegate chatSelectedWithUserId:itemInfoDictionary[@"userId"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
