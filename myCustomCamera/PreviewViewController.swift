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

    
    
//    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PhotoShared.shared.myPhotoArray.count)
        myPhotoCollectionView.delegate = self
        myPhotoCollectionView.dataSource = self
        
//        photo.image = self.image
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        PhotoShared.shared.myPhotoArray.removeAll()

//        for x in 0...(PhotoShared.shared.myPhotoArray.count) - 1 {
//            PhotoShared.shared.myPhotoArray.remove(at: x)
//        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! UICollectionViewCell
        let photoCell = cell.viewWithTag(1) as! UIImageView
        photoCell.image = PhotoShared.shared.myPhotoArray[indexPath.row]
        
        return cell
    }
    
    
    //    MARK:-
    
    
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
