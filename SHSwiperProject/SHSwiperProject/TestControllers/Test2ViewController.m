//
//  Test0ViewController.m
//  SHSwiperProject
//
//  Created by Maobai on 16/7/11.
//  Copyright © 2016年 Mallby. All rights reserved.
//

#import "Test2ViewController.h"
#import "Masonry.h"
#import "TestOtherViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 6.0f;
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@80);
        
    }];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    
}


-(void)onClick:(id)sender{

    [self.navigationController pushViewController:[TestOtherViewController new] animated:YES];

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
