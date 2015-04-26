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
@end

@implementation LFMainPagView1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubViewWithXibName:@"LFMainPagView1" andFrame:self.bounds];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMainPageViewCell" bundle:nil] forCellReuseIdentifier:@"LPMainPageViewCell"];
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryId = categoryInfoArray[indexPath.row][@"categoryId"];
    [self.delegate cellClicked:categoryId];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryName = categoryInfoArray[indexPath.row][@"name"];
    
    LPMainPageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPMainPageViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LPMainPageViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.categoryTitleLabel.text = categoryName;
    cell.categoryImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",categoryName]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryInfoArray.count;
}

@end
