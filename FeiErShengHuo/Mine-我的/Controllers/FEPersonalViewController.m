//
//  FEPersonalViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEPersonalViewController.h"
#import "FEpersonalCell.h"
#import "LoginUtil.h"
#import "FERegionModel.h"
#import "FEChoseTypeViewController.h"

#import "JHPickView.h"

#define TABLEVIEW_OFFSET_Y 260
@interface FEPersonalViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,choseRegionDelegate,JHPickerDelegate>
{
    NSString *curnickname;
    NSString * curaeraStr;
    NSString *curmoible;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UIButton    *cameraBtn;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (assign,nonatomic) NSIndexPath* selectedIndexPath ;

@end

@implementation FEPersonalViewController


-(void)initView
{
    
    self.title=@"个人资料";
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(doModifyAction:) andType:item_finish];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainH-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
}

- (void)BtnClick
{
    [LoginUtil removeUserInfoFromlocal];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)doModifyAction:(UIButton *)sender
{
    
    [self .view endEditing:YES];
    curnickname=_nickNameTF.text;//cell0.rightTF.text;
    NSLog(@" 昵称 %@" ,curnickname);
    curaeraStr=_areaTF.text;
    NSLog(@" 区域 %@" ,curaeraStr);
    
    curmoible=_moblieTF.text;
    NSLog(@"  手机 %@" ,curmoible);
    
    FELoginInfo *logininfo=[[FELoginInfo alloc]init];
    logininfo.nickName=curnickname;
    //logininfo.district=curaeraStr;
    //logininfo.mobile=curmoible;
    
    NSString *Personstr=@"020appd/userInfo/updateUserInfo";
    NSMutableDictionary *Persondic=logininfo.mj_keyValues;
    //检查手机
    if (![CheckConfig checkMobileNumber:curmoible]) {
        return;
    }
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:Personstr withDictionary:Persondic withSuccessBlock:^(NSDictionary *dic) {
        [FENavTool showAlertViewByAlertMsg:@"修改成功" andType:@"提示"];
        
        FELoginInfo *info=[LoginUtil getInfoFromLocal];
        info.nickName=curnickname;
        [LoginUtil saveing:info];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } withfialedBlock:^(NSString *msg) {
    }];
}

-(void)upDateHeadfile:(NSData *)imagedata
{
    NSString *basestr=@"020appd/userInfo/uploadfile";
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] POST:basestr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        [formData appendPartWithFileData:imagedata name:@"headImg" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        [RYLoadingView hideRequestLoadingView];
        if ([responseObject[@"code"]isEqualToString:@"1"]) {
            [FENavTool showAlertViewByAlertMsg:@"修改头像成功" andType:@"提示"];
            NSString *  headurl=responseObject[@"finallyPath"];
            FELoginInfo *info=[LoginUtil getInfoFromLocal];
            info.avatar=headurl;
            [LoginUtil saveing:info];
            //[_photoImgView sd_setImageWithURL:[NSURL URLWithString:headurl]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"xxx上传失败xxx %@", error);
        [RYLoadingView hideRequestLoadingView];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
        
    }
    
    if (section==1) {
        return 1;
        
    }
    
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 96;
    }else{
        return 8.f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 96)];
        secView.backgroundColor = [UIColor whiteColor];
        
        
        FELoginInfo * curnfo=[LoginUtil getInfoFromLocal];
        NSString *headurlStr=curnfo.avatar;
        
        self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        
        if (curnfo.avatar.length==0||[curnfo.avatar isEqualToString:@""]) {
            [_photoImgView setImage:[UIImage imageNamed:@"pic"]];
            
        }else{
            [_photoImgView sd_setImageWithURL:[NSURL URLWithString:headurlStr]];
            
        }
        _photoImgView.layer.cornerRadius = 32;
        _photoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImgView.layer.masksToBounds = YES;
        _photoImgView.center = CGPointMake(MainW/2, 48);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doChoosePhoto)];
        [_photoImgView addGestureRecognizer:tap];
        _photoImgView.userInteractionEnabled = YES;
        [secView addSubview:_photoImgView];
        
        self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setFrame:CGRectMake(0, 0, 24, 24)];
        [_cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(doChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.center = CGPointMake(MainW/2+20, 48+20);
        [secView addSubview:_cameraBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, MainW, 1)];
        lineView.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
        [secView addSubview:lineView];
        
        return secView;
    }else{
        UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 8)];
        secView.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
        return secView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
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
        
        FELoginInfo  *info=[LoginUtil getInfoFromLocal];
        if (indexPath.section==0) {
            
            if (indexPath.row==0) {
                //昵称
                _nickNameTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_nickNameTF FEInputTextFieldStyle];
                _nickNameTF.delegate = self;
                _nickNameTF.tag=10086;
                
                _nickNameTF.text = info.nickName;
                
                
                [cell addSubview:_nickNameTF];
            }
            if (indexPath.row==1) {
                //区域
                _areaTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_areaTF FEInputTextFieldStyle];
                _areaTF.delegate = self;
                _areaTF.tag=10087;
                
                _areaTF.text=info.regionTitle;
                [cell addSubview:_areaTF];
                
                
            }
            if (indexPath.row==2) {
                //手机号码
                _moblieTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW-66, 18)];
                [_moblieTF FEInputTextFieldStyle];
                _moblieTF.delegate = self;
                _moblieTF.text = info.mobile;
                _moblieTF.tag=10088;
                [cell addSubview:_moblieTF];
            }
        }
        if (indexPath.section==1) {
            
            
            if (indexPath.row==0) {
                UIButton *redBnt=[MYUI creatButtonFrame:CGRectMake(MainW/2-(MainW-60)/2, 4, MainW-60, 40) backgroundColor:[UIColor redColor] setTitle:@"退出登录" setTitleColor:[UIColor whiteColor]];
                redBnt.layer.cornerRadius=5;
                redBnt.layer.masksToBounds=YES;
                [redBnt addTarget:self action:@selector(BtnClick ) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:redBnt];
            }
            
        }
        
        
    }
    NSArray *baseArray=@[@"昵称",@"小区",@"手机号码"];
    
    UILabel *ttlbl = (UILabel *)[cell viewWithTag:1001];
    if (indexPath.section==0) {
        ttlbl.text=baseArray[indexPath.row];
        
    }
    
    return cell;
}


-(void)doChoosePhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"本地相册", @"用户相机", nil];
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (buttonIndex == 2) {
            return;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        if (buttonIndex == 0) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else if(buttonIndex == 1) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
}
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *parentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _photoImgView.image = parentImage;
    
    // 调用下面的保存方法
   // [self saveImage:parentImage withName:@"currentImage.png"];
    
    //判断是否修改了头像
    NSData *imgData = UIImageJPEGRepresentation(self.photoImgView.image, 0.2);
    if (imgData.length > 0) {
        //文件流上传
        [self upDateHeadfile:imgData];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    //判断是否是联系方式的输入框
    if (textField.text.length <= 0) {
        //恢复原来内容
        [self updateTextFielData];
    }
    
}

-(void)updateTextFielData
{
    FELoginInfo  *info=[LoginUtil getInfoFromLocal];
    if (info.nickName.length) {
        _nickNameTF.text=info.nickName;
        
    }
    if (info.district.length) {
        _areaTF.text=info.district;
        
    }
    if (info.mobile.length) {
        _moblieTF.text=info.mobile;
        
    }
    
}



@end
