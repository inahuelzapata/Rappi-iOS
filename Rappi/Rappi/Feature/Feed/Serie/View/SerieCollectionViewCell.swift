//
//  SerieCollectionViewCell.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class SerieCollectionViewCell: CollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
}

extension SerieCollectionViewCell {
    func render(basedOn serie: ShortSerieViewModel) {
        titleLabel.text = serie.name
        releaseDateLabel.text = serie.releaseDate
        load(imagePath: serie.imagePath)
        styleForCategory(serie.category)
    }

    private func load(imagePath: String) {
        iconImageView.kf.setImage(with: ImageLoadingEndpoint.load(path: imagePath).url)
    }

    private func styleForCategory(_ category: CategorizedSerie.Category) {
        switch category {
        case .popular:
            styleBorderView(iconImageView, (2.5, .red))
            
        case .topRated:
            styleBorderView(iconImageView, (2.5, .purple))
        }
    }
}
