//
//  FEQueueTaskListViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEQueueTaskListViewController.h"
#import "FESetQueueTaskViewController.h"

#import "QueueTaskListCell.h"

@interface FEQueueTaskListViewController ()

@property (nonatomic,strong) BLDNADevice *device;


@end

@implementation FEQueueTaskListViewController

+ (FEQueueTaskListViewController *)controllerWithDevice:(BLDNADevice *)device
{
    FEQueueTaskListViewController *fvc = [[FEQueueTaskListViewController alloc] init];
    fvc.device = device;
    return fvc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[QueueTaskListCell class] forCellReuseIdentifier:[QueueTaskListCell reuseIdentifier]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [[BroadLinkHelper sharedBroadLinkHelper] bl_getQueueTaskList:self.device complete:^(NSArray<NSDictionary *> *result) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result];
        [self.tableView reloadData];
    } failed:^{
        
    }];
}

- (void)addAction
{
    FESetQueueTaskViewController *fvc = [[FESetQueueTaskViewController alloc] init];
    
    @weakify(self);
    fvc.shouldAddTask = ^(NSDictionary *task) {
        
        NSLog(@"---dic %@",task);
        
    
        @strongify(self);
        [self saveTaskListWithTask:task type:1 index:-1];
        
        
    };
    [self.navigationController pushViewController:fvc animated:YES];
}

//  操作类型：1.增加，2.删除  3.修改（暂时不考虑）
- (void)saveTaskListWithTask:(NSDictionary *)task type:(NSInteger)type index:(NSInteger)index
{
    NSMutableArray *requestArray = self.dataArray.mutableCopy;
    if (type == 1) {
        [requestArray insertObject:task atIndex:0];
    }
    
    if (type == 2) {
        [requestArray removeObjectAtIndex:index];
    }
    
    if (type == 3) {
        
    }
    
    [[BroadLinkHelper sharedBroadLinkHelper] bl_setQueueTask:self.device values:requestArray complete:^(BOOL success) {
        
        if (success) {
            
            if (type == 1) {
                [self.dataArray insertObject:task atIndex:0];
                
            }
            
            if (type == 2) {
                [self.dataArray removeObjectAtIndex:index];
            }
            
            [self.tableView reloadData];
        }
        else {
            [FENavTool showAlertViewByAlertMsg:@"保存失败" andType:@"提示"];
        }
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [QueueTaskListCell reuseIdentifier];
    QueueTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSDictionary *taskInfo = self.dataArray[indexPath.row];
    [cell refreshCellWithTaskInfo:taskInfo];
    return cell;
}

- (NSArray <UITableViewRowAction *>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSDictionary *taskInfo = self.dataArray[indexPath.row];
        [self saveTaskListWithTask:taskInfo type:2 index:indexPath.row];
        
    }];
    
    return @[action];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
