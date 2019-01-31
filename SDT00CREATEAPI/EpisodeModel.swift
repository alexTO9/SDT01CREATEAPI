//
//  LocationModel.swift
//  SDT00CREATEAPI
//
//  Created by Alejandro Flores Cruz on 2019-01-07.
//  Copyright © 2019 Alejandro Flores. All rights reserved.
//

import UIKit

class EpisodeModel: NSObject {

    // properties
    
    var mainTitle: String?
    var pubDate: String?
    var descr: String?
    var audioURL: String?
    
    //empty constructor (init)
    override init()
    {
    
    }
    //construct with @name, @address, @latitutde, and @longitude parameters.
    init(mainTitle: String, pubDate: String, descr: String, audioURL: String)
    {
        self.mainTitle = mainTitle
        self.pubDate = pubDate
        self.descr = descr
        self.audioURL = audioURL
    }
    //prints object current state
    override var description: String {
        return "Título: \(mainTitle as String?), Fecha de publicación: \(pubDate as String?), Descripción: \(descr as String?) Link del audio: \(audioURL as String?)"
    }
    
}
