//
//  SigninWebViewController.h
//  Design
//
//  Created by Jason Prasad on 10/7/19.
//  Copyright © 2019 Design. All rights reserved.
//

#import <WebKit/WebKit.h>

@protocol SigninWebViewDelegate

- (void)onReceivedJWT:(NSString *)jwt;

@end

@interface SigninWebViewController : UIViewController

@property (nonatomic, weak) id<SigninWebViewDelegate> delegate;

@end
