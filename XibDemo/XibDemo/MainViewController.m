//
//  MainViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/15.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "MainViewController.h"
#import <UIViewController+OKExtension.h>

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // --- 要添加测试的VC，在此处把类名加上即可
    [self.tableDataArr addObjectsFromArray:@[@{@"XibFirstVC":@"测试约束"},
                                             @{@"XibSecondVC":@"测试动画"},
                                             @{@"XibThreeVC":@"测试ScrollView"},
                                             @{@"XibFourVC":@"测试跳转"},
                                             @{@"TempVC2":@"Storyboard跳转"},
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
