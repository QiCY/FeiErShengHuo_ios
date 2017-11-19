//
//  LDTimePicker.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "LDTimePicker.h"

CGFloat const advancedsostardatepickertoolBarHeight = 40;
CGFloat const advancedsostardatepickermainViewHeight = 200;

@interface LDTimePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) UIToolbar *toolBar;
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIPickerView *datePicker;

@property (nonatomic,strong) NSMutableArray *hoursArray;
@property (nonatomic,strong) NSMutableArray *minutesArray;
@property (nonatomic,strong) NSMutableArray *secondsArray;

@property (nonatomic,strong) NSString *currentHour;
@property (nonatomic,strong) NSString *currentMinute;
@property (nonatomic,strong) NSString *currentSecond;

@end

@implementation LDTimePicker

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self perparaData];
        
        [self setupView];
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        self.currentHour = @"00";
        self.currentMinute = @"00";
        self.currentSecond = @"00";
    }
    return self;
}

- (void)setCurrentTime:(NSString *)time
{
    if (time.length == 0 || time == nil) {
        return;
    }
    
    NSArray *array = [time componentsSeparatedByString:@":"];
    if (array.count == 3) {
        
        NSString *hour = array[0];
        NSString *minute = array[1];
        NSString *second = array[2];
        
        if (hour.integerValue > 24 ||
            minute.integerValue > 60 ||
            second.integerValue > 60) {
            return;
        }
        
        self.currentHour = hour;
        self.currentMinute = minute;
        self.currentSecond = second;
        
        [self.datePicker selectRow:hour.integerValue inComponent:0 animated:NO];
        [self.datePicker selectRow:minute.integerValue inComponent:1 animated:NO];
        [self.datePicker selectRow:second.integerValue inComponent:2 animated:NO];
        
    }
}

+ (LDTimePicker *)pickerWithTime:(NSString *)time
{
    LDTimePicker *picker = [[LDTimePicker alloc] init];
    [picker setCurrentTime:time];
    return picker;
}

- (void)perparaData
{
    for (NSInteger i = 0; i<=23; i++) {
        [self.hoursArray addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
    
    for (NSInteger i = 0; i<=59; i++) {
        [self.minutesArray addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
    
    for (NSInteger i = 0; i<=59; i++) {
        [self.secondsArray addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
}

- (void)setupView
{
    [self addSubview:self.mainView];
    
    [self.mainView addSubview:self.toolBar];
    [self.mainView addSubview:self.datePicker];
    
    self.mainView.frame = CGRectMake(0, MainH, MainW, advancedsostardatepickertoolBarHeight+advancedsostardatepickermainViewHeight);
    self.toolBar.frame = CGRectMake(13, 0, MainW-13*2, advancedsostardatepickertoolBarHeight);
    self.datePicker.frame = CGRectMake(0, advancedsostardatepickertoolBarHeight, MainW, advancedsostardatepickermainViewHeight);
}

- (void)doneButtonClick
{
    NSString *result = [NSString stringWithFormat:@"%@:%@:%@",self.currentHour, self.currentMinute, self.currentSecond];
    self.didSelectTime ? self.didSelectTime (result) : nil;
    [self dismiss];
}

- (void)cancelButtonClick
{
    [self dismiss];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
    self.frame = CGRectMake(0, 0, MainW, MainH);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [UIView animateWithDuration:0.3f animations:^{
        self.mainView.frame = CGRectMake(0, MainH-(advancedsostardatepickertoolBarHeight+advancedsostardatepickermainViewHeight), MainW, advancedsostardatepickertoolBarHeight+advancedsostardatepickermainViewHeight);
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.mainView.frame = CGRectMake(0, MainH, MainW, advancedsostardatepickertoolBarHeight+advancedsostardatepickermainViewHeight);
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) return self.hoursArray.count;
    if (component == 1) return self.minutesArray.count;
    if (component == 2) return self.hoursArray.count;
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    pickerLabel = [[UILabel alloc] init];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.backgroundColor = [UIColor clearColor];
    pickerLabel.font = [UIFont boldSystemFontOfSize:16.0f];

    if (component == 0) {
        NSString *hour = [NSString stringWithFormat:@"%@时",self.hoursArray[row]];
        pickerLabel.text = hour;
    }
    else if (component == 1) {
        NSString *minute = [NSString stringWithFormat:@"%@分",self.minutesArray[row]];
        pickerLabel.text = minute;
    }
    else if (component == 2) {
        NSString *minute = [NSString stringWithFormat:@"%@秒",self.secondsArray[row]];
        pickerLabel.text = minute;
    }
    else {
        pickerLabel.text = @"";
    }
    
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return MainW/3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.currentHour = self.hoursArray[row];
    }
    else if (component == 1) {
        self.currentMinute = self.minutesArray[row];
    }
    else if (component == 2) {
        self.currentSecond = self.secondsArray[row];
    }

}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        [_toolBar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        NSMutableArray *tbitems = [[NSMutableArray alloc] init];
        [tbitems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClick)]];
        [tbitems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        [tbitems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneButtonClick)]];
        _toolBar.items = tbitems;
        //        _toolBar.tintColor = Main_Theme_Color;
    }
    return _toolBar;
}

- (UIPickerView *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] init];
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

- (NSMutableArray *)hoursArray
{
    if (!_hoursArray) {
        _hoursArray = [NSMutableArray array];
    }
    return _hoursArray;
}

- (NSMutableArray *)minutesArray
{
    if (!_minutesArray) {
        _minutesArray = [NSMutableArray array];
    }
    return _minutesArray;
}

- (NSMutableArray *)secondsArray
{
    if (!_secondsArray) {
        _secondsArray = [NSMutableArray array];
    }
    return _secondsArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
