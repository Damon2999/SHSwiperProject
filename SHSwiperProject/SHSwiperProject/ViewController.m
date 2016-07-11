//
//  ViewController.m
//  SHSwiperProject
//
//  Created by Maobai on 16/7/11.
//  Copyright © 2016年 Mallby. All rights reserved.
//

#import "ViewController.h"
#import "Test0ViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //用法：把自己的controller继承SHSwipeBaseController就完事了。。。
    
    
    //第一种用法，直接添加自定义的Viewcontroller
    /*
    Test0ViewController *vc0 = [Test0ViewController new];
    Test1ViewController *vc1 = [Test1ViewController new];
    Test2ViewController *vc2 = [Test2ViewController new];
     vc0.title = @"第一个";
     vc1.title = @"第二个";
     vc2.title = @"第三个";
    
    self.contentDatas = @[vc0,vc1,vc2];
     NSLog(@"%@",self.contentObjects);
    */
    
    
    

    
    //第二种用法，不添加viewcontroller，只添加几个title,这种方法self.contentObjects是默认的uitableview，
    //可以设置self.tableDelegate = self 后填充tableview的数据和代理方法
    /*
    self.contentDatas = @[@"第一个title",@"第二个",@"第三个"];
    NSLog(@"%@",self.contentObjects);
    */
    
    
    
    
    
    //其他用法，混合
    Test0ViewController *vc0 = [Test0ViewController new];
    vc0.title = @"Test0View";
    self.contentDatas = @[vc0,@"第二个",@"第三个"];
    self.tableDelegate = self;
     NSLog(@"%@",self.contentObjects);
    

    //修改vc的title菜单会自动同步
   // vc0.title = @"changed";
    
    
}








//如果只设置了title，并没传controller，可以自己实现table的cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80   ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0 ) {
        return 0;
    }
    return 15   ;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell ) {
        cell = [UITableViewCell new];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个table第%ld个cell",tableView.tag,indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //self.buttonSize可以改变菜单button的大小
    switch (tableView.tag) {
        case 0:
            self.buttonSize = CGSizeMake(80, 20);
            break;
        case 1:
            self.buttonSize = CGSizeMake(100, 30);
            break;
        case 2:
            self.buttonSize = CGSizeMake(120, 40);
            break;
            
        default:
            break;
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
