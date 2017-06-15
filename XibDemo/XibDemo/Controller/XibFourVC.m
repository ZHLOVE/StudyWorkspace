//
//  XibFourVC.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/2.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibFourVC.h"
#import "TableViewCell.h"
#import "DataModel.h"

static NSString *const kTableCellID = @"cellIdInfo";

@interface XibFourVC ()

@end

@implementation XibFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataModel *dataModel1 = [[DataModel alloc] init];
    dataModel1.weiboContent = @"如果你现在去一家互联网公司看看，你会发现程序员的主力都是90后了，80后都很少，至于70后几乎绝迹。那么一个有趣的话题是：「70后的程序员都消失了吗？」";
    
    DataModel *dataModel2 = [[DataModel alloc] init];
    dataModel2.weiboContent = @"30-35岁这个阶段，最关键的是了解自己。知道自己擅长什么，自己的优势在哪里，怎样才能够最大化自己的价值，同时也知道自己有什么缺陷，怎样避开做自己不擅长的事情，不勉强自己，不让自己处于对自己不利的环境，这是人生的智慧。一个人能够客观的认识自己是非常困难的，很多人终其一生都没有活明白，既不知道怎样发挥自己的天赋，也拒绝承认自己的缺陷。在35岁以后，要接受一个不完美的自己，知道怎样扬长避短，最大化个人价值。能够做到这一步的程序员，人到中年完全不是程序员生涯的终结，反而会走向个人事业的巅峰。";
    
    [self.tableDataArr addObjectsFromArray:@[dataModel2,dataModel1]];
    
    self.plainTableView.separatorColor = [UIColor redColor];
    [self.plainTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kTableCellID];
    [self.plainTableView reloadData];
}


#pragma mark - /*** UITaleviewDelegate ***/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel *model = self.tableDataArr[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellID];
    [cell getHeightByModel:self.tableDataArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
