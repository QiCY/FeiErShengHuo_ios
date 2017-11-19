//
//  ZLActionSheet.m
//  IndustryProxy
//
//  Created by TAKUMI on 2016/12/29.
//  Copyright © 2016年 TAKUMI. All rights reserved.
//

#import "ZLActionSheet.h"

@interface ZLActionSheet ()
{
    NSMutableArray *_arrayTitles;
    NSMutableArray *_arrayActions;
}

//iOS8.0之后会使用UIAlertController，所以需要使用调用该类的ViewController
@property (nonatomic, weak) UIViewController *sender;

@end

@implementation ZLActionSheet

//重写该方法，保证该对象不会被释放，如果被释放，iOS8以下的UIAlertView的回调时候会崩溃
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    static ZLActionSheet *_shareActionSheet = nil;
    dispatch_once(&onceToken, ^{
        if (_shareActionSheet == nil) {
            _shareActionSheet = [super allocWithZone:zone];
        }
    });
    return _shareActionSheet;
}

- (instancetype)init
{
    if (self = [super init]) {
        _arrayTitles = [NSMutableArray array];
        _arrayActions = [NSMutableArray array];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if ([self init]) {
        _title = title;
        _message = message;
    }
    return self;
}

- (void)setTitle:(NSString *)title message:(NSString *)message
{
    _title = title;
    _message = message;
}

- (void)addBtnTitle:(NSString *)title action:(ClickAction)action
{
    [_arrayTitles addObject:title];
    [_arrayActions addObject:action];
}

- (void)showActionSheetWithSender:(UIViewController *)sender
{
    //    if (_arrayTitles.count == 0) {
    //        return;
    //    }
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    self.sender = sender;
    [self showActionSheet];
    
}


- (void)showActionSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleActionSheet];
    if (self.changeTitle) {
        [alert setValue:self.changeTitle forKey:@"attributedTitle"];
    }
    for (int i = 0; i < _arrayTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:_arrayTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ClickAction ac = _arrayActions[i];
            ac();
        }];
        [alert addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:cancelAction];
    
    if (_sender) {
        
        [_sender presentViewController:alert animated:YES completion:^{
            
        }];
    }
}



@end
