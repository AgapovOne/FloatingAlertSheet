//
//  FloatingSwitchCell.swift
//  FlyAlert
//
//  Created by Alexandr Shevchenko on 15.10.2020.
//

import UIKit

class FloatingSwitchCell: UITableViewCell {
//    func hideArrow() {
//
//    }

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!

    @IBAction func switchTap(_ sender: UISwitch) {
      action?(sender.isOn)
    }
    private var action: ((Bool) -> Void)?
    
//    func setTitle(icon: UIImage?, title: String) {
//        self.iconImage.image = icon
//        titleLabel.text = title
//    }
//
//    func setFontTitle(font: UIFont) {
//        titleLabel.font = font
//    }
//
//    func setAction(action: Any) {
//        self.action = action as? ((UISwitch) -> Void)
//    }
//
//    func switchState(state: Bool) {
//        switchControl.isOn = state
//    }

//  func theme(_ theme: Theme) {
//    titleLabel.font = theme.font
//  }

  func configure(with viewModel: AlertViewModel.AlertCellViewModelToggle, theme: Theme) {
    self.titleLabel.text = viewModel.title
    self.switchControl.isOn = viewModel.isOn
    self.switchControl.isEnabled = !viewModel.isDisabled
    ///
    //    UITapGestureRecognizer

    action = viewModel.onToggle
  }
}
