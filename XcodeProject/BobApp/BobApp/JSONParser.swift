//
//  JSONParser.swift
//  BobApp
//
//  Created by Andres Belgy on 31/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation
class JSONParser {
    static func parse (data: Data) -> [String: AnyObject]? {
        print("in deze func")
        let options = JSONSerialization.ReadingOptions()
        do {
            let son = try JSONSerialization.jsonObject(with: data, options: options)
                as? [String: AnyObject]
            
            return son!
        }catch( let parseError){
            print("there was an error parsing the json: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
}
