//
//  DesignViewController.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import UIKit

class DesignViewController: UIViewController {
    static var cellReuseIdentifier = "DesignCell"
    var authorization: String!
    var inspiration: [Inspiration] = []
    var tableView: UITableView!
    var webView: SigninWebView!
}

extension DesignViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DesignTableViewCell.self, forCellReuseIdentifier: DesignViewController.cellReuseIdentifier)
        
        webView = SigninWebView()
        webView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(webView.view)
        view.addSubview(SplashView())
        
        setupConstraints()
    }
}

extension DesignViewController: SigninWebViewDelegate {
    func onReceivedJWT(_ jwt: String?) {
        if let jwt = jwt {
            authorization = jwt
            API().fetch(.inspiration(count: 10)) { (inspiration: [Inspiration]?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    self.inspiration = inspiration ?? []
                    self.tableView.reloadData()
                }
            }
        }
        
        webView.view.dissolveFromSuperview(duration: 1)
    }
}

extension DesignViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inspiration.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DesignViewController.cellReuseIdentifier, for: indexPath) as! DesignTableViewCell
        cell.take(inspiration[indexPath.row], authorization: authorization)
        return cell
    }
}

extension DesignViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 322
    }
}

extension DesignViewController {
    func setupConstraints() {
        view.addConstraints([
            .init(item: tableView!,
                  attribute: .top,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .topMargin,
                  multiplier: 1,
                  constant: 0),
            .init(item: tableView!,
                  attribute: .trailing,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .trailingMargin,
                  multiplier: 1,
                  constant: 0),
            .init(item: tableView!,
                  attribute: .bottom,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .bottomMargin,
                  multiplier: 1,
                  constant: 0),
            .init(item: tableView!,
                  attribute: .leading,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .leadingMargin,
                  multiplier: 1,
                  constant: 0),
        ])
    }
}
