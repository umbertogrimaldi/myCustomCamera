//
//  PreviewViewController.swift
//  myCustomCamera
//
//  Created by UMBERTO GRIMALDI on 05/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myPhotoCollectionView: UICollectionView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var mySessionCollectionView: UIImageView!

    var centerPoint: CGPoint = CGPoint(x: 200, y: 400)
    
//    var image: UIImage!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.myPhotoCollectionView.contentInset
        let value = (self.view.frame.size.width - (self.myPhotoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        self.myPhotoCollectionView.contentInset = insets
        self.myPhotoCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        myPhotoCollectionView.backgroundColor = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(PhotoShared.shared.myPhotoArray.count)
        myPhotoCollectionView.delegate = self
        myPhotoCollectionView.dataSource = self
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        PhotoShared.shared.myPhotoArray.removeAll()
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoShared.shared.myPhotoArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        let photoCell = cell.viewWithTag(1) as! UIImageView
        photoCell.image = PhotoShared.shared.myPhotoArray[indexPath.row]
        cell.backgroundColor = .white
        
        return cell
    }
    
    
    //    MARK:-
    
    private func findCenterIndex() {
        let center = view.convert(self.myPhotoCollectionView.center, to: self.myPhotoCollectionView)
        if let index = myPhotoCollectionView!.indexPathForItem(at:center) {
            print(index)
            photo.image = PhotoShared.shared.myPhotoArray[index.row]
        }
        print("index not found")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        findCenterIndex()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        findCenterIndex()
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        findCenterIndex()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        findCenterIndex()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        findCenterIndex()
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        findCenterIndex()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



