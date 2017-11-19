//
//  FEWriteRepairViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEWriteRepairViewController.h"
#import "FEAdviceTypeViewController.h"
#import "FERepairTypeViewController.h"
#import "FEadviceModel.h"
#import "FEphotoCell.h"
#import "STPopupController.h"
#import "YHJTextView.h"

@interface FEWriteRepairViewController () < UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, choseDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ZYQAssetPickerControllerDelegate, UINavigationControllerDelegate,
HPGrowingTextViewDelegate, UIImagePickerControllerDelegate, RYImagePreViewControllerDelegate >
{
    UILabel *Lab1;
    UILabel *lab2;
    NSNumber *_repaireId;
    
    UILabel *lab;
    
    UILabel *AdressLab;
    UILabel *TypeLab;
    NSNumber *_xcommunityTypeId;
    YHJTextView *textView2;
    YHJTextView *textView3;
}
@property (nonatomic, strong) UITableView *writeAdViceTab;
@property (nonatomic, strong) YHJTextView *textView;
@property (nonatomic, strong) UICollectionView *photoCollectionView;

@end

@implementation FEWriteRepairViewController

- (void)initView
{
    self.title = @"在线报修";
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(publish) andType:item_publish];
    
    self.photoArr = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"icon_addpic"], nil];
    self.writeAdViceTab = [UITableView groupTableView];
    self.writeAdViceTab.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.writeAdViceTab.delegate = self;
    self.writeAdViceTab.dataSource = self;
    self.writeAdViceTab.sectionHeaderHeight = 0.01;
    self.writeAdViceTab.sectionFooterHeight = 0.01;
    //self.writeAdViceTab.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.writeAdViceTab.tableHeaderView = view;
    [self.view addSubview:self.writeAdViceTab];
}

//上传
- (void)publish
{
    //取得某个cell元素
    NSIndexPath *inexPath1 = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell = [_writeAdViceTab cellForRowAtIndexPath:inexPath1];
    lab = (UILabel *)[cell viewWithTag:10086];
    
    NSIndexPath *inexPath2 = [NSIndexPath indexPathForRow:0 inSection:2];
    UITableViewCell *cell2 = [_writeAdViceTab cellForRowAtIndexPath:inexPath2];
    textView2 = (YHJTextView *)[cell2 viewWithTag:10087];
    
    NSIndexPath *inexPath3 = [NSIndexPath indexPathForRow:0 inSection:3];
    UITableViewCell *cell3 = [_writeAdViceTab cellForRowAtIndexPath:inexPath3];
    textView3 = (YHJTextView *)[cell3 viewWithTag:10088];
    
    if ([TypeLab.text isEqualToString:@"  请选择类型"])
    {
        [FENavTool showAlertViewByAlertMsg:@"请选择类型！" andType:@"提示"];
        return;
    }
    if (textView2.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请描述报修内容！" andType:@"提示"];
        return;
    }
    if (textView3.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请填写您希望物业怎么做！" andType:@"提示"];
        return;
    }
    //开启线程
    WeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        StrongSelf;
        //分线程耗时上传
        [strongSelf textrequest];
        
    });
}

- (void)reload
{
//    FEadviceModel *model = [[FEadviceModel alloc] init];
//    model.categoryName = lab.text;
//    model.adviceContent = textView2.text;
//    model.adviceResolve = @"未处理";
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *DateTime = [formatter stringFromDate:date];
//    NSLog(@"%@============年-月-日  时：分：秒=====================", DateTime);
//    model.adviceCreateTimeStr = DateTime;
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_REPAIR object:model];
    //
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textrequest
{
    //    //上传设备标识别
    NSString *registrationID = [[NSUserDefaults standardUserDefaults] objectForKey:DeviceKey];
    NSString *str = @"020appd/repaire/repaireInfo";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:_xcommunityTypeId forKey:@"xcommunityTypeId"];
    [dic setObject:textView2.text forKey:@"repaireContent"];
    [dic setObject:textView3.text forKey:@"repaireRequirement"];
    [dic setObject:registrationID forKey:@"regionrationId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       NSLog(@" 发布 文字建议----%@", dic);
                                                       _repaireId = dic[@"repaireId"];
                                                       [FENavTool showAlertViewByAlertMsg:@"发布成功" andType:@"提示"];
                                                       [self.view endEditing:YES];
                                                       
                                                       if (_photoArr.count < 2)
                                                       {
                                                           [self.navigationController popViewControllerAnimated:YES];
                                                           return;
                                                       }
                                                       
                                                       [self uploadOneImgAction];
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}
//上传图片;
- (void)uploadOneImgAction
{
    NSMutableArray *imageArray = _photoArr;
    
    [imageArray removeLastObject];
    
    [RYLoadingView showRequestLoadingView];
    for (int i = 0; i < imageArray.count; i++)
    {
        NSMutableDictionary *dic =@{}.mutableCopy;
        [dic setObject:_repaireId forKey:@"repaireId"];
        NSNumber *index = [NSNumber numberWithInt:i];
        [dic setObject:index forKey:@"numRepaireImage"];
        NSString *url = @"020appd/repaire/publishImages";
        
        [[FEBSAFManager sharedManager] POST:url
                                 parameters:dic
                  constructingBodyWithBlock:^(id< AFMultipartFormData > _Nonnull formData) {
                      
                      UIImage *image = imageArray[i];
                      NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                      // 设置时间格式
                      [formatter setDateFormat:@"yyyyMMddHHmmss"];
                      NSString *dateString = [formatter stringFromDate:[NSDate date]];
                      NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateString];
                      [formData appendPartWithFileData:imageData name:@"imageRepaire" fileName:fileName mimeType:@"image/jpeg"]; //
                  }
                                   progress:^(NSProgress *_Nonnull uploadProgress) {
                                       NSLog(@"---上传进度--- %@", uploadProgress);
                                   }
                                    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                                        NSLog(@"```上传成功``` %@", responseObject);
                                        [RYLoadingView hideRequestLoadingView];
                                        if (i == imageArray.count - 1)
                                        {
                                            WeakSelf;
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                StrongSelf;
                                                
                                                [strongSelf reload];
                                            });
                                        }
                                    }
                                    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                                        NSLog(@"xxx上传失败xxx %@", error);
                                        [RYLoadingView hideRequestLoadingView];
                                    }];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 9)];
    secView.backgroundColor = [UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = cellWidth * (self.photoArr.count / 5 + 1) + 8;
    switch (indexPath.section)
    {
        case 0:
            return 80;
            break;
            
        case 1:
            return 80;
            
            break;
        case 2:
            return 120;
            
            break;
        case 3:
            return 120;
            
            break;
        case 4:
            return height + 20;
            
            break;
            
        default:
            break;
    }
    return 0;
}
//选择类型
- (void)choseTypeClick
{
    FERepairTypeViewController *VC = [[FERepairTypeViewController alloc] init];
    VC.delegate = self;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:VC];
    popupController.style = STPopupStyleBottomSheet;
    popupController.navigationBarHidden = YES;
    [popupController presentInViewController:self];
}
- (void)chosetype:(NSString *)type andID:(NSNumber *)xcommunityTypeId
{
    //取得某个cell元素
    NSIndexPath *inexPath0 = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell = [_writeAdViceTab cellForRowAtIndexPath:inexPath0];
    UILabel *labX = (UILabel *)[cell viewWithTag:10086];
    labX.text = type;
    _xcommunityTypeId = xcommunityTypeId;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.section)
        {
            case 0:
                if (indexPath.row == 0)
                {
                    Lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainW / 2, 20)];
                    Lab1.font = [UIFont systemFontOfSize:15];
                    Lab1.textAlignment = NSTextAlignmentLeft;
                    Lab1.text = @"您要报修的小区是";
                    [cell addSubview:Lab1];
                    
                    AdressLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(Lab1.frame) + 5, MainW - 20, 40)];
                    FELoginInfo *info = [LoginUtil getInfoFromLocal];
                    AdressLab.text = [NSString stringWithFormat:@"   %@", info.regionTitle];
                    AdressLab.font = [UIFont systemFontOfSize:15];
                    AdressLab.backgroundColor = [UIColor whiteColor];
                    AdressLab.textColor = [UIColor colorWithHexString:@"#727272"];
                    AdressLab.layer.cornerRadius = 5;
                    AdressLab.layer.masksToBounds = YES;
                    [cell addSubview:AdressLab];
                }
                break;
            case 1:
                if (indexPath.row == 0)
                {
                    lab2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainW / 2, 20)];
                    lab2.font = [UIFont systemFontOfSize:15];
                    lab2.textAlignment = NSTextAlignmentLeft;
                    lab2.text = @"类型";
                    [cell addSubview:lab2];
                    TypeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lab2.frame) + 5, MainW - 20, 40)];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseTypeClick)];
                    [TypeLab addGestureRecognizer:tap];
                    TypeLab.backgroundColor = [UIColor whiteColor];
                    TypeLab.text = @"  请选择类型";
                    TypeLab.tag = 10086;
                    
                    TypeLab.textColor = [UIColor colorWithHexString:@"#727272"];
                    
                    TypeLab.userInteractionEnabled = YES;
                    TypeLab.font = [UIFont systemFontOfSize:15];
                    TypeLab.layer.cornerRadius = 5;
                    TypeLab.layer.masksToBounds = YES;
                    
                    [cell addSubview:TypeLab];
                }
                break;
            case 2:
                if (indexPath.row == 0)
                {
                    _textView = [[YHJTextView alloc] initWithFrame:CGRectMake(10, 0, MainW - 20, 110)];
                    _textView.backgroundColor = [UIColor whiteColor];
                    _textView.delegate = self;
                    _textView.tag = 10087;
                    
                    _textView.myPlaceholder = @"请描述报修内容";
                    _textView.font = [UIFont systemFontOfSize:14];
                    _textView.myPlaceholderColor = [UIColor lightGrayColor];
                    _textView.returnKeyType = UIReturnKeyDone;
                    _textView.keyboardType = UIKeyboardTypeDefault;
                    _textView.layer.cornerRadius = 5;
                    _textView.layer.masksToBounds = YES;
                    
                    [cell addSubview:_textView];
                }
                
                break;
            case 3:
                if (indexPath.row == 0)
                {
                    _textView = [[YHJTextView alloc] initWithFrame:CGRectMake(10, 5, MainW - 20, 110)];
                    _textView.backgroundColor = [UIColor whiteColor];
                    _textView.delegate = self;
                    _textView.tag = 10088;
                    _textView.myPlaceholder = @"您希望物业怎么做";
                    _textView.font = [UIFont systemFontOfSize:14];
                    _textView.myPlaceholderColor = [UIColor lightGrayColor];
                    _textView.returnKeyType = UIReturnKeyDone;
                    _textView.keyboardType = UIKeyboardTypeDefault;
                    _textView.layer.cornerRadius = 5;
                    _textView.layer.masksToBounds = YES;
                    
                    [cell addSubview:_textView];
                }
                
                break;
            case 4:
                
                if (indexPath.row == 0)
                {
                        UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
                        [clay setMinimumLineSpacing:8];
                        clay.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
                        self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:clay];
                        self.photoCollectionView.delegate = self;
                        self.photoCollectionView.dataSource = self;
                        self.photoCollectionView.backgroundColor = [UIColor clearColor];
                        self.photoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                        [self.photoCollectionView registerClass:NSClassFromString(@"FEphotoCell") forCellWithReuseIdentifier:@"FEphotoCell"];
                        
                        CGFloat widNum = MainW - 5 * 8;
                        cellWidth = widNum / 4;
                        CGFloat offY = 10;
                        CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
                        self.photoCollectionView.frame = CGRectMake(0, offY, MainH, cviewHeightNum);
                        [cell addSubview:self.photoCollectionView];
                }
                break;
            default:
                break;
        }
    }
    return cell;
}
- (void)showPhotoPicker
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
        {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        }
        else
        {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark-- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photoArr.count >= 9)
    {
        return 9;
    }
    return self.photoArr.count;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FEphotoCell";
    FEphotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImage *newImg = self.photoArr[indexPath.row];
    //需要等比例压缩图片
    UIImage *smImg = [RYImageTool createSmallPic:newImg];
    cell.imageView.image = smImg;
    cell.tag = 100 + indexPath.row;
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
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

#pragma mark--UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photoArr.count - 1 && self.photoArr.count != 9)
    {
        [self showPhotoPicker];
    }
    else
    {
        NSMutableArray *imgArr = [[NSMutableArray alloc] initWithArray:_photoArr];
        [imgArr removeLastObject];
        self.previewController = [[RYImagePreViewController alloc] initWithImg:_photoArr andIsPush:YES andIndex:indexPath.row];
        currentSelectNum = indexPath.row;
        self.previewController.delegate = self;
        [self.navigationController pushViewController:_previewController animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (self.photoArr.count >= 10)
    {
        NSLog(@"最多只能9张啊....");
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < assets.count; i++)
        {
            if (self.photoArr.count >= 10)
            {
                break;
            }
            
            ALAsset *asset = assets[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [self.photoArr insertObject:tempImg atIndex:0];
            // NSLog(@"上传图片 %d",i);
            //[self uploadOneImgAction:tempImg];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
            self.photoCollectionView.frame = CGRectMake(0, self.photoCollectionView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, cviewHeightNum);
            [self.photoCollectionView reloadData];
        });
    });
}

- (void)showImagePickerToTakePhoto
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker
{
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.photoArr.count <= 10)
    {
        UIImage *tagImg = info[UIImagePickerControllerOriginalImage];
        [self.photoArr insertObject:tagImg atIndex:0];
        CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
        self.photoCollectionView.frame = CGRectMake(0, self.photoCollectionView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, cviewHeightNum);
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
- (void)delPhotoByPreView:(RYImagePreViewController *)owner
{
    NSInteger currentIdx = owner.currentIndex - 1;
    NSLog(@"删除第%ld张", currentIdx);
    UIImage *tgimg = self.photoArr[currentIdx];
    if (tgimg)
    {
        //如果上传完成的 需要移除对应的 url
        NSArray *allImgUrls = [_imageUrlArrDic allKeys];
        for (NSString *curImgUrl in allImgUrls)
        {
            UIImage *curImg = [_imageUrlArrDic objectForKey:curImgUrl];
            if ([tgimg isEqual:curImg])
            {
                [_imageUrlArrDic removeObjectForKey:curImgUrl];
                break;
            }
        }
    }
    [self.photoArr removeObjectAtIndex:currentIdx];
    [self.photoCollectionView reloadData];
}

#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

@end
