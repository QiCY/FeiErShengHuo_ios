//
//  FaceBoard.m
//  utt
//
//  Created by lixy on 14/11/4.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import "FaceBoard.h"

#import "UIKit+BaseExtension.h"
#import "HPTextViewInternal.h"

#define FaceBtnSize    44
#define FaceTotalCount 30

@implementation FaceBoard

- (id)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, MainW, 216)];
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faceMap_ch" ofType:@"plist"]];
    NSInteger rowNum = 4;
    NSInteger cluNum = 7;
    CGFloat paddingWith = 6;
    switch ([UIDevice iphoneType]) {
        case IPhone6:
        {
            cluNum = 8;
            paddingWith = 12.5;
        }
            break;
        case IPhone6P:
        {
            cluNum = 9;
            paddingWith = 9;
        }
            break;
            
        default:
            break;
    }
    
    NSInteger pageCount = rowNum * cluNum;
    
    //表情盘
    _faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainW, self.frame.size.height)];
    _faceView.pagingEnabled = YES;
    _faceView.backgroundColor = [UIColor clearColor];
    _faceView.contentSize = CGSizeMake((FaceTotalCount / pageCount + 1) * MainW, self.frame.size.height);
    _faceView.showsHorizontalScrollIndicator = NO;
    _faceView.showsVerticalScrollIndicator = NO;
    _faceView.delegate = self;
    
    for (int i = 1; i <= FaceTotalCount+1; i++) {
        
        UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        faceButton.tag = i;
        [faceButton setBackgroundColor:[UIColor clearColor]];
        faceButton.imageView.contentMode = UIViewContentModeCenter;
        
        //计算每一个表情按钮的坐标和在哪一屏
        CGFloat x = (((i - 1) % pageCount) % cluNum) * FaceBtnSize + paddingWith + ((i - 1) / pageCount * MainW);
        CGFloat y = (((i - 1) % pageCount) / cluNum) * FaceBtnSize + 8;
        faceButton.frame = CGRectMake( x, y, FaceBtnSize, FaceBtnSize);
        
        if (i == FaceTotalCount+1) {
            [faceButton setImage:[UIImage imageNamed:@"exp_delete"] forState:UIControlStateNormal];
            [faceButton addTarget:self
                           action:@selector(backFace)
                 forControlEvents:UIControlEventTouchUpInside];
        }else{
            [faceButton addTarget:self
                           action:@selector(faceButton:)
                 forControlEvents:UIControlEventTouchUpInside];
            [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",i]]
                        forState:UIControlStateNormal];
        }
    
        [_faceView addSubview:faceButton];
    }
    
    //添加PageControl
    _facePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _facePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_facePageControl addTarget:self
                         action:@selector(pageChange:)
               forControlEvents:UIControlEventValueChanged];
    _facePageControl.center = CGPointMake(MainW/2, self.frame.size.height-60);
    _facePageControl.numberOfPages = FaceTotalCount / pageCount + 1;
    _facePageControl.currentPage = 0;
//    [self addSubview:_facePageControl];
    
    //添加键盘View
    [self addSubview:_faceView];
}

//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_facePageControl setCurrentPage:_faceView.contentOffset.x / MainW];
}

- (void)pageChange:(id)sender
{
    [_faceView setContentOffset:CGPointMake(_facePageControl.currentPage * MainW, 0) animated:YES];
    [_facePageControl setCurrentPage:_facePageControl.currentPage];
}

- (void)faceButton:(UIButton*)sender
{
    int i = (int)sender.tag;
    if (self.inputTextView) {
        UITextView *tagView = (UITextView *)self.inputTextView;
        if (tagView.text.length == 0) {
            tagView.text = @"";
        }
        
        [self.inputTextView insertFaceWithImageName:[NSString stringWithFormat:@"%03d",i] des:_faceMap[[NSString stringWithFormat:@"%03d",i]]];
    }
}

- (void)backFace
{
    if (self.inputTextView) {
        [self.inputTextView backFace];
    }
}


@end
