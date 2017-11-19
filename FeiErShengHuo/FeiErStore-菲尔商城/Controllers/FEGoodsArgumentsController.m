//
//  FEGoodsArgumentsController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/2.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGoodsArgumentsController.h"
#import "UIViewController+STPopup.h"
#import "STPopupController.h"
#import "FEArgumentsCell.h"



@interface FEGoodsArgumentsController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;


@end

@implementation FEGoodsArgumentsController

- (instancetype)init
{
    self = [super init];
    if(self) {
        CGFloat h = [UIScreen mainScreen].bounds.size.height *0.5;
        self.contentSizeInPopup = CGSizeMake([UIScreen mainScreen].bounds.size.width, h);
        self.landscapeContentSizeInPopup = CGSizeMake([UIScreen mainScreen].bounds.size.height, h);
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
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
    
    //
    CGRect tableHeaderFrame = self.tableView.tableHeaderView.frame;
    tableHeaderFrame.size.height = 64;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderFrame];
    self.tableView.tableHeaderView.backgroundColor = UIColorFromRGBValue(0xffffff);
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"产品参数";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = UIColorFromRGBValue(0x000000);
    [self.tableView.tableHeaderView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView.tableHeaderView);
    }];
    
    //完成按钮
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"确定" forState:UIControlStateNormal];
    [closeButton setBackgroundColor:tableBarRedColor];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom).offset(5);
        make.width.equalTo(MainW);
        make.height.equalTo(60);
        make.left.equalTo(self.view.left);
    }];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Refresh:) name:NOTI_Shop_To_Detail object:nil];
}

- (void)didClose:(UIButton *)btn {
    if(self.popupController) [self.popupController dismiss];
    
}


-(void)Refresh:(NSNotification *)info
{
    self.model=info.userInfo[@"Model"];
    //[_dataArray addObject:_model];
    
    
    NSLog( @"模型---%@",self.model);
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    FEArgumentsCell *cell =[tableView dequeueReusableCellWithIdentifier:FEArgumentsCellID];
    if (cell == nil) {
        cell = [[FEArgumentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEArgumentsCellID];
        cell.backgroundColor =[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.leftLab.text=@"【品牌】";
            cell.rightLab.text=_model.brand;
            
            break;
            
        case 1:
            cell.leftLab.text=@"【产品名称】";
            cell.rightLab.text= _model.title;
            
            break;
            
            
        case 2:
            cell.leftLab.text=@"【产地】";
            cell.rightLab.text=_model.origin;
            
            break;
            
        case 3:
            cell.leftLab.text=@"【产品包装】";
            cell.rightLab.text=@"";
            break;
            
            
        case 4:
            cell.leftLab.text=@"【包装方法】";
            cell.rightLab.text=_model.packingMethod;
            
            break;
            
        default:
            break;
    }
    
       return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



@end
