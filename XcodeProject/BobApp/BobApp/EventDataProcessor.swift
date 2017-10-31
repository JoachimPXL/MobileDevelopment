//
//  EventDataProcessor.swift
//  BobApp
//
//  Created by Andres Belgy on 31/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation

class EventDataProcessor {
    static func mapJsonToEvents(object: [String: AnyObject], eventsKey: String) ->
        [Event] {
            var mappedEvents: [Event] = []
            
            guard let events = object[eventsKey] as? [[String: AnyObject]]  else { return mappedEvents }
            
            for event in events {
                guard let name = event["name"] as? String else { continue }
                
                let eventClass = Event(name: name)
                mappedEvents.append(eventClass)
            }
            return mappedEvents
    }
}

