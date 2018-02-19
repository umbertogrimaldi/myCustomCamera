//
//  MySelfiesViewController.swift
//  myCustomCamera
//
//  Created by UMBERTO GRIMALDI on 17/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import UIKit

class MySelfiesViewController: UITableViewController {

    
    @IBOutlet weak var firstCollection: UICollectionView!
    @IBOutlet weak var secondCollection: UICollectionView!
    
    
    var firstImageArray: [UIImage] = [#imageLiteral(resourceName: "Front Camera Icon"), #imageLiteral(resourceName: "flash"), #imageLiteral(resourceName: "close"),#imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "Video Camera Icon"), #imageLiteral(resourceName: "camera")]
    
    var secondImageArray: [UIImage] = [#imageLiteral(resourceName: "Front Camera Icon"), #imageLiteral(resourceName: "flash"), #imageLiteral(resourceName: "close"),#imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "export"), #imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "Video Camera Icon"), #imageLiteral(resourceName: "camera"), #imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "flash"), #imageLiteral(resourceName: "flash"), #imageLiteral(resourceName: "camera"), #imageLiteral(resourceName: "Video Camera Icon"), #imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "close")]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstCollection.dataSource = self
        firstCollection.delegate = self
        
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red:0.17, green:0.67, blue:0.71, alpha:1.0)]
    }


    //    MARK: UITableViewDatasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myRow") as! FirstTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myRow2") as! TableViewCell
            return cell
        }
    }
    
    //    MARK: - MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 233
        }else {
            return 600
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            
           let headerLabel = UILabel()
            headerLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
            headerLabel.textColor = UIColor(red:0.17, green:0.67, blue:0.71, alpha:1.0)
            headerLabel.text = "Favorites"
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            headerLabel.frame = headerLabel.frame.offsetBy(dx: 20, dy: 15)
            
            return headerView
        } else {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            
            let headerLabel = UILabel()

            headerLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
            headerLabel.textColor = UIColor(red:0.17, green:0.67, blue:0.71, alpha:1.0)
            headerLabel.text = "All"
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            headerLabel.frame = headerLabel.frame.offsetBy(dx: 20, dy: 15)
            return headerView
        }
    }
    
    
}

extension MySelfiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return firstImageArray.count
        } else {
            return secondImageArray.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        } else {
            
            return cell
        }
    }


}

