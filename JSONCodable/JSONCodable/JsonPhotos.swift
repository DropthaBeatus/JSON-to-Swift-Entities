//
//  JsonPhotos.swift
//  JSONCodable
//
//  Created by Liam Flaherty on 2/7/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import Foundation

struct photos: Codable {
    let image : String
    let title : String
    let description : String
    let latitude : Float
    let longitude : Float
    let date : String

    enum Coding: String, CodingKey {
        case image
        case title
        case description
        case latitude
        case longitude
        case date
    
    }
    
}

struct PhotoBook: Codable {
    let status : String
    let photoPath : String
    let photos: [photos]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case photoPath = "photosPath"
        case photos = "photos"
    }
    
}

class PhotoLoader{
    
//reference
//https://gist.github.com/cmoulton/7ddc3cfabda1facb040a533f637e74b8
//could not figure out how to pass items to viewcontroller without event completionHandler
    class func load(completionHandler: @escaping (PhotoBook) -> ()){
        let jsonWebsite: String = "https://dalemusser.com/code/examples/data/nocaltrip/photos.json"
        guard let url = URL(string: jsonWebsite) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
      
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let albumData = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PhotoBook.self, from: albumData)
                if(jsonData.status != "ok"){
                    print("Error: Status to retrieve photos is not available")
                    return
                }
                completionHandler(jsonData)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
}

}


