//
//  UICollectionViewCell+Dequeueable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell: Dequeueable { }

extension UICollectionViewCell: DequeueableNib { }

extension UICollectionReusableView: Dequeueable { }

extension UICollectionReusableView: DequeueableNib { }
