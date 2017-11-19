//
//  FEcommmentView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEcommmentView.h"

#import "FECommentCell.h"
#import "FEStoreCommentModel.h"


@implementation FEcommmentView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
        
    }
    return self;
    
}




-(void)initView
{
    

    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
   
    _tableView.userInteractionEnabled=YES;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.tableView reloadData];
    
    
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comntlist.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetify = @"FECommentCell";
    FECommentCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (cell == nil) {
        cell = [[FECommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FEStoreCommentModel  *model=self.comntlist[indexPath.section];
    
    [cell setupStoreCellWithModel:model];
    
    return cell;
}




@end
