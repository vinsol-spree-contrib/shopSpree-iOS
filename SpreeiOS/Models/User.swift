//
//  User.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 25/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import SwiftyJSON

enum Gender {
    case male
    case female
}

class User: NSObject, NSCoding {

    var id: Int!
    var spreeApiKey: String!
    var confirmed: Bool!
    var phone: String!
    var fullName: String!
    var email: String!

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.fullName = json["full_name"].stringValue
        self.spreeApiKey = json["spree_api_key"].stringValue
        self.email = json["email"].stringValue
        self.phone = json["phone"].stringValue
        self.confirmed = json["confirmed"].boolValue
    }

    // Mark :- NSCoding
    required init?(coder aDecoder: NSCoder) {
        fullName = aDecoder.decodeObject(forKey: "fullName") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        spreeApiKey = aDecoder.decodeObject(forKey: "spreeApiKey") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(spreeApiKey, forKey: "spreeApiKey")
    }

    // Mark :- Authentication
    static var _currentUser: User!

    static var currentUser: User? {
        get {
            if (_currentUser != nil) {
                return _currentUser
            } else {
                let defaults = UserDefaults.standard
                if let unarchivedObject = defaults.object(forKey: "currentUser") as? NSData {
                    _currentUser = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? User
                    return _currentUser
                }
                return nil
            }
        }

        set {
            _currentUser = newValue
            let defaults = UserDefaults.standard

            if let user = newValue {
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: user)
                defaults.set(archivedObject, forKey: "currentUser")
            } else {
                defaults.removeObject(forKey: "currentUser")
            }
        }
    }

    static var isLoggedIn: Bool {
        return currentUser != nil
    }
}
