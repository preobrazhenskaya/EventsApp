//
//  Events.swift
//  EventsApp
//
//  Created by Яна Преображенская on 03/09/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import Foundation

class Event: Codable {
    var id : Int?
    var name : String?
    var statusString : String?
    var authorName : String?
    var authorPhone : String?
    var authorEmail : String?
    var participantCount : Int?
    var description : String?
    var eventAvatar : String?
    var images : [String]?
    var status : Int?
    var startDate : Int?
    var endDate : Int?
    var room : String?
    var comment : String?
}
