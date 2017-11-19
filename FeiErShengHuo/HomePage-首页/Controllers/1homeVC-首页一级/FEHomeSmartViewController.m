//
//  FEHomeSmartViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/17.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHomeSmartViewController.h"
#import "FEFeedBackViewController.h"
#import "YCXMenuHelper.h"

#import "FESmartHomeSceneView.h"
#import "FESmartHomeDeviceListCell.h"

#import "AddSceneViewController.h"
#import "FEConfigWIFIViewController.h"
#import "FEDeviceListViewController.h"
#import "FEDeviceStoreViewController.h"
#import "BLDNADevice+toKeyValue.h"

#import "SceneModel.h"
#import "FESceneAddDeviceViewController.h"
#import "BLDeviceQueueOperationHelper.h"
#import "FESceneOperationResultView.h"
#import "ZLActionSheet.h"

@interface FEHomeSmartViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, BroadLinkHelperDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView2;
@property (nonatomic,strong) UIBarButtonItem *feedBackButtonItem;
@property (nonatomic,strong) UIBarButtonItem *addDeviceButtonItem;

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) FESmartHomeSceneView *sceneView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray <BLDNADevice *>*dataArray;
@property (nonatomic,strong) NSMutableArray <SceneModel *>*sceneArray;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *imagesURLStrings;

@end

@implementation FEHomeSmartViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [BroadLinkHelper sharedBroadLinkHelper].delegate = self;
    
    [self getSceneListRequest];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [BroadLinkHelper sharedBroadLinkHelper].delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"智能家居";
    
    self.navigationItem.rightBarButtonItems = @[self.addDeviceButtonItem, self.feedBackButtonItem];
    
    [self.view addSubview:self.bgImageView];
    //[self.view addSubview:self.sceneView];
    [self.view addSubview:self.cycleScrollView2];
    
    [self.view addSubview:self.collectionView];
    
    self.bgImageView.frame = self.view.bounds;
    self.collectionView.frame = CGRectMake(0, 180, MainW, MainH-64-180);
    
    [self remoteDeviceListRequest];
    

    
    UIButton *shopeimgView=[[UIButton alloc]init];
    UIImage *image=Image(@"icon_move_Shopping3");
    [shopeimgView setImage:image forState:0];
    
    shopeimgView.frame=CGRectMake(MainW-image.size.width-10, MainH-64-image.size.height-10,image.size.width, image.size.height);
    
    [shopeimgView addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopeimgView];
    
    
    //轮播执行；

    WeakSelf;
    _cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
        [weakSelf handleSceneClick:index];
    };
    
}

-(void)imageClick:(UIButton *)tap
{
    FEDeviceStoreViewController *vc=[[FEDeviceStoreViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - method

- (void)getSceneListRequest
{
    NSString *urlString = @"020appd/scenes/show";
    NSDictionary *params = @{};
    
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST withPath:urlString withDictionary:params withSuccessBlock:^(NSDictionary *dic) {
        
        [self.sceneArray removeAllObjects];
        NSArray *resultInfo = dic[@"scenes"];
        for (NSDictionary *dict in resultInfo) {
            SceneModel *model = [SceneModel modelWithDict:dict];
            [self.sceneArray addObject:model];
        }
       // [self.sceneView addScenes:self.sceneArray];
        
        
        [_imagesURLStrings removeAllObjects];
        
        for (SceneModel *model in self.sceneArray) {
            NSString *pic=model.pic;
            NSString *name=model.name;
            [self.imagesURLStrings addObject:pic];
            [self.titles addObject:name];
            
        }
        
    
        _cycleScrollView2.imageURLStringsGroup=_imagesURLStrings;
        _cycleScrollView2.titlesGroup=_titles;
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}

- (void)remoteDeviceListRequest
{
    [[BroadLinkHelper sharedBroadLinkHelper] bl_getRemoteDeviceListComplete:^(NSArray<BLDNADevice *> *deviceList) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:deviceList];
        [self.collectionView reloadData];
    } failed:^{
        
    }];
}

- (void)feedBackAction
{
    FEFeedBackViewController *fvc = [[FEFeedBackViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)addDeviceAction
{
    NSDictionary *item1 = @{kYCXMenuImageKey:[UIImage imageNamed:@"Addscene_Smart_home2"],
                                       kYCXMenuTagKey:@(1),
                                       kYCXMenuNameKey:@"添加场景"};
    NSDictionary *item2 = @{kYCXMenuImageKey:[UIImage imageNamed:@"Addequi_Smart_home2"],
                                        kYCXMenuTagKey:@(2),
                                        kYCXMenuNameKey:@"添加设备"};
    NSDictionary *item3 = @{kYCXMenuImageKey:[UIImage imageNamed:@"list_Smart_home2"],
                            kYCXMenuTagKey:@(3),
                            kYCXMenuNameKey:@"搜索设备"};
    NSDictionary *item4 = @{kYCXMenuImageKey:[UIImage imageNamed:@"list_Smart_home2"],
                            kYCXMenuTagKey:@(4),
                            kYCXMenuNameKey:@"设备列表"};
    NSDictionary *item5 = @{kYCXMenuImageKey:[UIImage imageNamed:@"list_Smart_home2"],
                            kYCXMenuTagKey:@(5),
                            kYCXMenuNameKey:@"设备商店"};
    [YCXMenuHelper showMenuWithItems:@[item1, item2, item3, item4, item5] frame:CGRectMake(MainW-44, 20, 44, 44) clickBlock:^(NSString *name, NSInteger tag) {
        if (tag == 1) [self addScene];
        if (tag == 2) [self addDevice];
        if (tag == 3) [self scanDevice];
        if (tag == 4) [self showDeviceList];
        if (tag == 5) [self showDeviceStore];
    }];
}

- (void)addScene
{
    AddSceneViewController *avc = [[AddSceneViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)addDevice
{
    FEConfigWIFIViewController *fvc = [[FEConfigWIFIViewController alloc] init];
    fvc.didFinishConfigDevice = ^{
        
    };
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)scanDevice
{
    [[BroadLinkHelper sharedBroadLinkHelper] bl_startScanDevice];
}

- (void)showDeviceList
{
    FEDeviceListViewController *deviceVC = [[FEDeviceListViewController alloc] init];
    [self.navigationController pushViewController:deviceVC animated:YES];
}

- (void)showDeviceStore
{
    FEDeviceStoreViewController *fvc = [[FEDeviceStoreViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)handleSceneClick:(NSInteger)index
{
    SceneModel *model = self.sceneArray[index];
    if (model.deviceList.count) {
        //  执行该场景下的设备动作
        
        FESceneOperationResultView *resultView = [FESceneOperationResultView viewWithDevices:model.deviceList sceneName:model.name];
        resultView.shouldCancelOperation = ^{
            [[BLDeviceQueueOperationHelper sharedBLDeviceQueueOperationHelper] bl_cancelQuenuOperation];
        };
        [resultView show];
        
        [[BLDeviceQueueOperationHelper sharedBLDeviceQueueOperationHelper] bl_quenuOperationWithDevices:model.deviceList timeInterval:0.5 complete:^(BOOL success, NSInteger index) {
            NSLog(@"success = %d, inde = %ld",success, index);
            if (index < model.deviceList.count) {
                [resultView refreshItem:index result:success];
            }
        }];
        

    }
    else {
        
        [FENavTool showAlertViewByAlertMsg:@"" andType:@"提示"];
        
        //  去该场景添加设备
//        FESceneAddDeviceViewController *fvc = [[FESceneAddDeviceViewController alloc] init];
//        fvc.sceneId = model.sceneId;
//        fvc.sceneName = model.name;
//        [self.navigationController pushViewController:fvc animated:YES];
    }
}

- (void)handleSceneLongClick:(NSInteger)index
{
    SceneModel *model = self.sceneArray[index];
    ZLActionSheet *sheet = [[ZLActionSheet alloc] initWithTitle:@"您希望对这个场景做怎样的操作？" message:@""];
//    [sheet addBtnTitle:@"编辑" action:^{
//        [self editScene:model];
//    }];
//    [sheet addBtnTitle:@"复制" action:^{
//        [self copyScene:model];
//    }];
    [sheet addBtnTitle:@"删除" action:^{
        [self deleteScene:model];
    }];
    [sheet showActionSheetWithSender:self];
}

- (void)editScene:(SceneModel *)scene
{

}

- (void)copyScene:(SceneModel *)scene
{

}

- (void)deleteScene:(SceneModel *)scene
{
    NSString *urlString = @"020appd/scenes/shanchuchangjing";
    NSDictionary *params = @{@"scenesId":@(scene.sceneId.integerValue)};
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST withPath:urlString withDictionary:params withSuccessBlock:^(NSDictionary *dic) {
        
        [self.sceneArray removeObject:scene];
        [self.sceneView addScenes:self.sceneArray];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}

#pragma mark - BroadLinkHelperDelegate
- (void)onDiscoverDevice:(BLDNADevice *)device isNewDevice:(BOOL)isNewDevice
{
    if (isNewDevice) {
    
    [[BroadLinkHelper sharedBroadLinkHelper] bl_pairDevice:device complete:^(BOOL success) {
        [[BroadLinkHelper sharedBroadLinkHelper] bl_uploadDevice:device autoAdd:YES complete:^{
            
            [self.dataArray addObject:device];
            [self.collectionView reloadData];
            
        } failed:^{
            
        }];
    }];
    

    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = NSStringFromClass([FESmartHomeDeviceListCell class]);
    FESmartHomeDeviceListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    BLDNADevice *device = self.dataArray[indexPath.row];
    [cell refreshCellWithDevice:device];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BLDNADevice *device = self.dataArray[indexPath.row];
    
    [[BroadLinkHelper sharedBroadLinkHelper] bl_showDeviceDetail:device inController:self];
}

#pragma mark - getter
- (UIBarButtonItem *)feedBackButtonItem
{
    if (!_feedBackButtonItem) {
        UIButton *feedBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [feedBackButton setImage:[UIImage imageNamed:@"say_Smart_home2"] forState:UIControlStateNormal];
        [feedBackButton addTarget:self action:@selector(feedBackAction) forControlEvents:UIControlEventTouchUpInside];
        _feedBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:feedBackButton];
        
        [feedBackButton sizeToFit];
    }
    return _feedBackButtonItem;
}

- (UIBarButtonItem *)addDeviceButtonItem
{
    if (!_addDeviceButtonItem) {
        UIButton *addDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addDeviceButton setImage:[UIImage imageNamed:@"plus_Smart_home2"] forState:UIControlStateNormal];
        [addDeviceButton addTarget:self action:@selector(addDeviceAction) forControlEvents:UIControlEventTouchUpInside];
        _addDeviceButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addDeviceButton];
        
        [addDeviceButton sizeToFit];
    }
    return _addDeviceButtonItem;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_Smart_home2"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (FESmartHomeSceneView *)sceneView
{
    if (!_sceneView) {
        _sceneView = [[FESmartHomeSceneView alloc] initWithFrame:CGRectMake(0, 0, MainW, 180)];
        
        @weakify(self);
        _sceneView.didClickScene = ^(NSInteger index) {
            @strongify(self);
            NSLog(@"index = %ld",index);
            [self handleSceneClick:index];
        };
        _sceneView.didLongClickScene = ^(NSInteger index) {
            NSLog(@"index = %ld",index);
            @strongify(self);
//            [self handleSceneLongClick:index];
        };
    }
    return _sceneView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(MainW/4, MainW/4);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FESmartHomeDeviceListCell class] forCellWithReuseIdentifier:NSStringFromClass([FESmartHomeDeviceListCell class])];
    }
    return _collectionView;
}


-(SDCycleScrollView *)cycleScrollView2
{
    if (!_cycleScrollView2) {
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //_cycleScrollView2.titlesGroup = titles;
        _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
         //_cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        //_cycleScrollView2.titleLabelBackgroundColor=[UIColor clearColor];
        _cycleScrollView2.autoScrollTimeInterval=8;
        
    }
    return _cycleScrollView2;
    
}





- (NSMutableArray <BLDNADevice *>*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray <SceneModel *>*)sceneArray
{
    if (!_sceneArray) {
        _sceneArray = [NSMutableArray array];
    }
    return _sceneArray;
}

-(NSMutableArray *)titles{
    if (!_titles) {
        _titles=[NSMutableArray array];
        
    }
    return _titles;
    
}
-(NSMutableArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
        _imagesURLStrings=[NSMutableArray array];
        
    }
    return _imagesURLStrings;
    
}

@end
