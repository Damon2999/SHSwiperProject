//
//  SHSwipeBaseController.m
//  HelloSunshine
//
//  Created by damon on 16/7/10.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "SHSwipeBaseController.h"
#import "Masonry.h"

#define SHNaviBarH                   44
#define SHScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define default_btnSize CGSizeMake(SHScreenWidth/4.0, (SHNaviBarH-20)>20?(SHNaviBarH-20):20)


@interface SHSwipeBaseController ()
@property (nonatomic,retain) UIScrollView *contentView;
@property (nonatomic,retain) UIView *navigationView;
@property (nonatomic,retain) NSMutableArray<UIButton *> *mButtonArray;

@end

@implementation SHSwipeBaseController{

    UIView *lineV;
    int selectedIndex;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.buttonSize.width == 0) {
       self.buttonSize = default_btnSize;
    }
   
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.topItem.titleView = self.navigationView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setContentDatas:(NSArray *)contentDatas{
    
    _contentDatas = contentDatas;
    [self.contentObjects removeAllObjects];
    [self.mButtonArray removeAllObjects];
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.navigationView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIButton *lastBtn;

    for (int i = 0;i<_contentDatas.count;i++) {
        
        
        id obj = _contentDatas[i];
        BOOL isController = [obj isKindOfClass:[UIViewController class]];
        NSAssert(isController||[obj isKindOfClass:[NSString class]],@"contentObj must be NSString or UIViewController,Buddy!");
        
        
        UIButton *vButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [vButton setBackgroundColor:[UIColor whiteColor]];
        [vButton setTitle:isController?[obj valueForKey:@"title"]:obj forState:UIControlStateNormal];
        [vButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [vButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [vButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [vButton setTag:i];
        [vButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationView addSubview:vButton];
        [self.mButtonArray addObject:vButton];
        if (lastBtn) {
            [vButton mas_makeConstraints:^(MASConstraintMaker *make) {
          
                make.left.equalTo(lastBtn.mas_right);
                make.centerY.equalTo(lastBtn);
                make.width.equalTo(@(self.buttonSize.width));
                make.height.equalTo(@(self.buttonSize.height));
            }];
        }else{
            
            [vButton mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.equalTo(self.navigationView).offset(-5);
                make.width.equalTo(@(self.buttonSize.width));
                make.height.equalTo(@(self.buttonSize.height));
            }];
            
        }
        
        lastBtn = vButton;
        
        
        if (isController) {
            
            UIView *view = [obj valueForKey:@"view"];
            [self.contentView addSubview:view];
            [self.contentObjects addObject:obj];
            [self addChildViewController:obj];
            view.tag = i;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.width.height.equalTo(self.contentView);
                make.left.equalTo(self.contentView.mas_left).offset(i*self.view.frame.size.width);
            }];
            
            [obj addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
            
            
        }else{
        
            UITableView *vCustomTableView = [[UITableView alloc] init];
            vCustomTableView.delegate = self.tableDelegate;
            vCustomTableView.dataSource = self.tableDelegate;
            vCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            vCustomTableView.tag = i;
            
            [self.contentView addSubview:vCustomTableView];
            [self.contentObjects addObject:vCustomTableView];
            [vCustomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.width.height.equalTo(self.contentView);
                make.left.equalTo(self.contentView.mas_left).offset(i*self.view.frame.size.width);
            }];
        
        }
        
        
    }
    
    [self.contentView setContentSize:CGSizeMake(self.view.frame.size.width * _contentDatas.count, 1)];
    
    if (contentDatas.count*self.buttonSize.width < SHScreenWidth) {
        int centerIndex = (int)contentDatas.count/2;
        UIButton *button = self.mButtonArray[centerIndex];
        if (contentDatas.count%2==0) {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.navigationView.mas_centerX);
                
            }];
            
        }else{
            
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.navigationView.mas_centerX);
                
            }];
            
            
        }
        
    }


    UIButton *btn = self.mButtonArray[0];
    btn.selected = YES;
    lineV  = [UIView new ];
    lineV.backgroundColor  = [UIColor colorWithRed:(0)/255.0f green:(170)/255.0f blue:(229)/255.0f alpha:1];
    [self.navigationView addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.width.equalTo(@(self.buttonSize.width*0.8));
        make.height.equalTo(@2);
        make.bottom.equalTo(self.navigationView);
    }];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
     if ([keyPath isEqualToString:@"title"]) {
         NSInteger index = [self.contentObjects indexOfObject:object];
         if (index!=NSNotFound&&index<self.mButtonArray.count) {
             UIButton *button = self.mButtonArray[index];
             [button setTitle:[change objectForKey:@"new"] forState:UIControlStateNormal];
         }
         
    }
 }




-(void)setTableDelegate:(id<UITableViewDelegate,UITableViewDataSource>)tableDelegate{
    
    _tableDelegate = tableDelegate;
    for (UITableView *table in self.contentObjects) {
        if ([table isKindOfClass:[UITableView class]]) {
            table.delegate = _tableDelegate;
            table.dataSource = _tableDelegate;
        }

    }

}

-(void)menuButtonClicked:(UIButton *)sender{
    
    CGRect vMoveRect = CGRectMake(self.view.frame.size.width * sender.tag, 0, self.view.frame.size.width, self.contentView.contentSize.height);
    [self.contentView scrollRectToVisible:vMoveRect animated:YES];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.contentView) {
    if(self.mButtonArray.count>0){
        
        UIButton *vButton = self.mButtonArray[0];
        [lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(vButton.mas_centerX).offset(self.mButtonArray.count*self.buttonSize.width/scrollView.contentSize.width*scrollView.contentOffset.x);
            make.width.equalTo(@(self.buttonSize.width*0.8));
            make.height.equalTo(@2);
            make.bottom.equalTo(self.navigationView);
        }];


    }
    }

}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   [self uudateBtnStatus:scrollView];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self uudateBtnStatus:scrollView];
   
}

-(void)uudateBtnStatus:(UIScrollView *)scrollView{

    if (scrollView == self.contentView) {
        int page = (self.contentView.contentOffset.x+self.contentView.frame.size.width /2.0) / self.contentView.frame.size.width;
        
        if (selectedIndex!=page) {
            
            if (page<self.mButtonArray.count&&self.mButtonArray.count>0) {
                UIButton *btn = [self.mButtonArray objectAtIndex:page];
                btn.selected = YES;
                btn = [self.mButtonArray objectAtIndex:selectedIndex];
                btn.selected = NO;
                
            }
            
            selectedIndex = page;
            if (self.changedToIndex) {
                self.changedToIndex(page);
            }
            
        }
        
    }



}




-(void)setButtonSize:(CGSize)buttonSize{
    _buttonSize = buttonSize;
    if (_buttonSize.width==0) {
        _buttonSize = default_btnSize;
    }
    
    for (UIButton *vButton in self.mButtonArray) {
        [vButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(_buttonSize.width));
            make.height.equalTo(@(_buttonSize.height));
        }];
    }
    int page = (self.contentView.contentOffset.x+self.contentView.frame.size.width /2.0) / self.contentView.frame.size.width;
    UIButton *selectBtn = page<self.mButtonArray.count?self.mButtonArray[page]:nil;
    [lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        if (selectBtn) {
            make.centerX.equalTo(selectBtn);
            make.width.equalTo(@(self.buttonSize.width*0.8));
            make.height.equalTo(@2);
            make.bottom.equalTo(self.navigationView);
        }

    }];

}




-(NSMutableArray *)mButtonArray{
    if (!_mButtonArray) {
        _mButtonArray = [NSMutableArray new];
    }
    return _mButtonArray;

}


-(UIView *)navigationView{

    if (!_navigationView) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SHScreenWidth,SHNaviBarH)];
        
    }
    return _navigationView;

}


-(UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        [self.view addSubview:_contentView];
        _contentView.pagingEnabled = YES;
        
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.delegate = self;
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.width.height.equalTo(self.view);
        }];
        
    }
   
    return _contentView;

}


-(NSArray *)contentObjects{
    if (!_contentObjects) {
        _contentObjects = [NSMutableArray new];
    }
    return _contentObjects;
}



@end
