//
//  FENavTool.m
//  zijinlian
//
//  Created by lzy on 2017/3/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "FENavTool.h"
#import "SIAlertView.h"



@implementation FENavTool
+(void)backOnNavigationItemWithNavItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    //左边返回按钮
    UIButton *fanHuiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanHuiButton.frame = CGRectMake(0, 0, 12, 18);
    [fanHuiButton setBackgroundImage:[UIImage imageNamed:@"Navigation_arrows"] forState:UIControlStateNormal];
    [fanHuiButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:fanHuiButton];
    navitem.leftBarButtonItems = @[negativeSpacer,leftItem];
}

+(void)rightItemOnNavigationItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action andType:(RightItemType)type
{
    //右侧完成编辑按钮
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (type == item_threeline) {
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"icon_Three_line"] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
    }
    
    if  (type == item_delete){
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_del"] forState:UIControlStateNormal];
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_del_pressed"] forState:UIControlStateHighlighted];
    }
    
    
    else if (type == item_publish){
        [finishBtn setTitle:@"发布" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }
    else if (type == item_share){
        [finishBtn setTitle:@"分享" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }
    
    else if (type == item_shanchu){
        [finishBtn setTitle:@"删除" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }

    
    else if (type == item_genhuan){
        [finishBtn setTitle:@"更换" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }


    
    else if (type == item_sure){
        [finishBtn setTitle:@"确认" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 44, 44)];
    }
    
    if (type == item_finish){
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_finish"] forState:UIControlStateNormal];
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_finish_pressed"] forState:UIControlStateHighlighted];
        [finishBtn setFrame:CGRectMake(0, 0, 40, 40)];
    }
    
    
    if (type == item_whrite) {
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"icon_Neighborhood_pen"] forState:UIControlStateNormal];
        [finishBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
    }
    
    
    
    if (type == item_delete){
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_del"] forState:UIControlStateNormal];
        [finishBtn setBackgroundImage:[UIImage imageNamed:@"actionbar_del_pressed"] forState:UIControlStateHighlighted];
         [finishBtn setFrame:CGRectMake(0, 0, 40, 40)];
    }
    
    
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
    navitem.rightBarButtonItems = @[negativeSpacer,finishItem];
}


+(void)showAlertViewByAlertMsg:(NSString *)msg andType:(NSString *)title
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:msg];
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    [alertView show];
}




+(void)showAlertRightAndCancelMsg:(NSString *)msg andType:(NSString *)title andRightClick:(rightClick)rightClick andCancelClick:(cancelClick)cancelClick

{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:msg];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Cancel Clicked");
                              
                              cancelClick();
                              
                          }];
    [alertView addButtonWithTitle:@"确认"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"OK Clicked");
                              
                              rightClick();
                              
                             
                          }];
    
     alertView.transitionStyle = SIAlertViewTransitionStyleFade;
   // alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
    

}

    


+(void)codeisEqualToStringOneWithDic:(NSDictionary *)dictionary withSucess:(NSString *)sucesssStr withFailed:(NSString *)failedStr
{
    if ([dictionary[@"code"]isEqualToString:@"1"]) {
        [FENavTool showAlertViewByAlertMsg:sucesssStr andType:@"提示"];
    }else
    {
        [FENavTool showAlertViewByAlertMsg:failedStr andType:@"提示"];
    }
    
}


//调整颜色
+(NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString  RangeColor:(UIColor *)Color
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color range:range1];
    
    return hintString;
}
//调整 字体颜色

+(NSMutableAttributedString *)withStr:(NSString *)rangeStr withRangeColor:(UIColor *)Color withRangeFont:(UIFont *)Font WithRange: (NSRange)Range
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:rangeStr];
    [attributed addAttribute:NSFontAttributeName value:Font range:Range];
    [attributed addAttribute:NSForegroundColorAttributeName value:Color range:Range];
    return attributed;
    
}

//获取当前时间

+(NSString*)getCurrentTimes{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMdd HHmmss"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================", DateTime);
    return DateTime;
    
    
}



+(void)view:(UIViewController *)controller phoneWithMoble:(NSString *)phoneStr{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneStr];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [controller.view addSubview:callWebview];
}



@end
