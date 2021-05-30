//
//  StringExtension.swift
//  jaldilive
//
//  Created by Admin on 07/12/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9","_"]
        return Set(self).isSubset(of: nums)
    }
}
