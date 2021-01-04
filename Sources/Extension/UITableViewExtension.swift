//
//  UITableViewExtend.swift
//  Brandi
//
//  Created by brandi on 2016. 5. 23..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    /*
    // MARK: Functions
    func setNoResultView(_ title: String, showImage: Bool, replaceImage: UIImage?) {
        self.setNoResultView(title, showImage: showImage, replaceImage: replaceImage, tintColor: nil)
    }
    
    func setNoResultView(_ title: String, showImage: Bool, replaceImage: UIImage?, tintColor: UIColor?) {
        let noResultView = TableViewBackground.makeViewFromNib()
        noResultView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.backgroundView = noResultView
        if let background = self.backgroundView as? TableViewBackground {
            background.labelWarning.text = title
            background.imageViewNoResult.isHidden = !showImage
            if let color = tintColor {
                let image = replaceImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                background.imageViewNoResult.image = image
                background.imageViewNoResult.tintColor = color
            } else {
                background.imageViewNoResult.image = replaceImage
            }
        }
    }*/
    
    func refreshData() {
        self.reloadData()
        var hasData = false
        for section in 0 ..< self.numberOfSections {
            if self.numberOfRows(inSection: section) > 0 {
                hasData = true
            }
        }
        self.backgroundView?.isHidden = hasData
    }
    /*
    func setViewAsNoResultSearchAutoComplete() {
        if let background = self.backgroundView as? TableViewBackground {
            background.imageViewNoResult.image = Asset.Assets.icDefaultExclamation.image
            background.constImageViewWidth.constant = 36
            background.constImageViewHeight.constant = 36
            if background.constImageViewCenterY != nil {
                background.constImageViewCenterY.isActive = false
            }
            if background.constLabelCenterY != nil {
                background.constLabelCenterY.isActive = false
            }
            background.constImageViewTop.constant = 100
            background.constImageViewNoResultBottom.constant = 12
            background.labelWarning.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            background.labelWarning.text = "연관검색어가 없습니다"
            background.labelWarning.textColor = ResourceDataStore.colors().COLOR_BRANDI_LIGHTGRAY
        }
    }*/
    
    func setBottomIndicator(hide: Bool) {
        let height: CGFloat = 30
        let indicator = UIActivityIndicatorView(style: .gray)

        indicator.frame = CGRect(x: .zero, y: .zero, width: contentSize.width, height: height)
        indicator.center.x = center.x
        indicator.isHidden = hide
        
        if !hide { indicator.startAnimating() }

        tableFooterView = hide
            ? nil
            : indicator
    }
    
}
