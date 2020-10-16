//
//  FloatingAlertCell.swift
//  FlyAlert
//
//  Created by Alexandr Shevchenko on 14.10.2020.
//

import UIKit

class FloatingAlertCell: UITableViewCell {
//    private var action: (() -> Void)?
    @IBOutlet private var iconImage: UIImageView!
    @IBOutlet private var arrowImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

//    func hideArrow() {
//        arrowImage.isHidden = true
//    }
//
//    func didSelect() {
//        action?()
//    }
//
//    func setTitle(icon: UIImage?, title: String) {
//        self.iconImage.image = icon
//        titleLabel.text = title
//    }
//
//    func setFontTitle(font: UIFont) {
//        titleLabel.font = font
//    }
//
//    func setAction(action: () -> Void) {
//        self.action = action
//    }

  func configure(with viewModel: FloatingAlertAction.AlertCellViewModel) {
    self.titleLabel.text = viewModel.title
    ///
//    UITapGestureRecognizer
  }
}
