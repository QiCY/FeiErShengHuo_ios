//
//  FEPublishController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEPublishController.h"
#import "FEphotoCell.h"
//#import "RYPhotoCollectionViewCell.h"
#import "FENeighborViewController.h"

@interface FEPublishController ()

{
    NSNumber *snsId;
}
@end

@implementation FEPublishController

- (void)initView
{
    self.title = @"发布见闻";
    self.view.backgroundColor = [UIColor whiteColor];
    self.photoArr = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"icon_addpic"], nil];
    self.imageUrlArrDic = [[NSMutableDictionary alloc] init];
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(doPublishAction:) andType:item_publish];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainW, MainH - 48 - 64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    //添加textview
    [self addinputTextView];
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
    CGFloat offY = self.textView.frame.origin.y + self.textView.frame.size.height + 16;
    CGFloat cviewHeightNum = cellWidth * (self.photoArr.count / 5 + 1) + 8;
    self.photoCollectionView.frame = CGRectMake(0, offY, MainH, cviewHeightNum);
    [self.scrollView addSubview:self.photoCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [RYLoadingView hideRequestLoadingView];
    [self.textView resignFirstResponder];
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];
    CGRect curRect = CGRectMake(0, MainH - 48, MainW, 48);
    CGRect curScRect = CGRectMake(0, 64, MainW, MainH - 112);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    curScRect.size.height = MainH - 112 - keyboardRect.size.height;
    curRect.origin.y -= keyboardRect.size.height;
    self.scrollView.frame = curScRect;
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];

    self.scrollView.frame = CGRectMake(0, 64, MainW, MainH - 112);
    [UIView commitAnimations];
}
- (void)addinputTextView
{
    self.textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(8, 0, MainW - 16, 40)];
    _textView.isScrollable = NO;
    _textView.minNumberOfLines = 1;
    _textView.maxNumberOfLines = 5;
    _textView.maxHeight = MainH - 120;
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.placeholder = @"有什么好玩的想告诉大家？";
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.scrollView addSubview:_textView];
}

- (void)doBackAction:(UIButton *)sender
{
    [self.textView resignFirstResponder];
    NSString *pubTxt = [_textView getInputTextString];
    NSArray *imgUrlArr = [self.imageUrlArrDic allKeys];
    if (pubTxt.length > 0 || imgUrlArr.count > 0)
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"确定放弃编辑发布动态吗？"];
        [alertView addButtonWithTitle:@"取消"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView){
                              }];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDelete
                              handler:^(SIAlertView *alertView) {
                                [self.navigationController popViewControllerAnimated:YES];
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleFade;
        [alertView show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)doPublishAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    //  监测网络
    [ZSLNetworkConnect checkNetcompletion:^(BOOL ok) {
        if (!ok) {
            [self hideKeyBoard];
            return;
        }
    }];
    
    
    NSString *pubTxt = [_textView getInputTextString];
    if ((pubTxt.length <= 0 || [pubTxt isEmptyAfterTrimmingWhitespaceAndNewlineCharacters]) && _photoArr.count <= 0)
    {
        [self.view endEditing:YES];
        [FENavTool showAlertViewByAlertMsg:@"请输入您发布的内容！" andType:@"提示"];
        return;
    }
    //开启线程
    WeakSelf;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      StrongSelf;
      //分线程耗时上传
      [strongSelf uploadText];

    });
}

//上传文字
- (void)uploadText
{
    NSString *pubTxt = [_textView getInputTextString];
    NSString *str = @"020appd/community/publishNews";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:pubTxt forKey:@"content"];
    [RYLoadingView showRequestLoadingView];
    
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     snsId = dic[@"xcommunityShow2"][@"snsId"];
                                                     [FENavTool showAlertViewByAlertMsg:@"发布成功" andType:@"提示"];
                                                     [self hideKeyBoard];
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

        [dic setObject:snsId forKey:@"snsId"];
        NSNumber *index = [NSNumber numberWithInt:i];
        [dic setObject:index forKey:@"numImage"];
        NSString *url = @"020appd/community/uploadImage";

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
              [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"image/jpeg"]; //
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

                    //主线程刷新界面
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_DYNAMIC object:nil];

                    for (UIViewController *ctl in strongSelf.navigationController.viewControllers)
                    {
                        if ([ctl isKindOfClass:[FENeighborViewController class]])
                        {
                            //for循环找到后做操作 结束循环
                            [strongSelf.navigationController popToViewController:ctl animated:YES];
                            return;
                        }
                    }
                  });
              }

            }
            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              NSLog(@"xxx上传失败xxx %@", error);
              [RYLoadingView hideRequestLoadingView];

            }];
    }
}

- (void)hideKeyBoard
{
    [self.textView resignFirstResponder];
    [UIView setAnimationDuration:0.3];

    self.scrollView.frame = CGRectMake(0, 64, MainW, MainH - 112);
    [UIView commitAnimations];
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
#pragma mark HPGrowingTextViewDelegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = height - growingTextView.frame.size.height;
    CGRect coRect = self.photoCollectionView.frame;
    coRect.origin.y += diff;
    self.photoCollectionView.frame = coRect;
    if (height > _scrollView.frame.size.height - coRect.size.height)
    {
        self.scrollView.contentSize = CGSizeMake(MainW, _scrollView.frame.size.height + height);
    }
    else
    {
        self.scrollView.contentSize = CGSizeMake(MainW, _scrollView.frame.size.height);
    }
}

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
}

//下面这段搞定键盘关闭。点return 果断关闭键盘
- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //判断 是否超过上限
    if (growingTextView.text.length - range.length + text.length > 500)
    {
        return NO;
    }
    return YES;
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

    //
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //                dispatch_async(dispatch_get_main_queue(), ^{
    //                   });
    //    });
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
