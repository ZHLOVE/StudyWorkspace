//
//  ViewController.m
//  ApiDemo
//
//  Created by mao wangxin on 2017/6/12.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"
#import <UIViewController+OKExtension.h>
#import "UITableView+OKExtension.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL hasChange;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plainTableView.automaticShowTipView = YES;
    self.plainTableView.rowHeight = 60;
    [self refreshTableData];
    
    //删除数据
    [self addRightBarButtonItem:@"刷新数据" target:self selector:@selector(refreshTableData)];
}

/**
 * 要添加测试的VC，在此处把类名加上即可
 */
- (void)refreshTableData
{
    if (!self.hasChange) {
        [self.tableDataArr addObjectsFromArray:@[@{@"StudyInvocationVC":@"NSInvocation的使用"},
                                                 @{@"StudyMessageSendVC":@"OC消息转发机制"},
                                                 ]];
    } else {
        [self.tableDataArr removeAllObjects];
    }
    
    [self.plainTableView reloadData];
    
    self.hasChange = !self.hasChange;
}


#pragma mark - /*** UITaleviewDelegate ***/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
    }
    NSDictionary *celLDic = [self.tableDataArr objectAtIndex:indexPath.row];
    NSString *className = celLDic.allKeys[0];
    cell.textLabel.text = className;
    cell.detailTextLabel.text = celLDic[className];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *celLDic = [self.tableDataArr objectAtIndex:indexPath.row];
    NSString *className = celLDic.allKeys[0];
    [self pushToViewController:className propertyDic:@{@"title":className}];
}


@end
