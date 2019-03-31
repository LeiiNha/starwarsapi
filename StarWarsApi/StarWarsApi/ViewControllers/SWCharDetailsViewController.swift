//
//  SWCharDetailsViewController.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import WebKit

class SWCharDetailsViewController: UIViewController {
    let person: SWPerson
    let vehicles: [SWVehicle]?
    let specie: SWSpecie?
    let planet: SWPlanet?
    
    var label: UILabel?

    init(person: SWPerson, vehicles: [SWVehicle]?, specie: SWSpecie?, planet: SWPlanet?) {
        self.person = person
        self.vehicles = vehicles
        self.specie = specie
        self.planet = planet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
}

private extension SWCharDetailsViewController {
    
    func configureView() {
        self.view.backgroundColor = SWColorScheme.black
        self.generateLabel()
        self.generateSearchWebView()
    }
    
    func generateLabel() {
        label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 0.0))
        guard let label = label else { return }
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = SWColorScheme.whiteSmoke
        label.text = self.generateText()
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.layoutIfNeeded()
    }
    
    func generateSearchWebView() {
        guard let label = label else { return }
        let webView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 0.0))
        guard let name = person.name else { return }
        let searchTerm: String = name.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "https://google.com.br/search?q=" + searchTerm) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        webView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        webView.layoutIfNeeded()
    }
    
    func generateText() -> String {
        var charDetails: String = ""
        if let name = person.name {
            charDetails.append(contentsOf: "Name: " + name)
        }
        if let gender = person.gender {
            charDetails.append(contentsOf: "\nGender: " + gender)
        }
        if let homePlanet = planet, let homePlanetName = homePlanet.name {
            charDetails.append(contentsOf: "\nHomePlanet: " + homePlanetName)
        }
        if let skinColor = person.skinColor {
            charDetails.append(contentsOf: "\nSkin Color: " + skinColor)
        }
        if let vehiclesUrls = self.vehicles {
            let vehiclesNames = vehiclesUrls.map({ return ($0.name ?? "") })
            charDetails.append(contentsOf: "\nVehicles: " + vehiclesNames.joined(separator: "\n"))
        }
        return charDetails
    }
}
