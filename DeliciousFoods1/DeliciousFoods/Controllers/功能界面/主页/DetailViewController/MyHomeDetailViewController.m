//
//  MyHomeDetailViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/26.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "MyHomeDetailViewController.h"

@interface MyHomeDetailViewController ()

@end

@implementation MyHomeDetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [super viewDidLoad];
    [self createImage];
    self.title = @"详情";
    // Do any additional setup after loading the view from its nib.
}
/**
 @property (weak, nonatomic) IBOutlet UIScrollView *baseScrollview;
 @property (weak, nonatomic) IBOutlet UIImageView *userImage;
 @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
 @property (weak, nonatomic) IBOutlet UILabel *commentLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *foodImage;
 @property (weak, nonatomic) IBOutlet UILabel *adressLabel;

 */
- (void)createImage{
    self.baseScrollview.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:self.pictureUrl] placeholderImage:[UIImage imageNamed:@"homePlaceHoder"]];
    self.commentLabel.text = self.comment;
    
    self.adressLabel.text = self.adress;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.userImageUrl] placeholderImage:[UIImage imageNamed:@"homeUserImage"]];
    self.userNameLabel.text = self.userName;
    
    CGRect labelFrame = self.commentLabel.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:self.comment width:kScreenSize.width - 10 fontSize:17];
    labelFrame.size.height = h;
    self.commentLabel.frame = CGRectMake(5, 60, kScreenSize.width - 10, h);
    
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 10;
    
    CGRect userImageFrame = self.foodImage.frame;
    userImageFrame.origin.y = CGRectGetMaxY(self.commentLabel.frame) + 5;
//    userImageFrame.size.height = [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:400];
    self.foodImage.frame = userImageFrame;
    self.thereLabel.frame = CGRectMake(5, CGRectGetMaxY(self.foodImage.frame) +5 , kScreenSize.width - 10, 20);
    
    CGFloat adressLabelH = [LZXHelper textHeightFromTextString:self.adress width:kScreenSize.width - 10 fontSize:17];
    self.adressLabel.frame = CGRectMake(5, CGRectGetMaxY(self.thereLabel.frame) + 5, kScreenSize.width - 10, adressLabelH);
    self.baseScrollview.contentSize = CGSizeMake(kScreenSize.width, CGRectGetMaxY(self.adressLabel.frame) + 180);


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
