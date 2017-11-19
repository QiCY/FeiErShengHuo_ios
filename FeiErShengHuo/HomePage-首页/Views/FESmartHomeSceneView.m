//
//  FESmartHomeSceneView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESmartHomeSceneView.h"

@interface FESmartHomeSceneView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray <SceneModel *>*scenes;
@end

@implementation FESmartHomeSceneView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)addScene:(SceneModel *)scene
{
    UIImageView *sceneView = [self imageViewWithScene:scene];
    sceneView.frame = CGRectMake(CGRectGetWidth(self.frame)*self.scenes.count, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.scrollView addSubview:sceneView];
    [self.scenes addObject:scene];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.scenes.count, CGRectGetHeight(self.frame));
    
    sceneView.userInteractionEnabled = YES;
    sceneView.tag = self.scenes.count - 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        self.didClickScene ? self.didClickScene (sceneView.tag) : nil;
    }];
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] init];
    [longGes.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        self.didLongClickScene ? self.didLongClickScene (sceneView.tag) : nil;
    }];
    
    [sceneView addGestureRecognizer:tap];
    [sceneView addGestureRecognizer:longGes];
}

- (void)addScenes:(NSArray<SceneModel *> *)scenes
{
    [self.scenes removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (SceneModel *model in scenes) {
        [self addScene:model];
    }
}

- (UIImageView *)imageViewWithScene:(SceneModel *)scene
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    UIImageView *sceneImageView = [[UIImageView alloc] init];
    sceneImageView.contentMode = UIViewContentModeScaleAspectFill;
    sceneImageView.clipsToBounds = YES;
    [sceneImageView sd_setImageWithURL:[NSURL URLWithString:scene.pic] placeholderImage:nil];
    [imageView addSubview:sceneImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = scene.name;
    [imageView addSubview:nameLabel];
    
    sceneImageView.frame = CGRectMake(15, 15, CGRectGetWidth(self.frame)-15*2, CGRectGetHeight(self.frame)-15-35);
    nameLabel.frame = CGRectMake(0, CGRectGetMaxY(sceneImageView.frame), CGRectGetWidth(self.frame), 35);
    return imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}

- (NSMutableArray <SceneModel *>*)scenes
{
    if (!_scenes) {
        _scenes = [NSMutableArray array];
    }
    return _scenes;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
