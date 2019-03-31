//
//  AboutViewController.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    var label: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = SWColorScheme.black
        self.generateLabel()
        //Enable to check resume aswell
        //self.generateSearchWebView()
    }
    func generateLabel() {
        label = UILabel(frame: CGRect.zero)
        guard let label = label else { return }
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = SWColorScheme.whiteSmoke
        label.textAlignment = .center
        label.text = "Érica Geraldes - 05/12/1991"
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.layoutIfNeeded()
    }
    func generateSearchWebView() {
        let webView = WKWebView(frame: CGRect.zero)
        guard let url = Bundle.main.url(forResource: "Curriculum", withExtension: "pdf") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        self.view.addSubview(webView)
        guard let label = label else { return }
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        webView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        webView.layoutIfNeeded()
        webView.layoutIfNeeded()
    }
}
