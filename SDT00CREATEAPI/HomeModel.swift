//
//  HomeModel.swift
//  SDT00CREATEAPI
//
//  Created by Alejandro Flores Cruz on 2019-01-07.
//  Copyright © 2019 Alejandro Flores. All rights reserved.
//

import UIKit

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
//properties
    
    weak var delegate: HomeModelProtocol!
   //? var data = Data()
    let urlPath: String = "https://showdetech.com/service1.php"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        
        }
        task.resume()
    }
    func parseJSON(_ data:Data){
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        let episodes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            let episode = EpisodeModel()
            
        //the following insures none of the Json Element values are nil through optional binding
            if let mainTitle = jsonElement["mainTitle"] as? String,
            let pubDate = jsonElement["pubDate"] as? String,
            let descr = jsonElement["descr"] as? String,
            let audioURL = jsonElement["audioURL"] as? String
            {
                episode.mainTitle = mainTitle
                episode.pubDate = pubDate
                episode.descr = descr
                episode.audioURL = audioURL
            }
            episodes.add(episode)
        }
        DispatchQueue.main.async(execute: { () -> Void in
        self.delegate.itemsDownloaded(items: episodes)
        })
    }
}

