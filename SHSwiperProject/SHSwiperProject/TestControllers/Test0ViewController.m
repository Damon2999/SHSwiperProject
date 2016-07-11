//
//  Test0ViewController.m
//  SHSwiperProject
//
//  Created by Maobai on 16/7/11.
//  Copyright © 2016年 Mallby. All rights reserved.
//

#import "Test0ViewController.h"
#import "Masonry.h"

@interface Test0ViewController ()

@end

@implementation Test0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 6.0f;
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@80);
        
    }];

    [button setTitle:@"点我改title" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)onClick:(id)sender{

    NSInteger number =  arc4random();
    self.title = [NSString stringWithFormat:@"%ld",number];
    
    //修改title上面菜单会通过kvo自动同步

    

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
