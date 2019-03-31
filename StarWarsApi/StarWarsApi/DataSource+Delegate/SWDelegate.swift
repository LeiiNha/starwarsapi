//
//  SWDelegate.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import UIKit

protocol SWDelegate {
    func updateCollectionView()
    func updateCellObject(_ cell: SWCollectionViewCell, _ obj: AnyObject)
}
