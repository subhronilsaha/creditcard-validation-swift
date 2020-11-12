//
//  Extensions.swift
//  creditcard-assessment
//
//  Created by Subhronil Saha on 12/11/20.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
