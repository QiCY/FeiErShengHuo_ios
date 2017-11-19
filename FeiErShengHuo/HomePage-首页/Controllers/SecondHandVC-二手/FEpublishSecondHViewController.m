//
//  FEpublishSecondHViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEpublishSecondHViewController.h"

@interface FEpublishSecondHViewController () < UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ZYQAssetPickerControllerDelegate, RYImagePreViewControllerDelegate, UITextViewDelegate >
{
    CGFloat cellWidth;
    NSInteger currentSelectNum;
    NSNumber *_regionID;
}
@property (nonatomic, strong) UITableView *publishTabView;
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSMutableArray *regionArray;
@property (nonatomic, strong) NSMutableArray *regionInfoArray;

@end

@implementation FEpublishSecondHViewController

- (void)initView
{
    self.photoArr = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"icon_addpic"], nil];

    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(publishSecondClick) andType:item_publish];
    self.title = @"发布闲置";
    self.publishTabView = [UITableView groupTableView];
    self.publishTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.publishTabView.delegate = self;
    self.publishTabView.dataSource = self;
    self.publishTabView.sectionHeaderHeight = 0.01;
    self.publishTabView.sectionFooterHeight = 0.01;
    self.publishTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.publishTabView.tableHeaderView = view;
    [self.view addSubview:self.publishTabView];
}

- (void)publishSecondClick
{
    //    //开启线程
    WeakSelf;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      StrongSelf;

      //分线程耗时上传
      [strongSelf uploadText];

    });
}

- (void)uploadText
{
    //_originPriceTF.text  _nowPriceTF.text
    NSString *str = @"020appd/ershou/fabubaobao";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:_conectMoblieTF.text forKey:@"mobile"];
    [dic setObject:_qulityTF.text forKey:@"quality"];
    [dic setObject:_textView.text forKey:@"goodsContent"];
    [dic setObject:[NSNumber numberWithInt:[_originPriceTF.text intValue] * 100] forKey:@"orginPrice"];
    [dic setObject:[NSNumber numberWithInt:[_nowPriceTF.text intValue] * 100] forKey:@"sellPrice"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"transaction"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSNumber *secondhandId = dic[@"secondHandId"];

                                                     if (_photoArr.count < 2)
                                                     {
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                         return;
                                                     }

                                                     NSLog(@"文字上传成功---%@", dic);
                                                     [self uploadOneImgAction:secondhandId];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

//上传图片;
- (void)uploadOneImgAction:(NSNumber *)seocondHandId
{
    NSMutableArray *imageArray = _photoArr;
    [imageArray removeLastObject];
    [RYLoadingView showRequestLoadingView];

    for (int i = 0; i < imageArray.count; i++)
    {
        NSMutableDictionary *dic =@{}.mutableCopy;

        [dic setObject:seocondHandId forKey:@"secondHandId"];
        NSNumber *index = [NSNumber numberWithInt:i];
        [dic setObject:index forKey:@"numMarketImage"];
        NSString *url = @"020appd/ershou/shangtu";

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
              [formData appendPartWithFileData:imageData name:@"imageMarket" fileName:fileName mimeType:@"image/jpeg"]; //
            }
            progress:^(NSProgress *_Nonnull uploadProgress) {

              NSLog(@"---上传进度--- %@", uploadProgress);

            }
            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {

              NSLog(@"```上传成功``` %@", responseObject);
              [RYLoadingView hideRequestLoadingView];

              if (i == imageArray.count - 1)
              {
                  //刷新
                  WeakSelf;

                  dispatch_async(dispatch_get_main_queue(), ^{
                    StrongSelf;

                    //主线程刷新界面
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_DYNAMIC_SECONDHAND object:nil];
                    [strongSelf.navigationController popViewControllerAnimated:YES];

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
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    secView.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
            return 10 + cviewHeightNum;
        }
        if (indexPath.row == 1)
        {
            return 120;
        }
        return 50;
    }

    return 0;
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

        //title label
       
        
        UILabel *titLbl =[MYUI createLableFrame:CGRectMake(10, 10, MainW/2, 40) backgroundColor:[UIColor whiteColor] text:@"" textColor:GLOBAL_BIG_FONT_COLOR font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO insert:UIEdgeInsetsMake(0, 10, 0, 0)];
        titLbl.layer.masksToBounds=YES;
        titLbl.backgroundColor=[UIColor whiteColor];
        titLbl.tag = 1001;
        if (indexPath.row==0||indexPath.row==1) {
            titLbl.hidden=YES;
        
        }
        
        [cell addSubview:titLbl];
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                //初始化 选择照片的 瀑布流
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
            if (indexPath.row == 1)
            {
                _textView = [[YHJTextView alloc] initWithFrame:CGRectMake(10, 0, MainW - 20, 120)];
                _textView.backgroundColor = [UIColor whiteColor];
                _textView.delegate = self;
                _textView.tag = 10087;

                _textView.myPlaceholder = @"描述一下宝贝";
                _textView.font = [UIFont systemFontOfSize:14];
                _textView.myPlaceholderColor = [UIColor lightGrayColor];
                _textView.returnKeyType = UIReturnKeyDone;
                _textView.keyboardType = UIKeyboardTypeDefault;
                [cell addSubview:_textView];
            }
            if (indexPath.row == 2)
            {
                //原价
                
                _originPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(MainW / 2, 10, MainW/2-10, 40)];
                _originPriceTF.backgroundColor=[UIColor whiteColor];
                
                [_originPriceTF FEInputTextFieldStyle];
                _originPriceTF.delegate = self;
                _originPriceTF.textAlignment = NSTextAlignmentLeft;
                //_unitNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_originPriceTF];
            }
            if (indexPath.row == 3)
            {
                //现价
                _nowPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(MainW / 2, 10, MainW - 66, 40)];
                [_nowPriceTF FEInputTextFieldStyle];
                _nowPriceTF.textAlignment = NSTextAlignmentLeft;
                _nowPriceTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_nowPriceTF];
            }

            if (indexPath.row == 4)
            {
                //新旧程度
                _qulityTF = [[UITextField alloc] initWithFrame:CGRectMake(MainW / 2, 10, MainW - 66, 40)];
                [_qulityTF FEInputTextFieldStyle];
                _qulityTF.textAlignment = NSTextAlignmentLeft;
                _qulityTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_qulityTF];
            }

            if (indexPath.row == 5)
            {
                //联系人
                _conectPeopleTF = [[UITextField alloc] initWithFrame:CGRectMake(MainW / 2, 10, MainW - 66, 40)];
                [_conectPeopleTF FEInputTextFieldStyle];
                _conectPeopleTF.textAlignment = NSTextAlignmentLeft;
                _conectPeopleTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_conectPeopleTF];
            }
            if (indexPath.row == 6)
            {
                //电话
                _conectMoblieTF = [[UITextField alloc] initWithFrame:CGRectMake(MainW / 2, 10, MainW - 66, 40)];
                [_conectMoblieTF FEInputTextFieldStyle];
                _conectMoblieTF.textAlignment = NSTextAlignmentLeft;
                _conectMoblieTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                [cell addSubview:_conectMoblieTF];
            }
        }
    }
    NSArray *regionarray = @[ @"", @"", @"原价", @"转让价", @"新旧程度", @"联系人", @"电话" ];
    UILabel *ttlbl = (UILabel *)[cell viewWithTag:1001];
    if (indexPath.section == 0)
    {
        ttlbl.text = regionarray[indexPath.row];
    }
    return cell;
}

#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    NSInteger cout = self.photoArr.count;
    NSLog(@"%ld--个数--", cout);

    if (self.photoArr.count > 10)
    {
        NSLog(@"最多只能9张啊....");
        return;
    }

    for (int i = 0; i < assets.count; i++)
    {
        ALAsset *asset = assets[i];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.photoArr insertObject:tempImg atIndex:0];

        if (self.photoArr.count > 10)
        {
            break;
        }

        // NSLog(@"上传图片 %d",i);
        //[self uploadOneImgAction:tempImg];
    }

    CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
    self.photoCollectionView.frame = CGRectMake(0, self.photoCollectionView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, cviewHeightNum);
    [self.photoCollectionView reloadData];
    [_publishTabView reloadData];
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

@end
