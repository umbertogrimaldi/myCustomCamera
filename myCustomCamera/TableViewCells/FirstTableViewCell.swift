//
//  TableViewCell.swift
//  myCustomCamera
//
//  Created by UMBERTO GRIMALDI on 16/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import UIKit

//class FirstTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    
//
//    
//    var FirstImageArray: [UIImage] = [#imageLiteral(resourceName: "Front Camera Icon"), #imageLiteral(resourceName: "flash"), #imageLiteral(resourceName: "close"),#imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "Video Camera Icon"), #imageLiteral(resourceName: "camera")]
//    
//    
//    @IBOutlet weak var selfiesCollection: UICollectionView!
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        
//        selfiesCollection.delegate = self
//        selfiesCollection.dataSource = self
//        
//        
//        //        MARK:- SETTING COLLECTION VIEW INSETS
//        
//        var insets = self.selfiesCollection.contentInset
//        
//        insets.left = 20
//        insets.right = 20
//        insets.top = 8
//        
//        self.selfiesCollection.contentInset = insets
//        self.selfiesCollection.decelerationRate = UIScrollViewDecelerationRateNormal
//        selfiesCollection.backgroundColor = UIColor.white
//   
//    }
//    
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
//        cell.layer.borderWidth = 0.5
//        
//        let cellImage = cell.viewWithTag(1) as! UIImageView
//        cellImage.image = imageArray[indexPath.row]
//        cell.layer.cornerRadius = 5
//        
//        return cell
//    }
//
//    
//}






