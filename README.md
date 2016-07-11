# SHSwiperProject
nav滑动切换viewcontroller


 用法：把自己的controller继承SHSwipeBaseController就完事了。。。
第一种用法，直接添加自定义的Viewcontroller
    Test0ViewController *vc0 = [Test0ViewController new];
    Test1ViewController *vc1 = [Test1ViewController new];
    Test2ViewController *vc2 = [Test2ViewController new];
     vc0.title = @"第一个";
     vc1.title = @"第二个";
     vc2.title = @"第三个";
    self.contentDatas = @[vc0,vc1,vc2];


第二种用法，不添加viewcontroller，只添加几个title,这种方法self.contentObjects是默认的uitableview，
   可以设置self.tableDelegate = self 后填充tableview的数据和代理方法
    self.contentDatas = @[@"第一个title",@"第二个",@"第三个"];

  

其他用法，混合
    Test0ViewController *vc0 = [Test0ViewController new];
    vc0.title = @"Test0View";
    self.contentDatas = @[vc0,@"第二个",@"第三个"];
    self.tableDelegate = self;
    

  //修改vc的title菜单会自动同步
   // vc0.title = @"changed";
    
