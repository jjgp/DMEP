//
//  SigninWebView.swift
//  Design
//
//  Created by Jason Prasad on 10/2/19.
//  Copyright © 2019 Design. All rights reserved.
//

import UIKit
import WebKit

@objc protocol SigninWebViewDelegate {
    func onReceivedJWT(_ jwt: String?)
}

class SigninWebView: UIViewController {
    @objc weak var delegate: SigninWebViewDelegate?
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
        webView.configuration.userContentController.add(self, name: "signin")
        view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "http://localhost:8081/signin")!))
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
}

extension SigninWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let body = message.body as? [String: String]
        let jwt = body.flatMap {
            $0["jwt"]
        }
        delegate?.onReceivedJWT(jwt)
    }
}

extension SigninWebView {
    func setupConstraints() {
        view.addConstraints([
            .init(item: webView!,
                  attribute: .top,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .top,
                  multiplier: 1,
                  constant: 0),
            .init(item: webView!,
                  attribute: .trailing,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .trailing,
                  multiplier: 1,
                  constant: 0),
            .init(item: webView!,
                  attribute: .bottom,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .bottom,
                  multiplier: 1,
                  constant: 0),
            .init(item: webView!,
                  attribute: .leading,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .leading,
                  multiplier: 1,
                  constant: 0),
        ])
    }
}
