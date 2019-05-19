//
//  MoviesCollectionViewCell.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Kingfisher
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        styleCircleImageView(previewImageView)
        styleBorderView(previewImageView, (2.5, .red))
    }
}

extension MovieCollectionViewCell {
    func render(from viewModel: ShortMovieViewModel) {
        titleLabel.text = viewModel.title

        loadImage(forPath: viewModel.imagePath)
        styleCategoryBorder(viewModel.category)
    }

    private func loadImage(forPath path: String) {
        previewImageView.kf.setImage(with: ImageLoadingEndpoint.load(path: path).url, placeholder: #imageLiteral(resourceName: "MoviePlaceholder"))
    }

    private func styleCategoryBorder(_ category: CategorizedMovie.Category) {
        switch category {
        case .popular:
            styleBorderView(previewImageView, (2.5, .white))

        case .topRated:
            styleBorderView(previewImageView, (2.5, .green))

        case .upcoming:
            styleBorderView(previewImageView, (2.5, .midnightBlue))
        }
    }
}

enum ImageLoadingEndpoint: Endpoint {
    case load(path: String?)

    var httpMethod: HTTPSMethod {
        return .get
    }

    var path: String {
        switch self {
        case .load(let renderPath):
            return renderPath ?? String()
        }
    }

    var baseURL: String {
        return "https://image.tmdb.org/t/p/original"
    }

    var url: URL? {
        return URL(string: builtURL)
    }
}
