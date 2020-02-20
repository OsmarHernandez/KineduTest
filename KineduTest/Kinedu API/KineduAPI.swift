//
//  KineduAPI.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

struct KineduAPI {
    
    enum Endpoints {
        private static let base = "http://demo.kinedu.com/bi"
        
        case nps
        
        var stringValue: String {
            switch self {
            case .nps:
                return Endpoints.base + "/nps"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    static func requestNetPromoterScores(completion: @escaping ([NetPromoterScore]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.nps.url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let netPromoterScores = try decoder.decode([NetPromoterScore].self, from: data)
                completion(netPromoterScores, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
