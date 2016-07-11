//
//  SHSwipeBaseController.h
//  HelloSunshine
//
//  Created by damon on 16/7/10.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSwipeBaseController : UIViewController <UIScrollViewDelegate>


@property(nonatomic,retain) NSArray *contentDatas;    //导航栏菜单标题数组
@property(nonatomic,retain) NSMutableArray *contentObjects;
@property(nonatomic,assign) CGSize buttonSize;
@property (nonatomic,assign) id <UITableViewDelegate,UITableViewDataSource> tableDelegate;


@property(nonatomic,copy) void(^changedToIndex)(int index);


@end
