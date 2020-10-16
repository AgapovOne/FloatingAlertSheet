//
//  FloatingAlertController.swift
//  FlyAlert
//
//  Created by Alexandr Shevchenko on 09.10.2020.
//

import UIKit
//
//public protocol FloatingCellDelegate: FloatingCellDataSource {
//    func didSelect()
//}
//
public protocol FloatingCellDataSource {
//    func setTitle(icon: UIImage?, title: String)
    func setFontTitle(font: UIFont)
//    func setAction(action: Any)
//    func hideArrow()
}
//
//public protocol FloatingCellDateSourceToggle: FloatingCellDataSource {
//    func switchState(state: Bool)
//}

public enum FloatingAlertAction {
    case title(icon: UIImage? = nil, title: String)
    case action(AlertCellViewModel)
    case actionSwitch(AlertCellViewModelToggle)
    case separator

  public struct AlertCellViewModel {
    let image: UIImage?
    let title: String
    let hasArrow: Bool
    let onTap: () -> Void
  }

  public struct AlertCellViewModelToggle {
    let title: String
    let isDisabled: Bool
    let isOn: Bool
    let onToggle: (Bool) -> Void
  }
}

public class FloatingAlertController: UIViewController {
    @IBOutlet private weak var floatingView: UIView!
    @IBOutlet private weak var tableView: SelfSizedTableView!
    @IBOutlet private weak var handleArea: UIView!

    var actions = [FloatingAlertAction]()

    private var cardHeight: CGFloat?
    private var cardOpenPosition: CGFloat?

    public var backgroundColor = UIColor.white
    public var cornerRadius: CGFloat = 10
    public var textFont = UIFont.systemFont(ofSize: 17)

//  struct Theme {
//    public init(backgroundColor: UIColor = UIColor.white,
//                cornerRadius: CGFloat = 10,
//                textFont: UIFont = UIFont.systemFont(ofSize: 17)) {
//      self.backgroundColor = backgroundColor
//      self.cornerRadius = cornerRadius
//      self.textFont = textFont
//    }
//
//    public let backgroundColor: UIColor
//    public let cornerRadius: CGFloat
//    public let textFont = UIFont.systemFont(ofSize: 17)
//  public let closesOnTap: Bool
//  public let initialActions: [FloatingAlertAction]
//
//    static var `default`: Self = .init()
//  }
//  private let theme: Theme
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
        setProperty()
        floatingView.isHidden = true
        setupCard()
    }

  public func update(with actions: [FloatingAlertAction]) {
    self.actions = actions
    tableView.reloadData()
  }

  public func hide() {
    UIView.animate(withDuration: 0.3) {
      self.floatingView.frame.origin.y = self.view.frame.height
    } completion: { _ in
      self.dismiss(animated: false) {
        cell.didSelect()
      }
    }
  }

//  init(theme: Theme = .default) {
//
//  }

    convenience init() {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "FloatingAlertController", bundle: bundle)
        self.modalPresentationStyle = .overCurrentContext
    }

//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//  }
//
//  @available(*, unavailable)
//  public required init?(coder: NSCoder) {
//    fatalError("Not implemented")
//  }
  
    func registerCell() {
        let bundle = Bundle(for: type(of: self))
        tableView.register(UINib(nibName: "FloatingAlertCell", bundle: bundle), forCellReuseIdentifier: "floatingAlertCell")
        tableView.register(UINib(nibName: "FloatingSeparatorCell", bundle: bundle), forCellReuseIdentifier: "floatingSeparatorCell")
        tableView.register(UINib(nibName: "FloatingSwitchCell", bundle: bundle), forCellReuseIdentifier: "floatingSwitchCell")
    }

    func setupCard() {
        floatingView.clipsToBounds = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(handleCardPan(recogniser:)))
        floatingView.addGestureRecognizer(panGestureRecognizer)
        self.view.addGestureRecognizer(panGestureRecognizer)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//      floatingView.layoutIfNeeded()
            self.openAnimate()
//        }
    }

    func openAnimate() {

        floatingView.frame.origin.y = self.view.frame.height
        self.setCorner()
        floatingView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.floatingView.frame.origin.y = self.view.frame.height - self.floatingView.frame.height
        }
    }

    @objc
    func handleCardPan (recogniser: UIPanGestureRecognizer) {
        switch recogniser.state {
        case .began:
            if cardHeight == nil {
                cardHeight = floatingView.frame.height
                cardOpenPosition = floatingView.frame.origin.y
            }
        case .changed:
            let translationY = recogniser.translation(in: self.floatingView).y
            let nextPosition = self.floatingView.frame.origin.y + translationY
            let movePosition = min(self.view.frame.height, max(nextPosition, self.cardOpenPosition!))
            self.floatingView.frame.origin.y = movePosition
            recogniser.setTranslation(CGPoint.zero, in: self.floatingView)
        case .ended:
            animatedEnded()
        default:
            break
        }
    }

    func animatedEnded() {
        let currentPosition = self.floatingView.frame.minY
        var nextPosition: CGFloat
        if currentPosition > (cardOpenPosition! + cardHeight! / 2) {
            nextPosition = self.view.frame.height
        } else {
            nextPosition = self.cardOpenPosition!
        }
        let duration = Double(abs(nextPosition - currentPosition) / (self.cardHeight! / 100)) / 100
        UIView.animate(withDuration: duration / 2) {
            self.floatingView.frame.origin.y = nextPosition
        } completion: { _ in
            if nextPosition > self.cardOpenPosition! {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    private func setProperty() {
        floatingView.backgroundColor = backgroundColor
        handleArea.layer.cornerRadius = 2.5
    }

    private func setCorner() {
        floatingView.roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
    }
}

extension FloatingAlertController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch actions[indexPath.row] {
        case .separator:
          let cell = tableView.dequeueReusableCell(withIdentifier: "floatingSeparatorCell")!
            return cell
        case let .title(icon: icon, title: title):
            let cell = tableView.dequeueReusableCell(withIdentifier: "floatingAlertCell") as! FloatingAlertCell
          // Check AliSoftware/Reusable || R.swift
//          let cell: FloatingAlertCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setTitle(icon: icon, title: title)
            cell.hideArrow()
          cell.setFontTitle(font: textFont)
          return cell as! UITableViewCell
        case let .action(icon: icon, title: title, action: action):
          let cell = tableView.dequeueReusableCell(withIdentifier: "floatingAlertCell") as! FloatingAlertCell
            cell.setTitle(icon: icon, title: title)
            cell.setAction(action: action)
            cell.hideArrow()
          cell.setFontTitle(font: textFont)
          return cell as! UITableViewCell
        case let .actionArrow(icon: icon, title: title, action: action):
          let cell = tableView.dequeueReusableCell(withIdentifier: "floatingAlertCell") as! FloatingAlertCell
          cell.
//          cell.configure(with: actions[indexPath.row])
          return cell

            cell.setTitle(icon: icon, title: title)
            cell.setAction(action: action)
          cell.setFontTitle(font: textFont)
//          cell.setFontTitle(font: configuration.textFont)
          return cell as! UITableViewCell
        case let .actionSwitch(icon: icon, title: title, stateSwitch: state, action: action):
          let   cell = tableView.dequeueReusableCell(withIdentifier: "floatingSwitchCell") as! FloatingSwitchCell
            cell.setTitle(icon: icon, title: title)
            cell.switchState(state: state)
            cell.setAction(action: action)
          cell.setFontTitle(font: textFont)
          return cell as! UITableViewCell
        }
        cell.setFontTitle(font: textFont)
        return cell as! UITableViewCell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let action = actions[indexPath.row]
      switch action {
      case let .tap(viewModel):
        viewModel.onTap()
      }
//      case let .action(_, _, action):
//        action()

//      case let .actionSwitch(_, _, _, action):
//        action
//      case .separator, .title: break
      if theme.closesOnTap {
        hide()
      }
    }
}
