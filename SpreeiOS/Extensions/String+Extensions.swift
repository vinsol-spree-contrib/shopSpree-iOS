//
//  String+Extensions.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 24/05/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import Foundation

extension String {

    var titleize: String {
        var words = self.lowercased().characters.split { $0 == " " }.map { String($0) }
        words[0] = words[0].capitalized

        return words.joined(separator: " ")
    }

}
