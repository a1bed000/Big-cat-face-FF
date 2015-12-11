//
//  WebVC.m
//  YYSportsProject
//
//  Created by k on 15/11/19.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate =self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
