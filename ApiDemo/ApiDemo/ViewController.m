//
//  ViewController.m
//  ApiDemo
//
//  Created by mao wangxin on 2017/6/12.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"
#import <UIViewController+OKExtension.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // --- 要添加测试的VC，在此处把类名加上即可
    [self.tableDataArr addObjectsFromArray:@[@{@"StudyInvocationVC":@"NSInvocation的使用"},
                                             @{@"StudyMessageSendVC":@"OC消息转发机制"},
                                             ]];
    self.plainTableView.rowHeight = 60;
    [self.plainTableView reloadData];
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
