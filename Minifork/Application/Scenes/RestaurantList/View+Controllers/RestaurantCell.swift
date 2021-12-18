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

  // MARK: VIEWS
  lazy var background: UIView = {
    let view = UIView()
    view.backgroundColor = .red
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

  lazy var bannerOne: UIView = {
    let view = UIView()
    view.backgroundColor = .brown
    return view
  }()

  lazy var bannerTwo: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
  }()

  // MARK: LABELS
  lazy var restaurantName: UILabel = {
    let label = UILabel()
    label.textColor = .red
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  lazy var restaurantCousine: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.numberOfLines = 1
    label.lineBreakMode = .byClipping
    return label
  }()

  lazy var tripReview: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    return label
  }()

  lazy var theForkReview: UILabel = {
    let label = UILabel()
    label.textColor = .cyan
    return label
  }()

  lazy var priceRange: UILabel = {
    let label = UILabel()
    label.textColor = .cyan
    return label
  }()

  lazy var addressStreet: UILabel = {
    let label = UILabel()
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()

  lazy var addressCityCountry: UILabel = {
    let label = UILabel()
    return label
  }()

  lazy var offerLabel: UILabel = {
    let label = UILabel()
    return label
  }()


  // MARK: ICONS
  lazy var cousineIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "food")
    return view
  }()

  lazy var tripAdviserIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "ta-logo")
    return view
  }()

  lazy var theForkIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "tf-logo")
    return view
  }()

  lazy var priceRangeIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "cash")
    return view
  }()

  lazy var locationIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "location")
    return view
  }()

  lazy var shareIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "share")
    return view
  }()

  lazy var favIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "empty-heart")
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
    contentView.addSubview(background)
    background.addSubview(backgroundPicture)
    backgroundPicture.addSubview(overlay)
    background.addSubview(tripAdviserIcon)
    background.addSubview(tripReview)
    background.addSubview(theForkIcon)
    background.addSubview(theForkReview)
    background.addSubview(priceRangeIcon)
    background.addSubview(priceRange)
    background.addSubview(bannerOne)
    background.addSubview(bannerTwo)

    overlay.addSubview(restaurantName)
    overlay.addSubview(restaurantCousine)
    overlay.addSubview(cousineIcon)

    bannerOne.addSubview(locationIcon)
    bannerOne.addSubview(addressStreet)
    bannerOne.addSubview(addressCityCountry)
    bannerOne.addSubview(shareIcon)
    bannerOne.addSubview(favIcon)

    bannerTwo.addSubview(offerLabel)


    self.backgroundColor = .clear
    // TEST

    restaurantName.text = "Babobba aksd kamksdm amksldmaks"
    restaurantCousine.text = "French"

    tripReview.text = "2.3"
    theForkReview.text = "44.3"
    priceRange.text = "0-22€"
    addressStreet.text = "3huiANSJKDNASJKDNJASKNDASDNSA"
    addressCityCountry.text = "Salvador, Brasil"
    offerLabel.text = "50% sconto alla casssa , sticazzi toma toma toma toma"
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

    background.pin.horizontally(20)
    backgroundPicture.pin.horizontally()
    overlay.pin.horizontally(40)

    restaurantName.pin.horizontally(20)
    restaurantName.pin.sizeToFit(.width)

    restaurantCousine.pin
      .below(of: restaurantName)
      .marginTop(10)
      .sizeToFit()
      .hCenter(10)

    cousineIcon.pin
      .left(of: restaurantCousine)
      .marginRight(5)
      .width(15)
      .height(20)
      .vCenter(to: restaurantCousine.edge.vCenter)


    overlay.pin.wrapContent(.vertically, padding: 10)
    backgroundPicture.pin.wrapContent(.vertically, padding: 25)


    tripAdviserIcon.pin
      .below(of: backgroundPicture)
      .width(30)
      .height(15)
      .marginTop(10)
      .left(10)

    tripReview.pin
      .right(of: tripAdviserIcon)
      .sizeToFit()
      .marginLeft(8)
      .vCenter(to: tripAdviserIcon.edge.vCenter)

    theForkIcon.pin
      .right(of: tripReview)
      .marginLeft(10)
      .width(15)
      .height(20)
      .vCenter(to: tripAdviserIcon.edge.vCenter)

    theForkReview.pin
      .right(of: theForkIcon)
      .sizeToFit()
      .marginLeft(8)
      .vCenter(to: theForkIcon.edge.vCenter)

    priceRange.pin
      .sizeToFit()
      .right(10)
      .vCenter(to: tripAdviserIcon.edge.vCenter)

    priceRangeIcon.pin
      .left(of: priceRange)
      .marginRight(9)
      .width(20)
      .height(15)
      .vCenter(to: tripAdviserIcon.edge.vCenter)



    bannerOne.pin.horizontally(20)

    locationIcon.pin
      .height(30)
      .width(20)
      .left()

    addressStreet.pin
      .right(40%)
      .right(of: locationIcon)
      .marginLeft(5)
      .sizeToFit(.width)
      .top(to: locationIcon.edge.top)


    self.background.pin.wrapContent(.vertically)
    self.contentView.pin.wrapContent(.vertically, padding: 10)
  }


}
