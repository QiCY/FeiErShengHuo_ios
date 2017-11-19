//
//  FEAddinfoViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEAddinfoViewController.h"
#import "FERegionModel.h"

#import "JHPickView.h"

@interface FEAddinfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,JHPickerDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout,ZYQAssetPickerControllerDelegate,RYImagePreViewControllerDelegate>
{
    CGFloat cellWidth;
    NSInteger currentSelectNum;
    NSNumber *_regionID;
    UIButton *sureBtn;
    FELoginInfo *_model;
    
    
}
@property(nonatomic,strong)UITableView *addInfoTabView;
@property (assign,nonatomic) NSIndexPath* selectedIndexPath ;
@property(nonatomic,strong)NSMutableArray *regionArray;
@property(nonatomic,strong)NSMutableArray *regionInfoArray;

@end

@implementation FEAddinfoViewController


-(void)initView

{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshRegion:) name:NOTI_REFRESH_REGION object:nil];
    
    
    self.regionArray=[[NSMutableArray alloc]init];
    self.regionInfoArray=[[NSMutableArray alloc]init];
    
    self.photoArr = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"icon_addpic"],nil];
    //[self requestRegionArray];
//    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(uploadinfo) andType:item_sure];
    [FENavTool backOnNavigationItemWithNavItem:self.navigationItem target:self action:@selector(dissmissClick)];
    
    self.title=@"健全信息";
    self.addInfoTabView=[UITableView groupTableView];
    self.addInfoTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.addInfoTabView.delegate=self;
    self.addInfoTabView.dataSource=self;
    self.addInfoTabView.sectionHeaderHeight=0.01;
    self.addInfoTabView.sectionFooterHeight=0.01;
    self.addInfoTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.addInfoTabView.tableHeaderView=view;
    [self.view addSubview:self.addInfoTabView];
    
}


-(void)RefreshRegion:(NSNotification *)info
{
    _model=info.object;
    
    _regionLab.text=_model.regionTitle;
    _regionID=_model.villageId;
    
    
    NSLog(@"选择的小区名字-- %@ ID　-- %@",_model.regionTitle,_model.villageId);
    
    
    
    
    //[_choseRirionBtn setTitle:model.regionTitle forState:0];
}


-(void)dissmissClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 7;
        
    }
    if (section==1) {
        return 1;
        
    }
    return 0;
    
    
}
//-(void)requestRegionArray
//{
//    
//    FELoginInfo *info=[LoginUtil getInfoFromLocal];
//    
//    
//    NSString *str=@"020appd/goto/showVillagexinxi";
//    [RYLoadingView showRequestLoadingView];
//    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:nil withSuccessBlock:^(NSDictionary *dic) {
//        NSLog(@"获取小区列表---%@",dic);
//        NSArray *array=[FERegionModel mj_objectArrayWithKeyValuesArray:dic[@"regionInfos"]];
//        
//        
//        for (FERegionModel *model in array) {
//            NSString *title=model.regionTitle;
//            [_regionArray addObject:title];
//            [_regionInfoArray addObject:model];
//            
//            
//        }
//        
//    } withfialedBlock:^(NSString *msg) {
//    }];
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    secView.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
    return secView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            
//            CGFloat cviewHeightNum = cellWidth*(self.photoArr.count/5+1)+8;
            return 80;//40+cviewHeightNum;
        }
    }
    else
        
    {
        return 48;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //title label
        UILabel *titLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 100, 16)];
        titLbl.font = [UIFont boldSystemFontOfSize:14.f];
        titLbl.textColor = GLOBAL_BIG_FONT_COLOR;
        titLbl.tag = 1001;
        [cell addSubview:titLbl];
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                
                //小区名
                _regionLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 17, MainW-66, 18)];
                _regionLab.textColor = GLOBAL_LITTLE_FONT_COLOR;
                _regionLab.textAlignment = NSTextAlignmentRight;
                _regionLab.font = [UIFont systemFontOfSize:14.f];
                
                
                _regionLab.text=@"请选择小区";
                _regionLab.tag=10086;
                
                [cell addSubview:_regionLab];
                
            }
            
            
            if (indexPath.row==1) {
                //姓名
                _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_nameTF FEInputTextFieldStyle];
                _nameTF.delegate = self;
                _nameTF.backgroundColor=[UIColor clearColor];
                //_buildingNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_nameTF];

            }
            if (indexPath.row==2) {
                //手机号码
                _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_phoneTF FEInputTextFieldStyle];
                _phoneTF.delegate = self;
                _phoneTF.keyboardType=UIKeyboardTypeNumberPad;
                 _phoneTF.backgroundColor=[UIColor clearColor];
                //_buildingNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_phoneTF];

                
            }

            
            
            if (indexPath.row==3) {
                //楼号
                _buildingNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_buildingNumTF FEInputTextFieldStyle];
                _buildingNumTF.delegate = self;
                _buildingNumTF.keyboardType=UIKeyboardTypeNumberPad;
                _buildingNumTF.backgroundColor=[UIColor clearColor];
                //_buildingNumTF.text = curObj.myUserInfo.contactAddress;
                
                
                [cell addSubview:_buildingNumTF];
                
            }
            if (indexPath.row==4) {
                //单元号
                _unitNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_unitNumTF FEInputTextFieldStyle];
                _unitNumTF.delegate = self;
                _unitNumTF.keyboardType=UIKeyboardTypeNumberPad;
                _unitNumTF.backgroundColor=[UIColor clearColor];
                //_unitNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_unitNumTF];
                
            }
            if (indexPath.row==5) {
                //房间号
                _roomNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_roomNumTF FEInputTextFieldStyle];
                _roomNumTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                _roomNumTF.keyboardType=UIKeyboardTypeNumberPad;
                 _roomNumTF.backgroundColor=[UIColor clearColor];
                [cell addSubview:_roomNumTF];
            }
            
            if (indexPath.row==6) {
                //租客 和房间
                
                //小区名
                _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 17, MainW-66, 18)];
                _typeLab.textColor = GLOBAL_LITTLE_FONT_COLOR;
                _typeLab.textAlignment = NSTextAlignmentRight;
                _typeLab.font = [UIFont systemFontOfSize:14.f];
                
                _typeLab.text=@"选择类型";
                _typeLab.tag=10010;
                [cell addSubview:_typeLab];
            }

        }

        if (indexPath.section==1) {
            
            if (indexPath.row==0) {
                sureBtn=[MYUI creatButtonFrame:CGRectMake(10,30, MainW-20, 40) backgroundColor:Green_Color setTitle:@"去认证" setTitleColor:[UIColor whiteColor]];
                [sureBtn addTarget:self action:@selector(goRenZheng) forControlEvents:UIControlEventTouchUpInside];
                sureBtn.layer.masksToBounds=YES;
                sureBtn.layer.cornerRadius=5;
                [cell addSubview:sureBtn];

      
                
            }
                       
        }
        
    }
    
    NSArray *regionarray = @[@"小区名",@"姓名",@"手机号码",@"楼号",@"单元号",@"房间号",@"类型"];
    UILabel *ttlbl = (UILabel *)[cell viewWithTag:1001];
    if (indexPath.section==0) {
        
        ttlbl.text=regionarray[indexPath.row];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath =  indexPath ;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
//            JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
//            picker.delegate = self ;
//            picker.selectLb.text = @"选择小区";//@"情感状态";
//            picker.customArr = [NSArray arrayWithArray:_regionArray];//_regionArray;//@[@"已婚",@"未婚",@"保密"];
//            
//            [self.view addSubview:picker];
            
            
            
            FEShengViewController *vc=[[FEShengViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            vc.number=[NSNumber numberWithInt:1];
            
            

        }
        if (indexPath.row==6) {
            JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
            picker.delegate = self ;
            picker.selectLb.text = @"选择类型";//@"情感状态";
            picker.customArr = @[@"业主",@"租客"];
            // [NSArray arrayWithArray:_regionArray];//_regionArray;//@[@"已婚",@"未婚",@"保密"];
            
            [self.view addSubview:picker];
            
        }
    }
    
    
}
//-(void)uploadinfo
//{
//    
//    //确认健全
//    NSLog(@"点击了确认");
//    
//    
//    
//    //分线程上传
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //分
//        
//        
//        //健全信息
//        
//        [self addinfo];
//        
//        //[self uploadImgAction];
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"主线成----");
//           // [self dismissViewControllerAnimated:YES completion:nil];
//            
//            
//            
//            //主
//        });
//    });
//    
//}


-(void)goRenZheng
{
    if (_nameTF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入真实姓名" andType:@"提示"];
        return;
        
    }
    if (_buildingNumTF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入楼号" andType:@"提示"];
        return;
        
    }
    if ( _unitNumTF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入单元号" andType:@"提示"];
        return;
        
    }
    if (_roomNumTF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入房间号" andType:@"提示"];
        return;
        
    }
    if (_phoneTF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入手机号码" andType:@"提示"];
        return;
        
    }
    
    if ([_typeLab.text isEqualToString:@"选择类型"]) {
        [FENavTool showAlertViewByAlertMsg:@"请选择类型" andType:@"提示"];
        return;
        
        
    }
    if ([_regionLab.text isEqualToString:@"请选择小区"]) {
        [FENavTool showAlertViewByAlertMsg:@"请选择小区" andType:@"提示"];
        return;
        
    }


    NSString *urlstr=@"020appd/goto/soundUser";
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString * homeAdress=[NSString stringWithFormat:@"%@栋%@单元%@室",_buildingNumTF.text,_unitNumTF.text,_roomNumTF.text];
    [dic setObject:_regionID forKey:@"regionId"];
    
    [dic setObject:homeAdress forKey:@"homeAdress"];
    
    [dic setObject:_phoneTF.text forKey:@"mobile"];
    [dic setObject:_typeLab.text forKey:@"identity"];
    [dic setObject:_nameTF.text  forKey:@"strueName"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:urlstr withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        NSLog(@"健全信息成功啦啦啦----");
        FELoginInfo *info=[LoginUtil getInfoFromLocal];
        info.villageId=_model.villageId;
        info.regionTitle=_model.regionTitle;
        [LoginUtil saveing:info];
      //  [self updatajianquan:homeAdress];
          [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_REGION object:_model];
        [self dismissViewControllerAnimated:YES completion:nil];
    
    } withfialedBlock:^(NSString *msg) {
        
    }];
}

//// 更新健全
//-(void)updatajianquan:(NSString *)homeAdress
//{
//    FELoginInfo *info=[LoginUtil getInfoFromLocal];
//    info.regionId=_model.regionId;
//    info.regionTitle=_model.regionTitle;
//    
//    NSString *str=@"020appd/goto/updatePersonal";
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:info.userId forKey:@"userId"];
//    
//    [dic setObject:info.regionId forKey:@"regionId"];
//    [dic setObject:homeAdress forKey:@"homeAdress"];
//    [dic setObject:[NSNumber numberWithInt:1] forKey:@"userType"];
//    
//    
//    [RYLoadingView showRequestLoadingView];
//    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
//        NSLog( @"更新健全1Dic--%@",dic);
//        
//    } withfialedBlock:^(NSString *msg) {
//        
//    }];
//
//}
//

//上传图片;
- (void)uploadImgAction
{
    NSMutableArray *imageArray=_photoArr;
    [imageArray removeLastObject];
    [RYLoadingView showRequestLoadingView];
    for (int i=0; i<imageArray.count; i++)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        NSNumber *index=[NSNumber numberWithInt:i];
        [dic setObject:index forKey:@"deedImageNum"];
        NSString *url=@"020appd/goto/uploadImage";
        
        [[FEBSAFManager sharedManager] POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            UIImage *image = imageArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            [formData appendPartWithFileData:imageData name:@"deedImage" fileName:fileName mimeType:@"image/jpeg"]; //
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"---上传进度--- %@",uploadProgress);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"```上传成功``` %@",responseObject);
            [RYLoadingView hideRequestLoadingView];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"xxx上传失败xxx %@", error);
            [RYLoadingView hideRequestLoadingView];
            
        }];
    }
}




-(void)PickerSelectorIndixString:(NSString *)str
{
    //取得某个cell元素
    UITableViewCell* cell = [self.addInfoTabView cellForRowAtIndexPath:self.selectedIndexPath] ;
    
    UILabel *lab=(UILabel *)[cell viewWithTag:10086];
    lab.text=str;
    
//    for (FERegionModel *model in _regionInfoArray) {
//        if ([model.regionTitle isEqual:str]) {
//            
//            _regionID=model.regionId;
//            
//            NSLog(@"这个小区的编号----%@ ",model.regionId);
//            break;
//            
//        }
//    }
    
    UILabel *lab2=(UILabel *)[cell viewWithTag:10010];
    lab2.text=str;
    
    
    
    NSLog(@"选择的----str--%@" ,str);
    
    
    
}


#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)showPhotoPicker
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photoArr.count >= 9) {
        return 9;
    }
    return self.photoArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"FEphotoCell";
    FEphotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImage *newImg = self.photoArr[indexPath.row];
    //需要等比例压缩图片
    UIImage *smImg = [RYImageTool createSmallPic:newImg];
    cell.imageView.image = smImg;
    cell.tag = 100 + indexPath.row;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photoArr.count-1 && self.photoArr.count != 9) {
        [self showPhotoPicker];
    }else{
        NSMutableArray *imgArr = [[NSMutableArray alloc] initWithArray:_photoArr];
        [imgArr removeLastObject];
        self.previewController = [[RYImagePreViewController alloc] initWithImg:_photoArr andIsPush:YES andIndex:indexPath.row];
        currentSelectNum = indexPath.row;
        self.previewController.delegate = self;
        [self.navigationController pushViewController:_previewController animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSInteger cout=self.photoArr.count;
    NSLog(@"%ld--个数--",cout);
    
    
    if (self.photoArr.count > 10)
    {
        NSLog(@"最多只能9张啊....");
        return;
    }
    
    for (int i=0; i<assets.count; i++) {
        
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.photoArr insertObject:tempImg atIndex:0];
        
        if (self.photoArr.count > 10) {
            break;
        }
        
        // NSLog(@"上传图片 %d",i);
        //[self uploadOneImgAction:tempImg];
    }
    
    CGFloat cviewHeightNum = cellWidth*(self.photoArr.count/5+1)+8;
    self.photoCollectionView.frame = CGRectMake(0,self.photoCollectionView.frame.origin.y,[UIScreen mainScreen].bounds.size.width,cviewHeightNum);
    [self.photoCollectionView reloadData];
    [_addInfoTabView reloadData];
    
    
    
}

-(void)showImagePickerToTakePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker
{
    
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.photoArr.count <= 10) {
        UIImage *tagImg = info[UIImagePickerControllerOriginalImage];
        [self.photoArr insertObject:tagImg atIndex:0];
        CGFloat cviewHeightNum = cellWidth*(self.photoArr.count/5+1)+8;
        self.photoCollectionView.frame = CGRectMake(0,self.photoCollectionView.frame.origin.y,[UIScreen mainScreen].bounds.size.width,cviewHeightNum);
        [self.photoCollectionView reloadData];
        //[self performSelectorInBackground:@selector(uploadOneImgAction:) withObject:tagImg];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark RYImagePreViewControllerDelegate
-(void)delPhotoByPreView:(RYImagePreViewController *)owner
{
    NSInteger currentIdx = owner.currentIndex-1;
    NSLog(@"删除第%ld张",currentIdx);
    UIImage *tgimg = self.photoArr[currentIdx];
    if (tgimg) {
        //如果上传完成的 需要移除对应的 url
        NSArray *allImgUrls = [_imageUrlArrDic allKeys];
        for (NSString *curImgUrl in allImgUrls) {
            UIImage *curImg = [_imageUrlArrDic objectForKey:curImgUrl];
            if ([tgimg isEqual:curImg]) {
                [_imageUrlArrDic removeObjectForKey:curImgUrl];
                break;
            }
        }
    }
    [self.photoArr removeObjectAtIndex:currentIdx];
    [self.photoCollectionView reloadData];
}



@end
