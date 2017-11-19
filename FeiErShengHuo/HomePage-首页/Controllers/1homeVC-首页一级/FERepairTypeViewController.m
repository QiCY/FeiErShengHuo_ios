//
//  FERepairTypeViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FERepairTypeViewController.h"
#import "FEAdvicetype.h"
#import "STPopupController.h"
#import "UIViewController+STPopup.h"

@interface FERepairTypeViewController () < UITableViewDelegate, UITableViewDataSource >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FERepairTypeViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CGFloat h = [UIScreen mainScreen].bounds.size.height * 0.8;
        self.contentSizeInPopup = CGSizeMake([UIScreen mainScreen].bounds.size.width, h);
        self.landscapeContentSizeInPopup = CGSizeMake([UIScreen mainScreen].bounds.size.height, h);
    }
    return self;
}
- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    UIView *superview = self.view;
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [superview addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(superview);
    }];
}

- (void)doRequest
{
    NSString *str = @"020appd/repaire/showRepaireType";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"报修类别---- %@", dic);

                                                     NSArray *array = [FEAdvicetype mj_objectArrayWithKeyValuesArray:dic[@"xcommunityTypesList"]];
                                                     _dataArray = [NSMutableArray arrayWithArray:array];
                                                     [_tableView reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEArgumentsCellID = @"FEArgumentsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FEArgumentsCellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEArgumentsCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    FEAdvicetype *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.xcommunityTypeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.popupController)
        [self.popupController dismiss];
    FEAdvicetype *model = _dataArray[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(chosetype:andID:)])
    {
        [_delegate chosetype:model.xcommunityTypeName andID:model.xcommunityTypeId];
        NSLog(@"chuan--%@", model.xcommunityTypeName);
    }
}

@end
