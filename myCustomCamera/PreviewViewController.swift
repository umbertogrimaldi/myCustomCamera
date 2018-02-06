//
//  PreviewViewController.swift
//  myCustomCamera
//
//  Created by UMBERTO GRIMALDI on 05/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myPhotoArray: [UIImage] = []
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPhotoArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! UICollectionViewCell
        let photoCell = cell.viewWithTag(1) as! UIImageView
        photoCell.image = myPhotoArray[indexPath.row]
        
        return cell
    }
    
    
    var image: UIImage!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var mySessionCollectionView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myPhotoArray.count)
        
//        photo.image = self.image
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
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
