//
//  NetPromoterScore.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

enum UserPlan: String {
    case premium
    case freemium
    
    var string: String {
        return self.rawValue
    }
}

struct NetPromoterScore: Decodable {
    let id: Int
    let nps: Int
    let daysSinceSignup: Int
    let userPlan: String
    let activityViews: Int
    let build: BuildInfo
    
    enum CodingKeys: String, CodingKey {
        case id
        case nps
        case daysSinceSignup = "days_since_signup"
        case userPlan = "user_plan"
        case activityViews = "activity_views"
        case build
    }
}
