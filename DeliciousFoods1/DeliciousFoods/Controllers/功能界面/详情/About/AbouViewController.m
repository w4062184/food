//
//  AbouViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/20.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "AbouViewController.h"

@interface AbouViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableArr;

@end

@implementation AbouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArr = [[NSMutableArray alloc] init];
    self.aboutModel = self.model;
    [self createLabel];

}

- (void)createLabel{
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenSize.width-20, 75)];
    label.text = [NSString stringWithFormat:@"%@",self.aboutModel.tags];
    //NSLog(@"%@",label.text);
    label.font = [UIFont systemFontOfSize:16];
    
    CGRect labelFrame = label.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:self.aboutModel.tags width:kScreenSize.width - 20 fontSize:16];
    labelFrame.size.height = h;
    label.frame = labelFrame;

    //label.backgroundColor = [UIColor redColor];
    label.numberOfLines = 0;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenSize.width-20, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:260])];
    CGRect label1Frame = label1.frame;
    CGFloat h1 = [LZXHelper textHeightFromTextString:self.aboutModel.imtro width:kScreenSize.width - 20 fontSize:16];
    label1Frame.size.height = h1+5;
    label1.frame = label1Frame;
    self.h1 = h + 10;
    label1.text = [NSString stringWithFormat:@"%@",self.aboutModel.imtro];
    label1.font = [UIFont systemFontOfSize:16];
    self.h2 = h1 + 10;
    //label1.backgroundColor = [UIColor yellowColor];
    label1.numberOfLines = 0;
    //NSLog(@"%f",self.h);
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
