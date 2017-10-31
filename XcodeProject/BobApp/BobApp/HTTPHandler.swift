//
//  HTTPHandler.swift
//  BobApp
//
//  Created by Andres Belgy on 31/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getJson(urlString: String, completionHandler: @escaping (Data?) ->
        (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: . urlQueryAllowed)
        let url = URL(string: urlString!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if(statusCode == 200) {
                    completionHandler(data as Data)
                }
            }else if let error = error {
                print("**there was an error with your request**")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
