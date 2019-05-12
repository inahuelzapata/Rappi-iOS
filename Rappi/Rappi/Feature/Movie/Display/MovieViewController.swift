//
//  FeedViewController.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

class MovieViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()
    }
}

extension MovieViewController: LargeTitlesNavigation { }
