//
//  NewsByZhangViewController.m
//  News
//
//  Created by scjy on 15/12/29.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import "NewsByZhangViewController.h"
#import "NewByZhangTableViewCell.h"
@interface NewsByZhangViewController ()
@property(nonatomic, retain) UITableView *tableView;
@end

@implementation NewsByZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor redColor];
    
    
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
}
/**
 *  懒加载（setter）
 */
- (UITableView *)tableview{
    
    //先判断实例变量是否存在
    if (_tableView==nil) {
        //如果不存在就去创建一个
        
        self.tableView=[[UITableView alloc]initWithFrame:self.view.frame  style:UITableViewStylePlain];
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        
        
        
        self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"head_15.jpg"]];
        self.tableView.separatorColor=[UIColor blackColor];
        
        
    }
    
    
    return _tableView;

    
}



#pragma mark ---代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 22;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"zhang";
    
    NewByZhangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    
    if (cell == nil) {
        cell=[[NewByZhangTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    
    
    return cell;
    
    
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
