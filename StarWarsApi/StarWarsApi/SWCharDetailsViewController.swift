//
//  SWCharDetailsViewController.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class SWCharDetailsViewController: UIViewController {
    let character: SWCharacter

    init(character: SWCharacter) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = SWColorScheme.black
        let label = UILabel(frame: self.view.frame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = self.character.getAttributedDescription()
        label.textColor = SWColorScheme.whiteSmoke
        label.textAlignment = .center
        label.center = self.view.center
        self.view.addSubview(label)
    }
}
