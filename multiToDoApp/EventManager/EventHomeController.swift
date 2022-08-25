//
//  EventHomeController.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation
import UIKit


class EventHomeController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    var modelData = ["Oliver","Harry","George","Jack","Noah", "Oliver","Harry","George","Jack","Noah","Oliver","Harry","George","Jack","Noah"]

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            // 1
            return 1
        }


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // 2
            return modelData.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
            // Configure the cell
            // 3
            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = modelData[indexPath.row]
            }
        
            return cell
        }

    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
            return view
        }
        fatalError("Unexpected kind")
    }
    

}
