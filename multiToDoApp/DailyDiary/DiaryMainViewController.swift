//
//  DiaryMainViewController.swift
//  multiToDoApp
//
//  Created by Ransi on 2022-08-21.
//

import UIKit

class DiaryMainViewController: UIViewController {

    override func viewDidLoad() {

        let image = UIImage(named: "HeaderBg.jpg")
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "HeaderBg.jpg")
    
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
