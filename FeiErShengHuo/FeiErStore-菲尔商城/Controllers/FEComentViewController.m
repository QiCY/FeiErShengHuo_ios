//
//  FEComentViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEComentViewController.h"
#import "UIViewController+STPopup.h"
#import "STPopupController.h"
#import "FECommentCell.h"
#import "FEStoreCommentModel.h"

@interface FEComentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FEComentViewController

- (instancetype)init
{
    self = [super init];
    if(self) {
        CGFloat h = [UIScreen mainScreen].bounds.size.height *0.5;
        self.contentSizeInPopup = CGSizeMake(MainW, h);
        self.landscapeContentSizeInPopup = CGSizeMake(MainH, h);
    }
    return self;
}
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
}

-(void)initView
{
    UIView *superview = self.view;
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [_tableView addGestureRecognizer:tap];
    _tableView.userInteractionEnabled=YES;
    
    
    
    [superview addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
    
    
}


-(void)doRequest
{
    
    self.dataArray=[NSMutableArray arrayWithArray:self.comntlist];
    [self.tableView reloadData];
    
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
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
    
    FEStoreCommentModel  *model=_dataArray[indexPath.section];
    
    [cell setupStoreCellWithModel:model];
    
    return cell;
}
 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if(self.popupController) [self.popupController dismiss];
}

-(void)click
{
    if(self.popupController) [self.popupController dismiss];

}

@end
