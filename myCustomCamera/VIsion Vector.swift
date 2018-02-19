//
//  VIsion Vector.swift
//  myCustomCamera
//
//  Created by Michele De Sena on 16/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import Foundation
import Vision
import UIKit

class VisionVector{
    let imageSource = #imageLiteral(resourceName: "Screen Shot 2017-11-09 at 22.07.43")
    let request = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
        //gestione errore
        
        let results = request.results as? [VNFaceObservation]
        
        })
}
