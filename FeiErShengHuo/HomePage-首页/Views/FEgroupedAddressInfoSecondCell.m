//
//  FEgroupedAddressInfoSecondCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEgroupedAddressInfoSecondCell.h"

@implementation FEgroupedAddressInfoSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    self.leftLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.leftLab.frame=CGRectMake(10, 0, MainW/3, 47);
    [self addSubview:self.leftLab];
    
    self.rightTF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor clearColor] secureTextEntry:NO placeholder:@"" clearsOnBeginEditing:YES];
    [self.rightTF FEInputTextFieldStyle];
    self.rightTF.textAlignment=NSTextAlignmentLeft;
    self.rightTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.rightTF.frame=CGRectMake(MainW/3+10, 0, MainW/3*2-30, 47);
    [self addSubview:self.rightTF];
}

@end
