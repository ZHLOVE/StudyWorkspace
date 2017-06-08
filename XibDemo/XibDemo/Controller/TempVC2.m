//
//  TempVC2.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "TempVC2.h"

@interface TempVC2 ()

@end

@implementation TempVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"self.view===%@===%zd",self.view,self.view.tag);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *xibArr = [[NSBundle mainBundle] loadNibNamed:@"TempVC2" owner:self options:nil];
    
    for (UIView *xibView in xibArr) {
        NSLog(@"当前所以子视图====%@===%zd",xibView,xibView.tag);
        
        if (xibView.tag == 2017) {
            NSLog(@"xibView.tag==2017: =======%@",xibView);
            
        } else if (xibView.tag == 2015) {
            NSLog(@"xibView.tag==2015: =======%@",xibView);
            
            xibView.bounds = CGRectMake(0, 0, 200, 200);
            xibView.center = self.view.center;
            [self.view addSubview:xibView];
        }
    }

}

- (IBAction)addSubViewAction:(UIButton *)sender
{

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
