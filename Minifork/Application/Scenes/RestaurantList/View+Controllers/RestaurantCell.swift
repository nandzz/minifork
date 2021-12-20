//
//  RestaurantCell.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import PinLayout
import UIKit
import RxSwift
import RxCocoa

class RestaurantViewCell: UITableViewCell {

  static let identifier = "restaurantEntity"

  // MARK: VIEWS
  lazy var background: UIView = {
    let view = UIView()
    view.backgroundColor = AppColor.white
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    return view
  }()

  lazy var backgroundPicture: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = AppColor.white
    view.contentMode = .scaleAspectFill
    return view
  }()

  lazy var overlay: UIView = {
    let view = UIView()
    view.backgroundColor = AppColor.blackgray
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.layer.cornerRadius = 20
    return view
  }()

  lazy var bannerOne: UIView = {
    let view = UIView()
    view.backgroundColor = AppColor.blackgray
    return view
  }()

  lazy var bannerTwo: UIView = {
    let view = UIView()
    view.backgroundColor = AppColor.promo
    return view
  }()

  lazy var footer: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()

  // MARK: LABELS
  lazy var restaurantName: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .Bold, size: 22)
    label.textColor = AppColor.white
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  lazy var restaurantCousine: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .Bold, size: 14)
    label.textColor = AppColor.white
    label.numberOfLines = 1
    label.lineBreakMode = .byClipping
    return label
  }()

  lazy var tripReview: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .SemiBold, size: 14)
    label.textColor = AppColor.black
    return label
  }()

  lazy var theForkReview: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .SemiBold, size: 14)
    label.textColor = AppColor.black
    return label
  }()

  lazy var priceRange: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .SemiBold, size: 14)
    label.textColor = AppColor.black
    return label
  }()

  lazy var addressStreet: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .Regular, size: 10)
    label.textColor = AppColor.white
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()

  lazy var addressCityCountry: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .Regular, size: 10)
    label.textColor = AppColor.white
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()

  lazy var offerLabel: UILabel = {
    let label = UILabel()
    label.font = Font.get(trait: .Bold, size: 16)
    label.textColor = AppColor.black
    label.lineBreakMode = .byClipping
    label.numberOfLines = 0
    label.textAlignment = .center
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

  lazy var shareIcon: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(named: "share"), for: .normal)
    return button
  }()

  lazy var favIcon: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(named: "empty-heart"), for: .normal)
    button.setBackgroundImage(UIImage(named: "filled-heart"), for: .selected)
    return button
  }()

  lazy var loading: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.color = AppColor.blackgray
    return activity
  }()



  var disposedBag = DisposeBag()
  var viewModel: RestaurantEntityViewModel!
  var loadPicture: PublishSubject<Void> = PublishSubject()


  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    compose()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func compose() {
    contentView.addSubview(background)
    background.addSubview(backgroundPicture)
    background.addSubview(overlay)
    background.addSubview(loading)
    background.addSubview(tripAdviserIcon)
    background.addSubview(tripReview)
    background.addSubview(theForkIcon)
    background.addSubview(theForkReview)
    background.addSubview(priceRangeIcon)
    background.addSubview(priceRange)
    background.addSubview(bannerOne)
    background.addSubview(bannerTwo)
    background.addSubview(footer)
    overlay.addSubview(restaurantName)
    overlay.addSubview(restaurantCousine)
    overlay.addSubview(cousineIcon)
    bannerOne.addSubview(locationIcon)
    bannerOne.addSubview(addressStreet)
    bannerOne.addSubview(addressCityCountry)
    bannerOne.addSubview(shareIcon)
    bannerOne.addSubview(favIcon)
    bannerTwo.addSubview(offerLabel)

    self.backgroundColor = AppColor.white
    self.selectionStyle = .none
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.backgroundPicture.image = nil
    disposedBag = DisposeBag()
    addLoadingAnimation()
  }

  func addLoadingAnimation () {
    loading.startAnimating()
  }

  func removeLoadingAnimation () {
    loading.stopAnimating()
  }

  func bind(viewModel: RestaurantEntityViewModel,
            share: PublishSubject<Restaurant>,
            saveFavourite: PublishSubject<Restaurant>) {

    self.viewModel = viewModel
    self.restaurantName.text = viewModel.restaurant.getName()
    self.restaurantCousine.text = viewModel.restaurant.getCousine()
    self.tripReview.text = "\(viewModel.restaurant.getTripAdRate())"
    self.theForkReview.text = "\(viewModel.restaurant.getTheForkRate())"
    self.priceRange.text = "\(viewModel.restaurant.getPriceRange())"
    self.addressStreet.text = viewModel.restaurant.getAddressStreet()
    self.addressCityCountry.text = "\(viewModel.restaurant.getCityCountry())"
    self.offerLabel.text = viewModel.restaurant.getBestOffer()
    self.favIcon.isSelected = viewModel.restaurant.isFavourite

    let favourite: Driver<Restaurant> = favIcon.rx.tap.asDriver().map{ viewModel.restaurant }
    let picture: Driver<Restaurant> = loadPicture.asDriverOnErrorJustComplete().map{ viewModel.restaurant }
    let shareDriver: Driver<Restaurant> = shareIcon.rx.tap.asDriver().map({ viewModel.restaurant })

    // Print let for debug purpose
    shareDriver.drive { restaurant in
      share.onNext(restaurant)
    } onCompleted: {
      print("Completed sharing")
    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposedBag)

    // Print let for debug purpose
    //FIXME: I think there is a better way to do that, I'm just out of deadline.
    favourite.drive {  [weak self] restaurant in
      saveFavourite.onNext(restaurant)
      if restaurant.isFavourite {
        self?.favIcon.isSelected = false
        self?.viewModel.restaurant.isFavourite = false
      } else {
        self?.favIcon.isSelected = true
        self?.viewModel.restaurant.isFavourite = true
      }
    } onCompleted: {
    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposedBag)

    let input = RestaurantEntityViewModel.Input(
      resolvePicture: picture)

    let output = viewModel.transform(input: input)

    output.picture.drive { [weak self] data in
      DispatchQueue.main.async {
        if data.isEmpty {
          self?.removeLoadingAnimation()
          self?.backgroundPicture.image = UIImage(named: "imageplaceholder")
          return
        }
        self?.backgroundPicture.image = UIImage(data: data)
        self?.removeLoadingAnimation()
      }
    }.disposed(by: disposedBag)

    loadPicture.onNext(())

  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    pin.width(size.width)
    layoutIfNeeded()
    let limit = contentView.frame.maxY
    return CGSize(width: frame.width, height: limit)
  }


  deinit {
    print("Cell Deinited")
  }

  /*
   I chosen Pin Layout over Constraints
   Because I beliave is cleaner and faster
   */

  override func layoutSubviews() {

    background.pin
      .height(400)
      .horizontally(20)


    backgroundPicture.pin.horizontally()
    overlay.pin
      .height(100)
      .horizontally(0)

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

    backgroundPicture.pin
      .height(270)
      .below(of: overlay)

    tripAdviserIcon.pin
      .below(of: backgroundPicture)
      .width(30)
      .height(20)
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
      .width(20)
      .height(25)
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
      .marginRight(5)
      .width(30)
      .height(20)
      .vCenter(to: tripAdviserIcon.edge.vCenter)

    bannerOne.pin.horizontally(20)

    locationIcon.pin
      .height(25)
      .width(20)
      .left(10)

    addressStreet.pin
      .right(40%)
      .right(of: locationIcon)
      .marginLeft(5)
      .sizeToFit(.width)
      .top(to: locationIcon.edge.top)

    addressCityCountry.pin
      .right(30%)
      .sizeToFit(.width)
      .below(of: addressStreet)
      .marginTop(2)
      .left(to: addressStreet.edge.left)

    bannerOne.pin
      .wrapContent(.vertically, padding: 10)
      .below(of: backgroundPicture)
      .marginTop(40)

    favIcon.pin
      .width(30)
      .height(25)
      .vCenter(to: locationIcon.edge.vCenter)
      .right(10)

    shareIcon.pin
      .width(25)
      .height(25)
      .vCenter(to: locationIcon.edge.vCenter)
      .left(of: favIcon)
      .marginRight(10)

    bannerOne.layer.cornerRadius = bannerOne.frame.height / 2

    bannerTwo.pin.horizontally(20)

    offerLabel.pin
      .horizontally(10)
      .sizeToFit(.width)

    bannerTwo.pin
      .wrapContent(.vertically, padding: 10)
      .below(of: bannerOne)
      .marginTop(10)

    bannerTwo.layer.cornerRadius = bannerTwo.frame.height / 2

    footer.pin
      .below(of: bannerTwo)
      .height(10)
      .horizontally()

    self.background.pin.wrapContent(.vertically)
    self.contentView.pin.wrapContent(.vertically, padding: 10)

    loading.pin
      .width(30)
      .height(30)
      .right(10)
      .above(of: priceRangeIcon)
      .marginBottom(20)
  }


}
