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
                completionHandler(jsonData)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
}

}

/*
 class func load(/*jsonURL: URL*/)->PhotoBook?{
 // if Bundle.main.url(forResource: "photos", withExtension: ".json") != nil{
 let endpoint = NSURL(string: "https://dalemusser.com/code/examples/data/nocaltrip/photos.json")
 if let jsonData = NSData(contentsOf: endpoint! as URL){
 do{
 let data = try Data(contentsOf: endpoint! as URL)
 let decoder = JSONDecoder()
 let jsonData = try decoder.decode(PhotoBook.self, from: data)
 print("Parsing data testing here")
 return jsonData
 
 
 } catch {
 print("error:\(error)")
 }
 /*
 print("returned nil at mid")
 return nil
 }
 print("returned nil at very bot")
 return nil
 */
 }
 print("returned nil at very bot")
 return nil
 }
 */
/*
 func makeGetCall(){
 // Set up the URL request
 let todoEndpoint: String = "https://dalemusser.com/code/examples/data/nocaltrip/photos.json"
 guard let url = URL(string: todoEndpoint) else {
 print("Error: cannot create URL")
 return
 }
 let urlRequest = URLRequest(url: url)
 
 // set up the session
 let config = URLSessionConfiguration.default
 let session = URLSession(configuration: config)
 
 // make the request
 let task = session.dataTask(with: urlRequest) {
 (data, response, error) in
 // check for any errors
 guard error == nil else {
 print("error calling GET on /todos/1")
 print(error!)
 return
 }
 // make sure we got data
 guard let responseData = data else {
 print("Error: did not receive data")
 return
 }
 // parse the result as JSON, since that's what the API provides
 
 do {
 guard let todo = try Data(contentsOf: endpoint! as URL)//SONSerialization.jsonObject(with: responseData, options: [])
 as? [String: Any] else {
 print("error trying to convert data to JSON")
 return
 // }*/

// now we have the todo
// let's just print it to prove we can access it


// the todo object is a dictionary
// so we just access the title using the "title" key
// so check for a title and print it if we have one
/*
 guard let todoTitle = todo["title"] as? String else {
 print("Could not get todo title from JSON")
 return
 }
 print("The title is: " + todoTitle)
 } catch  {
 print("error trying to convert data to JSON")
 return
 }
 }
 task.resume()
 }
 
 }
 */
