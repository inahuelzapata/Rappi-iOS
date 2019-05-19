//
//  Grid.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/19/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import UIKit

class Grid {
    var columns: CGFloat
    var margin: UIEdgeInsets
    var padding: UIEdgeInsets

    var verticalMargin: CGFloat {
        return self.margin.top + self.margin.bottom
    }

    var horizontalMargin: CGFloat {
        return self.margin.left + self.margin.right
    }

    var verticalPadding: CGFloat {
        return self.padding.top + self.padding.bottom
    }

    var horizontalPadding: CGFloat {
        return self.padding.left + self.padding.right
    }

    init(columns: CGFloat = 1, margin: UIEdgeInsets = .zero, padding: UIEdgeInsets = .zero) {
        self.columns = columns
        self.margin = margin
        self.padding = padding
    }

    func size(for view: UIView, ratio: CGFloat, items: CGFloat = 1, gaps: CGFloat? = nil) -> CGSize {
        let size = self.width(for: view, items: items, gaps: gaps)
        return CGSize(width: size, height: (size * ratio).evenRounded)
    }

    func size(for view: UIView, height: CGFloat, items: CGFloat = 1, gaps: CGFloat? = nil) -> CGSize {
        let size = self.width(for: view, items: items, gaps: gaps)

        var height = height
        if height < 0 {
            height = view.bounds.size.height - height
        }
        return CGSize(width: size, height: height.evenRounded)
    }

    func width(for view: UIView, items: CGFloat = 1, gaps: CGFloat? = nil) -> CGFloat {
        let gaps = gaps ?? items - 1

        let width = view.bounds.size.width - self.horizontalMargin - self.horizontalPadding * gaps

        return (width / self.columns * items).evenRounded
    }

    func height(for view: UIView, items: CGFloat = 1, gaps: CGFloat? = nil) -> CGFloat {
        let gaps = gaps ?? items - 1

        let height = view.bounds.size.height - self.verticalMargin - self.verticalPadding * gaps

        return (height / self.columns * items).evenRounded
    }
}
