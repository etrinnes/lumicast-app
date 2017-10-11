//
//  File.swift
//  Lumicast
//
//  Created by Liz Trinnes on 10/10/17.
//  Copyright © 2017 Liz Trinnes. All rights reserved.
//

import Foundation

class Post{
    var topic: String
    var details: String
    var id: String
    var room: String
    var time: String
    var status: String
    
    init(_ topic: String, _ details: String, _ id: String, _ room: String, _ time: String, _ status: String) {
        self.topic = topic
        self.details = details
        self.id = id
        self.room = room
        self.time = time
        self.status = status
    }
}
