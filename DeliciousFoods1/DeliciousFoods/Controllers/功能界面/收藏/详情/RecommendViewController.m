//
//  RecommendViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController () <UIWebViewDelegate>
{
    UIWebView *webView;
    float height;
    UIScrollView *scrollView;
    AFHTTPRequestOperationManager *_manager;
}
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [self createWebView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)createWebView{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64)];
    //NSURL *url = [NSURL URLWithString:self.url];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:request];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    NSString *utfUrl = self.url;
    utfUrl = [utfUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* newStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        
        newStr = [newStr stringByReplacingOccurrencesOfString:@"文章来源于网友发布,仅供参考" withString:@""];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"内容版权声明" withString:@""];
        
        
        [webView loadHTMLString:newStr baseURL:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");

    }];
    
    
    [self.view addSubview:webView];
    
    //CGFloat sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
}

//webview 将要开始加载的时候 调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //NSLog(@"url:%@",request.URL.absoluteString);
    //url:http://ku.m.chinanews.com/wapapp/cns/gn/zw/7519606.shtml?target=_self
    if ([request.URL.absoluteString hasSuffix:@"target=_self"]) {
        return NO;
    }
    
    NSLog(@"开始请求数据");
    return YES;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [UIWebView animateWithDuration:1 animations:^{
//    self.tabBarController.tabBar.frame = CGRectMake(0, kScreenSize.height - 49, kScreenSize.width, 49);
//    }];
//    
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    [UIWebView animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.frame = CGRectMake(0, kScreenSize.height, kScreenSize.width, 49);
//    }];
//    
//    
//}
//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
