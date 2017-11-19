//
//  ZYQAssetPickerController.m
//  ZYQAssetPickerControllerDemo
//
//  Created by Zhao Yiqi on 13-12-25.
//  Copyright (c) 2013年 heroims. All rights reserved.
//

#import "ZYQAssetPickerController.h"
#import "FENavTool.h"

#define kThumbnailLength    ([UIScreen mainScreen].bounds.size.width-5*8)/4 //78.0f
#define kThumbnailSize      CGSizeMake(kThumbnailLength, kThumbnailLength)
#define kPopoverContentSize CGSizeMake(320, 480)

#pragma mark -

@interface NSDate (TimeInterval)

+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval;

@end

@implementation NSDate (TimeInterval)

+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
    
    unsigned int unitFlags =
    NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour |
    NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    return [calendar components:unitFlags
                       fromDate:date1
                         toDate:date2
                        options:0];
}

+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval
{
    NSDateComponents *components = [self.class componetsWithTimeInterval:timeInterval];
    NSInteger roundedSeconds = lround(timeInterval - (components.hour * 60) - (components.minute * 60 * 60));
    
    if (components.hour > 0)
    {
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", (long)components.hour, (long)components.minute, (long)roundedSeconds];
    }
    
    else
    {
        return [NSString stringWithFormat:@"%ld:%02ld", (long)components.minute, (long)roundedSeconds];
    }
}

@end

#pragma mark - ZYQAssetPickerController

@interface ZYQAssetPickerController ()

@property (nonatomic, copy) NSArray *indexPathsForSelectedItems;

@end

#pragma mark - ZYQVideoTitleView

@implementation ZYQVideoTitleView

-(void)drawRect:(CGRect)rect{
    CGFloat colors [] = {
        0.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 0.0, 0.8,
        0.0, 0.0, 0.0, 1.0
    };
    
    CGFloat locations [] = {0.0, 0.75, 1.0};
    
    CGColorSpaceRef baseSpace   = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient      = CGGradientCreateWithColorComponents(baseSpace, colors, locations, 2);
    
    CGContextRef context    = UIGraphicsGetCurrentContext();
    
    CGFloat height          = rect.size.height;
    CGPoint startPoint      = CGPointMake(CGRectGetMidX(rect), height);
    CGPoint endPoint        = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    
    CGSize titleSize        = [self.text sizeWithFont:self.font];
    [self.textColor set];
    [self.text drawAtPoint:CGPointMake(rect.size.width - titleSize.width - 2 , (height - 12) / 2)
                   forWidth:kThumbnailLength
                   withFont:self.font
                   fontSize:12
              lineBreakMode:NSLineBreakByTruncatingTail
         baselineAdjustment:UIBaselineAdjustmentAlignCenters];

    UIImage *videoIcon=[UIImage imageNamed:@"AssetsPickerVideo.png"];
    [videoIcon drawAtPoint:CGPointMake(2, (height - videoIcon.size.height) / 2)];
}

@end

#pragma mark - ZYQTapAssetView

@interface ZYQTapAssetView ()

@property(nonatomic,retain)UIImageView *selectView;

@end

@implementation ZYQTapAssetView

static UIImage *checkedIcon;
static UIColor *selectedColor;
static UIColor *disabledColor;

+ (void)initialize
{
    checkedIcon     = [UIImage imageNamed:@"btn_choose_checked"];
    selectedColor   = [UIColor clearColor];//[UIColor colorWithWhite:1 alpha:0.3];
    disabledColor   = [UIColor colorWithWhite:1 alpha:0.9];
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _selectView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-checkedIcon.size.width-2, 2, checkedIcon.size.width, checkedIcon.size.height)];
        [self addSubview:_selectView];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_disabled) {
        return;
    }
    
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(shouldTap)]) {
        if (![_delegate shouldTap]&&!_selected) {
            return;
        }
    }

    if ((_selected=!_selected)) {
        self.backgroundColor=selectedColor;
        [_selectView setImage:checkedIcon];
    }
    else{
        self.backgroundColor=[UIColor clearColor];
        [_selectView setImage:[UIImage imageNamed:@"btn_choose"]];
    }
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(touchSelect:)]) {
        [_delegate touchSelect:_selected];
    }
}

-(void)setDisabled:(BOOL)disabled{
    _disabled=disabled;
    if (_disabled) {
        self.backgroundColor=disabledColor;
    }
    else{
        self.backgroundColor=[UIColor clearColor];
    }
}

-(void)setSelected:(BOOL)selected{
    if (_disabled) {
        self.backgroundColor=disabledColor;
        [_selectView setImage:nil];
        return;
    }

    _selected=selected;
    if (_selected) {
        self.backgroundColor=selectedColor;
        [_selectView setImage:[UIImage imageNamed:@"btn_choose_checked"]];
    }
    else{
        self.backgroundColor=[UIColor clearColor];
        [_selectView setImage:[UIImage imageNamed:@"btn_choose"]];
    }
}

@end

#pragma mark - ZYQAssetView

@interface ZYQAssetView ()<ZYQTapAssetViewDelegate>

@property (nonatomic, strong) ALAsset *asset;

@property (nonatomic, weak) id<ZYQAssetViewDelegate> delegate;

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) ZYQVideoTitleView *videoTitle;
@property (nonatomic, retain) ZYQTapAssetView *tapAssetView;

@end

@implementation ZYQAssetView

static UIFont *titleFont = nil;

static CGFloat titleHeight;
static UIColor *titleColor;

+ (void)initialize
{
    titleFont       = [UIFont systemFontOfSize:12];
    titleHeight     = 20.0f;
    titleColor      = [UIColor whiteColor];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.opaque                     = YES;
        self.isAccessibilityElement     = YES;
        self.accessibilityTraits        = UIAccessibilityTraitImage;
        
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kThumbnailSize.width, kThumbnailSize.height)];
        [self addSubview:_imageView];
        
        _videoTitle=[[ZYQVideoTitleView alloc] initWithFrame:CGRectMake(0, kThumbnailSize.height-20, kThumbnailSize.width, titleHeight)];
        _videoTitle.hidden=YES;
        _videoTitle.font=titleFont;
        _videoTitle.textColor=titleColor;
        _videoTitle.textAlignment=NSTextAlignmentRight;
        _videoTitle.backgroundColor=[UIColor clearColor];
        [self addSubview:_videoTitle];
        
        _tapAssetView=[[ZYQTapAssetView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tapAssetView.delegate=self;
        [self addSubview:_tapAssetView];
    }
    
    return self;
}

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate*)selectionFilter isSeleced:(BOOL)isSeleced
{
    self.asset=asset;
    
    [_imageView setImage:[UIImage imageWithCGImage:asset.thumbnail]];
    
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
        _videoTitle.hidden=NO;
        _videoTitle.text=[NSDate timeDescriptionOfTimeInterval:[[asset valueForProperty:ALAssetPropertyDuration] doubleValue]];
    }
    else{
        _videoTitle.hidden=YES;
    }
    
    _tapAssetView.disabled=! [selectionFilter evaluateWithObject:asset];
    
    _tapAssetView.selected=isSeleced;
}

#pragma mark - ZYQTapAssetView Delegate

-(BOOL)shouldTap{
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(shouldSelectAsset:)]) {
        return [_delegate shouldSelectAsset:_asset];
    }
    return YES;
}

-(void)touchSelect:(BOOL)select{
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(tapSelectHandle:asset:)]) {
        [_delegate tapSelectHandle:select asset:_asset];
    }
}

@end

#pragma mark - ZYQAssetViewCell

@interface ZYQAssetViewCell ()<ZYQAssetViewDelegate>

@end

@class ZYQAssetViewController;

@implementation ZYQAssetViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)bind:(NSArray *)assets selectionFilter:(NSPredicate*)selectionFilter minimumInteritemSpacing:(float)minimumInteritemSpacing minimumLineSpacing:(float)minimumLineSpacing columns:(int)columns assetViewX:(float)assetViewX{
    
    if (self.contentView.subviews.count<assets.count) {
        for (int i=0; i<assets.count; i++) {
            if (i>((NSInteger)self.contentView.subviews.count-1)) {
                ZYQAssetView *assetView=[[ZYQAssetView alloc] initWithFrame:CGRectMake(assetViewX+(kThumbnailSize.width+minimumInteritemSpacing)*i, minimumLineSpacing-1, kThumbnailSize.width, kThumbnailSize.height)];
                [assetView bind:assets[i] selectionFilter:selectionFilter isSeleced:[((ZYQAssetViewController*)_delegate).indexPathsForSelectedItems containsObject:assets[i]]];
                assetView.delegate=self;
                [self.contentView addSubview:assetView];
            }
            else{
                ((ZYQAssetView*)self.contentView.subviews[i]).frame=CGRectMake(assetViewX+(kThumbnailSize.width+minimumInteritemSpacing)*(i), minimumLineSpacing-1, kThumbnailSize.width, kThumbnailSize.height);
                [(ZYQAssetView*)self.contentView.subviews[i] bind:assets[i] selectionFilter:selectionFilter isSeleced:[((ZYQAssetViewController*)_delegate).indexPathsForSelectedItems containsObject:assets[i]]];
            }

        }
        
    }
    else{
        for (NSInteger i=self.contentView.subviews.count; i>0; i--) {
            if (i>assets.count) {
                [((ZYQAssetView*)self.contentView.subviews[i-1]) removeFromSuperview];
            }
            else{
                ((ZYQAssetView*)self.contentView.subviews[i-1]).frame=CGRectMake(assetViewX+(kThumbnailSize.width+minimumInteritemSpacing)*(i-1), minimumLineSpacing-1, kThumbnailSize.width, kThumbnailSize.height);
                [(ZYQAssetView*)self.contentView.subviews[i-1] bind:assets[i-1] selectionFilter:selectionFilter isSeleced:[((ZYQAssetViewController*)_delegate).indexPathsForSelectedItems containsObject:assets[i-1]]];
            }
        }
    }
}

#pragma mark - ZYQAssetView Delegate

-(BOOL)shouldSelectAsset:(ALAsset *)asset{
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(shouldSelectAsset:)]) {
        return [_delegate shouldSelectAsset:asset];
    }
    return YES;
}

-(void)tapSelectHandle:(BOOL)select asset:(ALAsset *)asset{
    if (select) {
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(didSelectAsset:)]) {
            [_delegate didSelectAsset:asset];
        }
    }
    else{
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(didDeselectAsset:)]) {
            [_delegate didDeselectAsset:asset];
        }
    }
}

@end

#pragma mark - ZYQAssetViewController

@interface ZYQAssetViewController ()<ZYQAssetViewCellDelegate>{
    int columns;
    
    float minimumInteritemSpacing;
    float minimumLineSpacing;
    
    BOOL unFirst;
}

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, assign) NSInteger numberOfPhotos;
@property (nonatomic, assign) NSInteger numberOfVideos;

@end

#define kAssetViewCellIdentifier           @"AssetViewCellIdentifier"

@implementation ZYQAssetViewController

- (id)init
{
    _indexPathsForSelectedItems=[[NSMutableArray alloc] init];
    
    if (self = [super init])
    {
//        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//            [self setEdgesForExtendedLayout:UIRectEdgeNone];
//        
//        if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
//            self.preferredContentSize = kPopoverContentSize;
            //[self setContentSizeForViewInPopover:kPopoverContentSize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //添加背景图片
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    bgImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    bgImgView.image = [UIImage imageNamed:@"view_bg"];
//    [self.view addSubview:bgImgView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64-44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset=UIEdgeInsetsMake(9.0, 0, 0, 0);
    
    //底部拍照
    UIView *ftView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
    ftView.backgroundColor = [UIColor clearColor];
//    UIImageView *bgFtimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
//    bgFtimg.image = [[UIImage imageNamed:@"toolbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [ftView addSubview:bgFtimg];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [photoBtn setFrame:CGRectMake(MainW/2-12, 10, 24, 24)];
    [photoBtn addTarget:self action:@selector(doTakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [ftView addSubview:photoBtn];
    [self.view addSubview:ftView];
    
    minimumInteritemSpacing=8;
    minimumLineSpacing=8;
    
    [self setupViews];
    [self setupButtons];
}

-(void)doTakePhoto:(UIButton *)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
        ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
        if ([picker.delegate respondsToSelector:@selector(showImagePickerToTakePhoto)])
            [picker.delegate showImagePickerToTakePhoto];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!unFirst) {
        columns=4;//floor(self.view.frame.size.width/(kThumbnailSize.width+minimumInteritemSpacing));
        
        [self setupAssets];
        
        unFirst=YES;
    }
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //if iOS 5.0 and later
        //设置导航标题颜色
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                         [UIFont boldSystemFontOfSize:16.f], NSFontAttributeName,
                                                                         nil]];
    }
    else
    {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    [self.navigationController.navigationBar setBarTintColor:GLOBAL_COLOR_YELLOW];
}


#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        self.tableView.contentInset=UIEdgeInsetsMake(9.0, 0, 0, 0);
        
        minimumInteritemSpacing=3;
        minimumLineSpacing=3;
    }
    else
    {
        self.tableView.contentInset=UIEdgeInsetsMake(9.0, 0, 0, 0);
        
        minimumInteritemSpacing=2;
        minimumLineSpacing=2;
    }
    
    columns=4;//floor(self.view.frame.size.width/(kThumbnailSize.width+minimumInteritemSpacing));

    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupViews
{
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)setupButtons
{
    [FENavTool backOnNavigationItemWithNavItem:self.navigationItem
                                               target:self
                                               action:@selector(doBackAction:)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(finishPickingAssets:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
}

-(void)doBackAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupAssets
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.numberOfPhotos = 0;
    self.numberOfVideos = 0;
    
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
            
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            
            if ([type isEqual:ALAssetTypePhoto])
                self.numberOfPhotos ++;
            if ([type isEqual:ALAssetTypeVideo])
                self.numberOfVideos ++;
        }
        
        else if (self.assets.count > 0)
        {
            [self.tableView reloadData];

            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ceil(self.assets.count*1.0/columns)  inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}

#pragma mark - UITableView DataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==ceil(self.assets.count*1.0/columns)) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellFooter"];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFooter"];
            cell.textLabel.font=[UIFont systemFontOfSize:18];
            cell.textLabel.backgroundColor=[UIColor clearColor];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.textColor=[UIColor blackColor];
            cell.backgroundColor=[UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSString *title;
        
        if (_numberOfVideos == 0)
            title = [NSString stringWithFormat:NSLocalizedString(@"%ld 张照片", nil), (long)_numberOfPhotos];
        else if (_numberOfPhotos == 0)
            title = [NSString stringWithFormat:NSLocalizedString(@"%ld 部视频", nil), (long)_numberOfVideos];
        else
            title = [NSString stringWithFormat:NSLocalizedString(@"%ld 张照片, %ld 部视频", nil), (long)_numberOfPhotos, (long)_numberOfVideos];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text=title;
        return cell;
    }
    
    
    NSMutableArray *tempAssets=[[NSMutableArray alloc] init];
    for (int i=0; i<columns; i++) {
        if ((indexPath.row*columns+i)<self.assets.count) {
            [tempAssets addObject:[self.assets objectAtIndex:indexPath.row*columns+i]];
        }
    }
    
    static NSString *CellIdentifier = kAssetViewCellIdentifier;
    ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
    
    ZYQAssetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[ZYQAssetViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.delegate=self;

    [cell bind:tempAssets selectionFilter:picker.selectionFilter minimumInteritemSpacing:minimumInteritemSpacing minimumLineSpacing:minimumLineSpacing columns:columns assetViewX:(minimumInteritemSpacing*(tempAssets.count-1))/2];
    //self.tableView.frame.size.width-kThumbnailSize.width*tempAssets.count-
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ceil(self.assets.count*1.0/columns)+1;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==ceil(self.assets.count*1.0/columns)) {
        return 44;
    }
    return kThumbnailSize.height+minimumLineSpacing;
}


#pragma mark - ZYQAssetViewCell Delegate

- (BOOL)shouldSelectAsset:(ALAsset *)asset
{
    ZYQAssetPickerController *vc = (ZYQAssetPickerController *)self.navigationController;
    BOOL selectable = [vc.selectionFilter evaluateWithObject:asset];
    if (_indexPathsForSelectedItems.count > vc.maximumNumberOfSelection) {
        if (vc.delegate!=nil&&[vc.delegate respondsToSelector:@selector(assetPickerControllerDidMaximum:)]) {
            [vc.delegate assetPickerControllerDidMaximum:vc];
        }
    }
    
    return (selectable && _indexPathsForSelectedItems.count < vc.maximumNumberOfSelection);
}

- (void)didSelectAsset:(ALAsset *)asset
{
    [_indexPathsForSelectedItems addObject:asset];
    
    ZYQAssetPickerController *vc = (ZYQAssetPickerController *)self.navigationController;
    vc.indexPathsForSelectedItems = _indexPathsForSelectedItems;
    
    if (vc.delegate!=nil&&[vc.delegate respondsToSelector:@selector(assetPickerController:didSelectAsset:)])
        [vc.delegate assetPickerController:vc didSelectAsset:asset];
    
    [self setTitleWithSelectedIndexPaths:_indexPathsForSelectedItems];
}

- (void)didDeselectAsset:(ALAsset *)asset
{
    [_indexPathsForSelectedItems removeObject:asset];
    
    ZYQAssetPickerController *vc = (ZYQAssetPickerController *)self.navigationController;
    vc.indexPathsForSelectedItems = _indexPathsForSelectedItems;
    
    if (vc.delegate!=nil&&[vc.delegate respondsToSelector:@selector(assetPickerController:didDeselectAsset:)])
        [vc.delegate assetPickerController:vc didDeselectAsset:asset];
    
    [self setTitleWithSelectedIndexPaths:_indexPathsForSelectedItems];
}


#pragma mark - Title

- (void)setTitleWithSelectedIndexPaths:(NSArray *)indexPaths
{
    // Reset title to group name
    if (indexPaths.count == 0)
    {
        self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        return;
    }
    
    BOOL photosSelected = NO;
    BOOL videoSelected  = NO;
    
    for (int i=0; i<indexPaths.count; i++) {
        ALAsset *asset = indexPaths[i];
        
        if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypePhoto])
            photosSelected  = YES;
        
        if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
            videoSelected   = YES;
        
        if (photosSelected && videoSelected)
            break;

    }
    
    NSString *format;
    
    if (photosSelected && videoSelected)
        format = NSLocalizedString(@"已选择 %ld 个项目", nil);
    
    else if (photosSelected)
        format = (indexPaths.count > 1) ? NSLocalizedString(@"已选择 %ld 张照片", nil) : NSLocalizedString(@"已选择 %ld 张照片 ", nil);
    
    else if (videoSelected)
        format = (indexPaths.count > 1) ? NSLocalizedString(@"已选择 %ld 部视频", nil) : NSLocalizedString(@"已选择 %ld 部视频 ", nil);
    
    self.title = [NSString stringWithFormat:format, (long)indexPaths.count];
}


#pragma mark - Actions

- (void)finishPickingAssets:(id)sender
{
    
    ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
    
    if (_indexPathsForSelectedItems.count < picker.minimumNumberOfSelection) {
        if (picker.delegate!=nil&&[picker.delegate respondsToSelector:@selector(assetPickerControllerDidMaximum:)]) {
            [picker.delegate assetPickerControllerDidMaximum:picker];
        }
    }
    

    if ([picker.delegate respondsToSelector:@selector(assetPickerController:didFinishPickingAssets:)])
        [picker.delegate assetPickerController:picker didFinishPickingAssets:_indexPathsForSelectedItems];
    
    if (picker.isFinishDismissViewController) {
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end

#pragma mark - ZYQAssetGroupViewCell

@interface ZYQAssetGroupViewCell ()

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end

@implementation ZYQAssetGroupViewCell


- (void)bind:(ALAssetsGroup *)assetsGroup
{
    self.assetsGroup            = assetsGroup;
    
    CGImageRef posterImage      = assetsGroup.posterImage;
    size_t height               = CGImageGetHeight(posterImage);
    float scale                 = height / kThumbnailLength;
    
    self.imageView.image        = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    self.textLabel.textColor    = [UIColor whiteColor];
    self.textLabel.text         = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.detailTextLabel.textColor    = [UIColor whiteColor];
    self.detailTextLabel.text   = [NSString stringWithFormat:@"%ld", (long)[assetsGroup numberOfAssets]];
    self.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSString *)accessibilityLabel
{
    NSString *label = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    return [label stringByAppendingFormat:NSLocalizedString(@"%ld 张照片", nil), (long)[self.assetsGroup numberOfAssets]];
}

@end


#pragma mark - ZYQAssetGroupViewController

@interface ZYQAssetGroupViewController()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation ZYQAssetGroupViewController

- (id)init
{
    if (self = [super init])
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
        self.preferredContentSize=kPopoverContentSize;
#else
        if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
            [self setContentSizeForViewInPopover:kPopoverContentSize];
#endif
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //if iOS 5.0 and later
        //设置导航标题颜色
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                         [UIFont boldSystemFontOfSize:16.f], NSFontAttributeName,
                                                                         nil]];
    }
    else
    {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    [self.navigationController.navigationBar setBarTintColor:GLOBAL_COLOR_YELLOW];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加背景图片
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    bgImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    bgImgView.image = [UIImage imageNamed:@"view_bg"];
//    [self.view addSubview:bgImgView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MainW, MainH - 64 - 44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //底部拍照
    UIView *ftView = [[UIView alloc] initWithFrame:CGRectMake(0, MainH - 44, MainW, 44)];
    ftView.backgroundColor = [UIColor clearColor];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [photoBtn setFrame:CGRectMake(MainW/2-12, 10, 24, 24)];
    [photoBtn addTarget:self action:@selector(doTakePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [ftView addSubview:photoBtn];
    [self.view addSubview:ftView];
    
    [self setupViews];
    [self setupButtons];
    [self localize];
    [self setupGroup];
}

-(void)doTakePhoto:(UIButton *)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
        ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
        if ([picker.delegate respondsToSelector:@selector(showImagePickerToTakePhoto)])
            [picker.delegate showImagePickerToTakePhoto];
    }];
}


#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


#pragma mark - Setup

- (void)setupViews
{
    self.tableView.rowHeight = kThumbnailLength + 12;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupButtons
{
    ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
    
    if (picker.showCancelButton)
    {
        [FENavTool backOnNavigationItemWithNavItem:self.navigationItem
                                                   target:self
                                                   action:@selector(dismiss:)];
//        self.navigationItem.rightBarButtonItem =
//        [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil)
//                                         style:UIBarButtonItemStylePlain
//                                        target:self
//                                        action:@selector(dismiss:)];
    }
}

- (void)localize
{
    self.title = NSLocalizedString(@"相簿", nil);
}

- (void)setupGroup
{
    if (!self.assetsLibrary)
        self.assetsLibrary = [self.class defaultAssetsLibrary];
    
    if (!self.groups)
        self.groups = [[NSMutableArray alloc] init];
    else
        [self.groups removeAllObjects];
    
    ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
    ALAssetsFilter *assetsFilter = picker.assetsFilter;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
            [group setAssetsFilter:assetsFilter];
            if (group.numberOfAssets > 0 || picker.showEmptyGroups)
                [self.groups addObject:group];
        }
        else
        {
            [self reloadData];
        }
    };
    
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        [self showNotAllowed];
        
    };
    
    // Enumerate Camera roll first
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
    // Then all other groups
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [self.assetsLibrary enumerateGroupsWithTypes:type
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
}


#pragma mark - Reload Data

- (void)reloadData
{
    if (self.groups.count == 0)
        [self showNoAssets];
    
    [self.tableView reloadData];
}


#pragma mark - ALAssetsLibrary

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


#pragma mark - Not allowed / No assets

- (void)showNotAllowed
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom];
    
    self.title              = nil;
    
    UIImageView *padlock    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssetsPickerLocked@2x.png"]];
    padlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *title          = [UILabel new];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.preferredMaxLayoutWidth = 304.0f;
    
    UILabel *message        = [UILabel new];
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.preferredMaxLayoutWidth = 304.0f;
    
    title.text              = NSLocalizedString(@"此应用无法使用您的照片或视频。", nil);
    title.font              = [UIFont boldSystemFontOfSize:17.0];
    title.textColor         = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = NSLocalizedString(@"你可以在「隐私设置」中启用存取。", nil);
    message.font            = [UIFont systemFontOfSize:14.0];
    message.textColor       = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    UIView *centerView = [UIView new];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView addSubview:padlock];
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(padlock, title, message);
    
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:padlock attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[padlock]-[title]-[message]|" options:0 metrics:nil views:viewsDictionary]];
    
    UIView *backgroundView = [UIView new];
    [backgroundView addSubview:centerView];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    self.tableView.backgroundView = backgroundView;
}

- (void)showNoAssets
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom];
    
    UILabel *title          = [UILabel new];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.preferredMaxLayoutWidth = 304.0f;
    UILabel *message        = [UILabel new];
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.preferredMaxLayoutWidth = 304.0f;
    
    title.text              = NSLocalizedString(@"没有照片或视频。", nil);
    title.font              = [UIFont systemFontOfSize:26.0];
    title.textColor         = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = NSLocalizedString(@"您可以使用 iTunes 将照片和视频\n同步到 iPhone。", nil);
    message.font            = [UIFont systemFontOfSize:18.0];
    message.textColor       = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    UIView *centerView = [UIView new];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(title, message);
    
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:title attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]-[message]|" options:0 metrics:nil views:viewsDictionary]];
    
    UIView *backgroundView = [UIView new];
    [backgroundView addSubview:centerView];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    self.tableView.backgroundView = backgroundView;
}



#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 8)];
    hdView.backgroundColor = [UIColor clearColor];
    return hdView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ZYQAssetGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ZYQAssetGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell bind:[self.groups objectAtIndex:indexPath.section]];
    
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kThumbnailLength + 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYQAssetViewController *vc = [[ZYQAssetViewController alloc] init];
    vc.assetsGroup = [self.groups objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Actions

- (void)dismiss:(id)sender
{
    ZYQAssetPickerController *picker = (ZYQAssetPickerController *)self.navigationController;
    
    if ([picker.delegate respondsToSelector:@selector(assetPickerControllerDidCancel:)])
        [picker.delegate assetPickerControllerDidCancel:picker];
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end

#pragma mark - ZYQAssetPickerController

@implementation ZYQAssetPickerController

- (id)init
{
    ZYQAssetGroupViewController *groupViewController = [[ZYQAssetGroupViewController alloc] init];
    
    if (self = [super initWithRootViewController:groupViewController])
    {
        _maximumNumberOfSelection      = 10;
        _minimumNumberOfSelection      = 0;
        _assetsFilter                  = [ALAssetsFilter allAssets];
        _showCancelButton              = YES;
        _showEmptyGroups               = NO;
        _selectionFilter               = [NSPredicate predicateWithValue:YES];
        _isFinishDismissViewController = YES;
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
        self.preferredContentSize=kPopoverContentSize;
#else
        if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
            [self setContentSizeForViewInPopover:kPopoverContentSize];
#endif
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
