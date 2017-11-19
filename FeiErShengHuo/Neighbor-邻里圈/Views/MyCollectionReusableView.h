//
//  MyCollectionReusableView.h
//  DemoOfUICollectionView
//
//  Created by 蔡成汉 on 16/8/9.
//  Copyright © 2016年 蔡成汉. All rights reserved.
//

//作为分区头

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
typedef void(^ButtonRuleClick)();

//下一步就是声明属性了，注意block的声明属性修饰要用copy


@interface MyCollectionReusableView : UICollectionReusableView

/**
 *  分区标题
 */
@property (nonatomic , strong) NSString *title;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView2;
@property(nonatomic,strong)UIView *btnBgView;
@property (nonatomic,copy) ButtonClick buttonAction;
@property (nonatomic,copy) ButtonRuleClick ruleblock;
@property(nonatomic,copy)NSArray *imagesURLStrings;
@property(nonatomic,assign)CGFloat HH;

@property(nonatomic,strong)FELoginInfo *info2;

@property (nonatomic , strong)UIButton *intergralCoutBtn;
@property (nonatomic , strong)UIButton *recordBtn;
@property (nonatomic , strong)UIButton *ruleBtn;

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIView *view;

@end
