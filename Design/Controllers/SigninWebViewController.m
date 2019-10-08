//
//  SigninWebViewController.m
//  Design
//
//  Created by Jason Prasad on 10/7/19.
//  Copyright © 2019 Design. All rights reserved.
//

#import "SigninWebViewController.h"

@interface SigninWebViewController () <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation SigninWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                      configuration:[[WKWebViewConfiguration alloc] init]];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"observe"];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8081/signin"]]];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self setupWebViewConstraints];
}

- (void)setupWebViewConstraints {
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0],
    ]];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSArray *body = (NSArray *)message.body;
    [self.delegate onReceivedJWT:body.firstObject[@"jwt"]];
}

@end
