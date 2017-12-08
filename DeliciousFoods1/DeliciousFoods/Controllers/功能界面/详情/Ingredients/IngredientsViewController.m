//
//  IngredientsViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/20.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "IngredientsViewController.h"

@interface IngredientsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableArr;
@end

@implementation IngredientsViewController

- (void)createLabel{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenSize.width-20, 50)];
    label.text = [NSString stringWithFormat:@"%@",self.ingredientsModel.ingredients];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    CGRect labelFrame = label.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:self.ingredientsModel.ingredients width:kScreenSize.width - 20 fontSize:16];
    labelFrame.size.height = h;
    label.frame = labelFrame;
    self.h1 = h+10;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenSize.width-20, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:220])];
    CGRect label1Frame = label1.frame;
    CGFloat h1 = [LZXHelper textHeightFromTextString:self.ingredientsModel.burden width:kScreenSize.width - 20 fontSize:16];
    label1Frame.size.height = h1;
    self.h2 = h1+10;
    label1.frame = label1Frame;
    label1.text = [NSString stringWithFormat:@"%@",self.ingredientsModel.burden];
    label1.font = [UIFont systemFontOfSize:16];
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    self.tableArr = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableArr addObject:label];
    [self.tableArr addObject:label1];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.contentView addSubview:self.tableArr[indexPath.row]];
    cell.userInteractionEnabled = NO;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.h1;
    }else{
        return self.h2;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ingredientsModel = self.model;
    [self createLabel];

    
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
