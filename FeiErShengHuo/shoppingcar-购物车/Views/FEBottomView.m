//
//  FEBottomView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBottomView.h"

@implementation FEBottomView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        _AllSelected=NO;
        _selectAllBtn=[MYUI creatButtonFrame:CGRectMake(10, 44/2-10, 20, 20) setBackgroundImage:[UIImage imageNamed:@"check_box_nor"]];
        _selectAllBtn.layer.masksToBounds=YES;
        _selectAllBtn.layer.cornerRadius=5;
        _selectAllBtn.selected=NO;
        [_selectAllBtn addTarget: self action:@selector(choseAllClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.selectAllBtn];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_selectAllBtn.frame),5,40 , 34)];
        lab.text=@"全选";
        [self addSubview:lab];
        
        _totalPriceLab=[MYUI createLableFrame:CGRectMake(MainW/3, 0, MainW/3, 44) backgroundColor:[UIColor whiteColor] text:@"合计¥" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];

        _totalPriceLab.attributedText=[FENavTool String:@"合计¥0.00" RangeString:[NSString stringWithFormat:@"¥0.00"]  RangeColor:[UIColor orangeColor]];
        [self addSubview:self.totalPriceLab];
        
        _totalNumBtn=[MYUI creatButtonFrame:CGRectMake(CGRectGetMaxX(_totalPriceLab.frame), 0, MainW/3, 44) backgroundColor:[UIColor orangeColor] setTitle:@"结算（）" setTitleColor:[UIColor whiteColor]];
        
        
        [self addSubview:_totalNumBtn];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Refresh:) name:@"BottomRefresh" object:nil];

        
    }
    return self;
    
}

-(void)init:(NSDictionary *)dict GoodsData:(NSMutableArray *)goods
{
    


}

-(void)setMoney:(NSMutableArray *)goodsModels
{
   
    int index1 = 0;
    int index2 = 0;
    CGFloat goodsSum = 0.00;
    for (int i=0; i<goodsModels.count; i++) {
        index1++;
        FECarGoodsModel *goodModel=goodsModels[i];
        
        if ([goodModel.isChose isEqualToString:@"1"]) {
            index2++;
            CGFloat product;
            int baiPrice=[goodModel.marketPrice intValue];
            CGFloat Price = baiPrice/100.0;
            NSInteger num=[goodModel.total integerValue];
            product=Price*num;
            //累计
            goodsSum = goodsSum + product;
        }
    }
    
    [_totalNumBtn setTitle:[NSString stringWithFormat:@"结算（%d）",index2] forState:UIControlStateNormal];
    NSString *String  = [NSString stringWithFormat:@"合计: ￥%.2f",goodsSum];
    _totalPriceLab.attributedText = [self String:String RangeString:[NSString stringWithFormat:@"￥%.2f",goodsSum]];
    if (index2 == index1 ) {
        [_selectAllBtn setImage:Image(@"check_box_sel") forState:UIControlStateNormal];
    }

}


-(void)Refresh:(NSNotification *)info
{
    [self setMoney:info.userInfo[@"Data"]];
}
- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range1];
    
    return hintString;
}


-(void )choseAllClick:(UIButton *)btn
{
   
    if (_AllSelected) {
        [self.delegate DidSelectedAllGoods];
        [_selectAllBtn setImage:Image(@"check_box_sel") forState:UIControlStateNormal];
    }else{
        [self.delegate NoDidSelectedAllGoods];
        [_selectAllBtn setImage:Image(@"check_box_nor") forState:UIControlStateNormal];
    }
    
    _AllSelected = !_AllSelected;
    

}

@end
