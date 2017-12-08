//
//  PracticeViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/20.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "PracticeViewController.h"
#import "DetailCell.h"

@interface PracticeViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation PracticeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.practiceDataArr = [[NSMutableArray alloc] init];
    self.practiceDataArr = self.model.stepsArr;
    [self createTableView];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.practiceDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell= [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    [cell showDataWithArray:self.practiceDataArr[indexPath.row]];
    cell.userInteractionEnabled = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *imageDict = self.dataArr[indexPath.row];
    NSString *steps = imageDict[@"step"];
    CGFloat h = [LZXHelper textHeightFromTextString:steps width:kScreenSize.width - 20 fontSize:16];
    
    return h + [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:205] + 5;
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
