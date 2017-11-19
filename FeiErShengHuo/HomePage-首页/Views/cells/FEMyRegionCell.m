//
//  FEMyRegionCell.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyRegionCell.h"

@implementation FEMyRegionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    _RegionNameLab=[MYUI createLableFrame:CGRectMake(10, 0, MainW-80, 40) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.RegionNameLab];
    
    
    _BuldingLab=[MYUI createLableFrame:CGRectMake(10, 40, MainW-80, 40) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.BuldingLab];
    
    
    _stusLab=[MYUI createLableFrame:CGRectMake(MainW-80, 40-10, 80, 20) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.stusLab];

}
-(void)setModel:(FEMyRegionModel *)model
{
    self.RegionNameLab.text=model.homeAdress;
    self.BuldingLab.text=model.buildingInfo;
    if ([model.vaildata isEqualToNumber:[NSNumber numberWithInt:0]]) {
        self.stusLab.text=@"未审核";
        self.stusLab.textColor=[UIColor redColor];
        
        
    }
    else
    {
        self.stusLab.text=@"已审核";
        self.stusLab.textColor=Green_Color;
        
        
    }
}



@end
