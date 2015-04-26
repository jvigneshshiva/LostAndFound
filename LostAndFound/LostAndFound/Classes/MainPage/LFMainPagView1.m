//
//  LFMainPagView1.m
//  LostAndFound
//
//  Created by Subbhaash on 26/04/15.
//  Copyright (c) 2015 VVS. All rights reserved.
//

#import "LFMainPagView1.h"
#import "UIView+XIB.h"
#import "LPMainPageViewCell.h"

@interface LFMainPagView1()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *categoryInfoArray;
@end

@implementation LFMainPagView1

- (id)initWithFrame:(CGRect)frame andCategoryInfoArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.categoryInfoArray = array;
        [self addSubViewWithXibName:@"LFMainPagView1" andFrame:self.bounds];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMainPageViewCell" bundle:nil] forCellReuseIdentifier:@"LPMainPageViewCell"];
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryId = self.categoryInfoArray[indexPath.row][@"categoryId"];
    [self.delegate cellClicked:categoryId];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryName = self.categoryInfoArray[indexPath.row][@"name"];
    
    LPMainPageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPMainPageViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LPMainPageViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.categoryTitleLabel.text = categoryName;
    cell.categoryImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",categoryName]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryInfoArray.count;
}

-(void)configureWithArray:(NSArray *)array
{
    self.categoryInfoArray = array;
    [self.tableView reloadData];
}


@end
