//
//  TestOtherViewController.m
//  SHSwiperProject
//
//  Created by Maobai on 16/7/11.
//  Copyright © 2016年 Mallby. All rights reserved.
//

#import "TestOtherViewController.h"

@interface TestOtherViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.contentDatas = @[@"One",@"Tow",@"Three"];
    self.tableDelegate = self;
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80   ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20   ;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell ) {
        cell = [UITableViewCell new];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个tableView",tableView.tag];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableView.tag) {
        case 0:
            self.buttonSize = CGSizeMake(80, 20);
            break;
        case 1:
            self.buttonSize = CGSizeMake(120, 40);
            break;
        case 2:
            self.buttonSize = CGSizeMake(150, 60);
            break;
            
        default:
            break;
    }
    
    
}


@end
