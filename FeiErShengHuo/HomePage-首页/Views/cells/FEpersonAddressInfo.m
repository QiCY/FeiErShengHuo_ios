//
//  FEpersonAddressInfo.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEpersonAddressInfo.h"

@implementation FEpersonAddressInfo

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    self.InfoTF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor clearColor] secureTextEntry:NO placeholder:@"" clearsOnBeginEditing:YES];
    [self.InfoTF FEInputTextFieldStyle];
    self.InfoTF.textAlignment=NSTextAlignmentLeft;
    self.InfoTF.backgroundColor=[UIColor whiteColor];
    self.InfoTF.layer.masksToBounds=YES;
    self.InfoTF.layer.cornerRadius=5;
    
    self.InfoTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.InfoTF.frame=CGRectMake(10, 20, MainW-20, 40);
    [self addSubview:self.InfoTF];
    
    
}


@end
