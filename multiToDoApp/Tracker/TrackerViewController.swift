//
//  TrackerViewController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit


class TrackerViewController: UIViewController{
    
    override func viewDidLoad() {

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
    
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }

}
