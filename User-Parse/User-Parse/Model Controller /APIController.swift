//
//  APIController.swift
//  User-Parse
//
//  Created by Tobi Kuyoro on 16/01/2020.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class APIController {
    
    var user: [User] = []
    let baseURL = URL(string: "https://randomuser.me/api/?format=json&results=20")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getUsers(completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: baseURL) {(data, _, error) in
            if let error = error {
                NSLog("Error getting users: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(nil)
                return
            }
            
            do {
                let newUsers = try JSONDecoder().decode(UserResults.self, from: data)
                self.user = newUsers.results
                print(newUsers)
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
}
