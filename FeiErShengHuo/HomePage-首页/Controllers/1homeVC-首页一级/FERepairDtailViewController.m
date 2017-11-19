//
//  FERepairDtailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FERepairDtailViewController.h"
#import "FEComplianDetailHeaderView.h"
#import "FERepairDModel.h"
@interface FERepairDtailViewController () < UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource >
{
    UILabel *_adviceContentLab;
    UILabel *_requirementAdviceLab;
    UIImageView *_imageView;
    CGFloat cellWidth;

    UILabel *huifuLab;
}
@property (nonatomic, strong) UITableView *Tabview;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FERepairDModel *Smodel;
@property (nonatomic, strong) NSMutableArray *picDataArray;

@end

@implementation FERepairDtailViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    self.title = @"在线报修";
    self.picDataArray = [[NSMutableArray alloc] init];

    [self DdoRequest];
    self.Tabview = [UITableView groupTableView];
    self.Tabview.frame = CGRectMake(10, 0, MainW - 20, MainH - 64);
    self.Tabview.delegate = self;
    self.Tabview.dataSource = self;
    self.Tabview.sectionFooterHeight = 0.01;
    self.Tabview.sectionHeaderHeight = 0.01;
    self.Tabview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.Tabview.tableHeaderView = view;
    [self.view addSubview:self.Tabview];
}

- (void)DdoRequest
{
    NSString *str = @"020appd/xiangqing/showInfo";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"repaireType"];
    [dic setObject:_RModel.repaireId forKey:@"repaireId"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"在线报修建议详情-----%@", dic);
                                                     self.Smodel = [FERepairDModel mj_objectWithKeyValues:dic[@"xcommunityAdvice"]];

                                                     if ([_Smodel.resolve isEqualToString:@""])
                                                     {
                                                         huifuLab.text = @"暂未回复";
                                                         //_Smodel.adviceResolveInfo;
                                                     }
                                                     else
                                                     {
                                                         huifuLab.text = _Smodel.resolve;
                                                     }

                                                     self.picDataArray = self.Smodel.pictureMap;

                                                     [self.photoCollectionView reloadData];

                                                     [self.Tabview reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 60;

            break;
        case 1:
            return 40;

            break;
        case 2:
            return 40;

            break;
        case 3:
            return 90;

            break;
        case 4:
            return 100;

            break;

        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identy = @"headFoot";
    FEComplianDetailHeaderView *hf = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!hf)
    {
        hf = [[FEComplianDetailHeaderView alloc] initWithReuseIdentifier:identy];
    }

    NSArray *array = @[ @"业主信息", @"保修内容", @"业主建议", @"业主图片", @"物业回复" ];
    hf.titleLab.text = array[section];

    return hf;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEGoodCarCellID = @"FEGoodCarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FEGoodCarCellID];
    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    //FESuggestModel *Sugestmodel=self.dataArray[0];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEGoodCarCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.section == 0)
        {
            UILabel *lab = [MYUI createLableFrame:CGRectMake(10, 5, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:[NSString stringWithFormat:@"%@:%@", info.nickName, info.mobile] textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:lab];
            UILabel *adressLab = [MYUI createLableFrame:CGRectMake(10, 5 + 20 + 5, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:info.regionTitle textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:adressLab];
        }
        if (indexPath.section == 1)
        {
            _adviceContentLab = [MYUI createLableFrame:CGRectMake(10, 5, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:self.Smodel.repaireContent textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:_adviceContentLab];
        }
        if (indexPath.section == 2)
        {
            _requirementAdviceLab = [MYUI createLableFrame:CGRectMake(10, 5, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:self.Smodel.repaireRequirement textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:_requirementAdviceLab];
        }
        if (indexPath.section == 3)
        {
            //初始化 选择照片的 瀑布流
            UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];

            //CGFloat insertintem=5;//(MainW-20-100*3)/2;

            [clay setMinimumInteritemSpacing:5];

            [clay setMinimumLineSpacing:5];
            clay.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);

            self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:clay];
            self.photoCollectionView.delegate = self;
            self.photoCollectionView.dataSource = self;
            self.photoCollectionView.backgroundColor = [UIColor clearColor];
            [self.photoCollectionView registerClass:NSClassFromString(@"PHCell") forCellWithReuseIdentifier:@"cellid"];

            cellWidth = 80;

            //self.photoCollectionView.frame = CGRectMake(0, 0, 100*array.count+5*(array.count-1)+10, 110);

            self.photoCollectionView.frame = CGRectMake(0, 0, MainW - 20, 90);

            [cell addSubview:self.photoCollectionView];
        }
        if (indexPath.section == 4)
        {
            huifuLab = [MYUI createLableFrame:CGRectMake(10, 5, MainW - 40, 20) backgroundColor:[UIColor clearColor] text:@"暂未回复" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:huifuLab];

            //
            //            UIButton *connectWUYEBtn=[MYUI creatButtonFrame:CGRectMake(10,50, MainW-40, 40) backgroundColor:Green_Color setTitle:@"联系物业" setTitleColor:[UIColor whiteColor]];
            //            connectWUYEBtn.layer.cornerRadius=5;
            //            [connectWUYEBtn addTarget:self action:@selector(connectWUYE) forControlEvents:UIControlEventTouchUpInside];
            //
            //            connectWUYEBtn.layer.masksToBounds=YES;
            //            connectWUYEBtn.titleLabel.font=FontAndStyle15;
            //            [cell addSubview:connectWUYEBtn];
        }
    }

    _adviceContentLab.text = self.Smodel.repaireContent;
    _requirementAdviceLab.text = self.Smodel.repaireRequirement;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.Smodel.repaireImages]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)connectWUYE
{
    //拨打电话
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", self.Smodel.propertyPhone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark-- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picDataArray.count;
}
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    FEpicturemapmodel2 *model = self.picDataArray[indexPath.row];

    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.repaireImages]];

    //    UIImage *newImg = self.picDataArray[indexPath.row];
    //    //需要等比例压缩图片// 这是一个坑 不规则 瀑布流才会等比压缩
    //    //UIImage *smImg = [RYImageTool createSmallPic:newImg];
    //    cell.imgView.image = newImg;
    //    cell.tag = 100 + indexPath.row;
    return cell;
}

#pragma mark--UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

@end
