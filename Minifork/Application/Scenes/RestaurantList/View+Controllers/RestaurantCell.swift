//
//  RestaurantCell.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import PinLayout
import UIKit


class RestaurantViewCell: UITableViewCell {

  static let identifier = "restaurantEntity"

  // MARK: VIEW
  lazy var background: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    view.layer.cornerRadius = 20
    return view
  }()

  lazy var backgroundPicture: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .brown
    return view
  }()

  lazy var overlay: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.opacity = 0.7
    return view
  }()

  // MARK: LABELS
  lazy var restaurantName: UILabel = {
    let label = UILabel()
    label.textColor = .red
    return label
  }()

  lazy var restaurantCousine: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    return label
  }()

  lazy var tripReview: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    return label
  }


  // MARK: ICONS
  lazy var cousineIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var tripAdviserIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var theForkIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var priceRangeIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var locationIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var shareIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()

  lazy var favIcon: UIImageView = {
    let view = UIImageView()
    backgroundColor = .cyan
    return view
  }()







  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func configure() {
    self.contentView.addSubview(background)
  }

  func bind(viewModel: Any) {

  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    pin.width(size.width)
    layoutIfNeeded()

    let limit = contentView.frame.maxY
    return CGSize(width: frame.width, height: limit)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    background.pin
      .horizontally(20)
      .height(50)

    self.contentView.pin.wrapContent(.vertically, padding: 10)
  }


}
