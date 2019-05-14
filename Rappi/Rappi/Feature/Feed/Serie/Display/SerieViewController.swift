//
//  SerieViewControlle.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import SkeletonView
import UIKit

class SerieViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    let serieProvider: SerieProvidable = SerieProvider(requestProvider: current.requestProvider,
                                                       requestBuilder: current.requestBuilder)

    var series: [ShortSerieViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()

        retrieveSeries()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func retrieveSeries() {
        do {
            try serieProvider.execute(request: SerieRequest(page: 1))
                .done {
                    self.series = $0.results.map { ShortSerieViewModel(name: $0.name,
                                                                       imagePath: $0.posterPath,
                                                                       rating: $0.popularity) }
                }.catch { _ in
                    print("❌")
            }
        } catch {
            // Add Error Handling
        }
    }
}

extension SerieViewController: LargeTitlesNavigation { }

struct ShortSerieViewModel {
    let name: String
    let imagePath: String
    let rating: Double
}
