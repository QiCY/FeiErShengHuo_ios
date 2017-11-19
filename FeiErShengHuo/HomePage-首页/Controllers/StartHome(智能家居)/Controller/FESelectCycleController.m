//
//  FESelectCycleController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESelectCycleController.h"

@interface FESelectCycleController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *selectArray;

@end

@implementation FESelectCycleController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

+ (FESelectCycleController *)controllerWithCycle:(NSString *)cycle
{
    FESelectCycleController *fvc = [[FESelectCycleController alloc] init];
    [fvc configSelectResult:cycle];
    return fvc;
}

- (void)configSelectResult:(NSString *)cycle
{
    if ([cycle isEqualToString:@"null"] || cycle == nil) {

    }
    else {
        if ([cycle isEqualToString:@"1234567"]) {
            [self.selectArray replaceObjectAtIndex:0 withObject:@[@"1"].mutableCopy];
            [self.selectArray replaceObjectAtIndex:1 withObject:@[@"1", @"1", @"1", @"1", @"1", @"1", @"1"].mutableCopy];
        }
        else {
            NSMutableArray *itemArray1 = self.selectArray[1];
            
            for (NSInteger i = 0; i<cycle.length; i++) {
                NSString *str = [cycle substringWithRange:NSMakeRange(i, 1)];
                [itemArray1 replaceObjectAtIndex:str.integerValue-1 withObject:@"1"];
            }

            [self.selectArray replaceObjectAtIndex:1 withObject:itemArray1];
        }

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.dataArray addObject:@[@"每天"]];
    [self.dataArray addObject:@[@"每周一", @"每周二", @"每周三", @"每周四", @"每周五", @"每周六", @"每周日"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell reuseIdentifier]];
}

- (void)saveAction
{
    NSString *result = @"null";
    
    NSMutableArray *itemArray0 = self.selectArray[0];
    NSMutableArray *itemArray1 = self.selectArray[1];
    
    if ([itemArray0[0] isEqualToString:@"1"]) {
        result = @"1234567";
    }
    else {
        
        __block NSMutableString *str = @"".mutableCopy;
        
        [itemArray1 enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.integerValue) {
                [str appendString:[NSString stringWithFormat:@"%ld",idx+1]];
            }
            
        }];
        
        if (str.length) {
            result = [NSString stringWithFormat:@"%@",str];
        }
        else {
            result = @"null";
        }
        
    }
    
    self.didSelectCycle ? self.didSelectCycle (result) : nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)checkAllSelect
{
    __block BOOL result = YES;
    [[self.selectArray lastObject] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.integerValue == 0) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [UITableViewCell reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...

    
    NSString *title = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = title;
    
    NSString *value = self.selectArray[indexPath.section][indexPath.row];
    cell.accessoryType = value.integerValue ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSMutableArray *itemArray = self.selectArray[indexPath.section];
    NSString *targetItem = [itemArray[indexPath.row] integerValue] ? @"0" : @"1";
    
    //  选了不循环需要将下面的天置灰
    if (indexPath.section == 0) {
        NSMutableArray *itemArray1 = targetItem.integerValue ? @[@"1", @"1", @"1", @"1", @"1", @"1", @"1"].mutableCopy : @[@"0", @"0", @"0", @"0", @"0", @"0", @"0"].mutableCopy;
        [self.selectArray replaceObjectAtIndex:1 withObject:itemArray1];
        NSMutableArray *itemArray0 = targetItem.integerValue ? @[@"1"].mutableCopy : @[@"0"].mutableCopy;
        [self.selectArray replaceObjectAtIndex:0 withObject:itemArray0];
    }
    //  选了下面的摇奖上面的不循环置灰
    else {
        [itemArray replaceObjectAtIndex:indexPath.row withObject:targetItem];
        NSString *allSelect = [self checkAllSelect] ? @"1" : @"0";
        [self.selectArray[0] replaceObjectAtIndex:0 withObject:allSelect];
    }
    
    [self.tableView reloadData];
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
        
        [_selectArray addObject:@[@"0"].mutableCopy];
        [_selectArray addObject:@[@"0", @"0", @"0", @"0", @"0", @"0", @"0"].mutableCopy];
    }
    return _selectArray;
}

@end
