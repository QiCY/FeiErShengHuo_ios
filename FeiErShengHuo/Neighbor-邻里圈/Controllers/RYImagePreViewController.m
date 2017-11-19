//
//  RYImagePreViewController.m
//  CCICPhone
//
//  Created by apple on 15/6/1.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import "RYImagePreViewController.h"
#import "RYImageTool.h"
#import "FENavTool.h"


@interface RYImagePreViewController ()

@end

@implementation RYImagePreViewController

-(id)initWithImg:(NSArray *)imgArr andIsPush:(BOOL) isP andIndex:(NSInteger)idx;
{
    self = [super init];
    if (self) {
        isPush = isP;
        self.imgArr = [[NSMutableArray alloc] initWithArray:imgArr];
        if (isP) {
            [self.imgArr removeLastObject];
        }
        _currentIndex = idx+1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex,self.imgArr.count];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImg.image = [UIImage imageNamed:@"view_bg"];
    [self.view addSubview:bgImg];
    
    [FENavTool backOnNavigationItemWithNavItem:self.navigationItem target:self action:@selector(doBack:)];
    
    if (isPush) {
        [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(doDeletePhoto:) andType:item_delete];
    }
    
    self.nineImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -49, MainW, MainH)];
    _nineImageView.backgroundColor = [UIColor clearColor];
    _nineImageView.pagingEnabled = YES;
    _nineImageView.delegate = self;
    _nineImageView.showsVerticalScrollIndicator = NO;
    _nineImageView.showsHorizontalScrollIndicator = NO;
    for (int i = 0 ; i < _imgArr.count; ++i) {
        UIImage *tgImage = _imgArr[i];
        MRZoomScrollView *imgView = [[MRZoomScrollView alloc] initWithFrame:CGRectMake(MainW*i, 0, MainW, MainH)];
        [imgView addNewImageToImageView:tgImage];
        [_nineImageView addSubview:imgView];
    }
    _nineImageView.contentSize = CGSizeMake(MainW*_imgArr.count, _nineImageView.frame.size.height);
    [_nineImageView setContentOffset:CGPointMake(MainW*(_currentIndex-1), 0)];
    [self.view addSubview:_nineImageView];
}

-(void)doBack:(UIButton *)sender
{
    if (isPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)doDeletePhoto:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(delPhotoByPreView:)]) {
        [_delegate delPhotoByPreView:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"移动到%ld",page+1);
    _currentIndex = page+1;
    self.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex,self.imgArr.count];
}

@end
