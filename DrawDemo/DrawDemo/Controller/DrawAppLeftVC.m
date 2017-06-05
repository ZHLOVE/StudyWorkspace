//
//  DrawAppLeftVC.m
//  DrawDemo
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawAppLeftVC.h"
#import <OKFrameDefiner.h>

@interface DrawAppLeftVC ()

@end

@implementation DrawAppLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
    headView.backgroundColor = [UIColor orangeColor];
    
    self.plainTableView.tableHeaderView = headView;
    self.plainTableView.rowHeight = 80;
}

#pragma Mark - 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[OKBaseViewController new] animated:YES];
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
