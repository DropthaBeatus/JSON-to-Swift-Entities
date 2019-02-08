//
//  JSONLoader.swift
//  JSONSerialization
//
//  Created by Liam Flaherty on 2/7/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import Foundation

struct photosies{
    let image : String
    let title : String
    let description : String
    let latitude : NSNumber
    let longitude : NSNumber
    let date : String
}

extension photosies{
    init(_ image: Any, _ title: Any, _ description: Any, _ latitude : Any, _ longitude : Any, _ date : Any) {
        self.image = image as! String
        self.title = title as! String
        self.description = description as! String
        self.latitude = latitude as! NSNumber
        self.longitude = longitude as! NSNumber
        self.date = date as! String
    }
}

struct PhotoBook{
    var status : String
    var photoPath : String
    var photos: [photosies]
}



class PhotoLoader{
        
    class func loadSerialize()->PhotoBook?{
        //loads asynchron so need a event handler to end and return value when synch is done
        var photoBook : PhotoBook?
         let jsonUrl: String = "https://dalemusser.com/code/examples/data/nocaltrip/photos.json"
         guard let url = URL(string: jsonUrl) else {
             print("Error: cannot create URL")
             return nil
         }
         let urlRequest = URLRequest(url: url)
         let config = URLSessionConfiguration.default
         let session = URLSession(configuration: config)
         let task = session.dataTask(with: urlRequest) {
         (data, response, error) in
         guard error == nil else {
             print("error calling get on web page")
             print(error!)
             return
         }
         guard let responseData = data else {
            print("Error: did not receive data")
            return
         }
             do {
                guard let data = try JSONSerialization.jsonObject(with: responseData)
             as? [String: Any] else {
                print("error trying to convert data to JSON")
                return
            }
                //this is horrible way to check status with a force unwrapped need to figure out how to type from serialization better
                
                let checkStatus = data["status"] as! String
                if(checkStatus != "ok"){
                    print("Error: status != okay. Cannot retrive JSON data")
                    return
                }
                let photos = data["photos"] as! [[String: Any]]
                var photoArr : [photosies] = []
                for photo in photos{
                    let test = photosies(photo["image"]!,photo["title"]!,photo["description"]!,photo["latitude"]!,photo["longitude"]!,photo["date"]!)
                    photoArr.append(test)
                }
                
                photoBook = PhotoBook.init(status: data["status"] as! String, photoPath: "photoPath", photos: photoArr)
                print(photoBook!)
             } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
            task.resume()
        return photoBook
     }
}

 

 
