//
//  MenusViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "MenusViewController.h"
#import "MenusTableViewCell.h"
#import "SearchViewController.h"

@interface MenusViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MenusViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createDataArr];
    [self createSearchbar];
    self.title = @"菜谱";
    // Do any additional setup after loading the view from its nib.
}


- (void)createSearchbar{
    //    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    self.navigationItem.rightBarButtonItem = search;
    
}

- (void)searchClick:(UIButton *)button{
    
    SearchViewController *search = [[SearchViewController alloc] init];
    
    [self.navigationController pushViewController:search animated:YES];
}



- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:155];
    [self.view addSubview:self.tableView];
    self.dataArr = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenusTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenusTableViewCell"];
    
}

- (void)createDataArr{
    NSArray *namesArr = @[@"家常菜",@"快手菜",@"凉菜",@"创意菜",@"素菜",@"面食",@"烘焙"];
    NSArray *titlesArr = @[@"回家的诱惑",@"简单、快捷",@"爽口、方便",@"创新、美味",@"健康的生活",@"满满的都是爱",@"心暖暖的"];
    NSArray *imagesName = @[@"routine",@"fast",@"cold",@"idea",@"vegetable",@"food",@"cure"];
    
    for (int i = 0; i < 7; i++) {
        NSMutableArray *cellData = [[NSMutableArray alloc] initWithObjects:namesArr[i],titlesArr[i],imagesName[i], nil];
        
        [self.dataArr addObject:cellData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%ld",self.dataArr.count);
    return self.dataArr.count;
}

- (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue{
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return color;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenusTableViewCell" forIndexPath:indexPath];
    cell.arr = self.dataArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.nameLabel.textColor = [self colorWithRed:255 green:181 blue:197];
    }
    if (indexPath.row == 1) {
        cell.nameLabel.textColor = [self colorWithRed:205 green:92 blue:92];
    }
    if (indexPath.row == 2) {
        cell.nameLabel.textColor = [self colorWithRed:0 green:229 blue:238];
    }
    if (indexPath.row == 3) {
        cell.nameLabel.textColor = [self colorWithRed:255 green:114 blue:86];
    }
    if (indexPath.row == 4) {
        cell.nameLabel.textColor = [self colorWithRed:221 green:160 blue:221];
    }
    if (indexPath.row == 5) {
        cell.nameLabel.textColor = [self colorWithRed:255 green:99 blue:71];
    }
    if (indexPath.row == 6) {
        cell.nameLabel.textColor = [self colorWithRed:132 green:112 blue:255];
    }
    [cell showDataWithArr:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchViewController *detail = [[SearchViewController alloc] init];
    detail.searchKeyword = self.dataArr[indexPath.row][0];
    [self.navigationController pushViewController:detail animated:YES];
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
