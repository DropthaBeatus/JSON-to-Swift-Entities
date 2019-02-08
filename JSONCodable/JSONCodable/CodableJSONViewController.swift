//
//  CodableJSONViewController.swift
//  JSONCodable
//
//  Created by Liam Flaherty on 2/7/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import UIKit

class CodableJSONViewController: UIViewController {
    
    var photoBook : PhotoBook?
    var photoList : [photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loaded all items when event handler end happened
        PhotoLoader.load(){photoBook in PhotoBook.self; self.photoBook = photoBook; self.testPrint()}
        }

    func testPrint(){
        photoList = photoBook!.photos
        for photos in photoList{
            print(photos)
            //if need to load UI from struct like data as type date or pic as type pic
            //can build extensions to load image from url and convert string to date
        }
    }
}
