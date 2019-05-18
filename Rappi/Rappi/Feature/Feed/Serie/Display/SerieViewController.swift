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
    let seriesExposer: SerieExposer = SeriesExposer(popularSerieProvider: PopularSerieProvider(requestProvider: current.requestProvider,
                                                                                               requestBuilder: current.requestBuilder),
                                                    topRatedSerieProvider: TopRatedSerieProvider(requestProvider: current.requestProvider,
                                                                                                 requestBuilder: current.requestBuilder))

    var series: [ShortSerieViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLargeNavigation()
        view.showAnimatedGradientSkeleton()

        retrieveCategorizedSeries()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func retrieveCategorizedSeries() {
        do {
            try seriesExposer.expose(popularRequest: SerieRequest(page: 1), topRatedRequest: SerieRequest(page: 1))
                .done { rumine in
                    print("Josha 💎: \(rumine.count)")
                    let topRated = rumine.filter { $0.category == .topRated }.count
                    let popular = rumine.filter { $0.category == .popular }.count

                    print("NO BARATS 💎 TOP 🔝: \(topRated)")
                    print("Josha 💎 POPULAR 💵 : \(popular)")
            }
        } catch {
            print("❌")
        }
    }
}

extension SerieViewController: LargeTitlesNavigation { }

struct ShortSerieViewModel {
    let name: String
    let imagePath: String
    let rating: Double
}
