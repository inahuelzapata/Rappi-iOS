//
//  Array+Extension.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        return index < self.count && index >= 0 ? self[index] : nil
    }
}
