//
//  JSONSerializationViewController.swift
//  JSONSerialization
//
//  Created by Liam Flaherty on 2/7/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import UIKit

class JSONSerializationViewController: UIViewController {
    var photoBook : PhotoBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //returns nil can execute an event handler end to have it return full value because it is async
        photoBook = PhotoLoader.loadSerialize()
    }


}
