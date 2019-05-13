//
//  ViewControllerStorable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation

protocol ViewControllerStorable {
    var store: DataStorage! { get set }

    func loadStore(_ store: DataStorage)
}

extension ViewControllerStorable {
    func loadStore(_ store: DataStorage) { }
}
