//
//  ListViewController.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit
import PinLayout
import RxSwift
import RxCocoa


class RestaurantListViewController: UIViewController {

  private let disposeBag = DisposeBag()

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.backgroundColor = AppColor.white
    tableView.allowsSelection = false
    self.view.addSubview(tableView)
    tableView.register(RestaurantViewCell.self, forCellReuseIdentifier: RestaurantViewCell.identifier)
    return tableView
  }()

  lazy var header: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    self.view.addSubview(view)
    return view
  }()

  lazy var segmentControl: UISegmentedControl = {
    let segment = UISegmentedControl(items: ["by Name", "by Rate"])
    segment.backgroundColor = AppColor.blackgray
    segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    header.addSubview(segment)
    return segment
  }()

  var viewModel: RestaurantListViewModel!
  let dataSource = BehaviorRelay(value: [RestaurantEntityViewModel]())
  var animateInReload = true
  weak var coordinator: RestaurantListCoordinator!

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    style()

  }

  deinit { print("I deinited") }

  func bindViewModel() {
    assert(viewModel != nil)

    //MARK: INPUTS
    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .mapToVoid()
      .asDriverOnErrorJustComplete()

    let sortDriver = segmentControl.rx.selectedSegmentIndex.asDriverOnErrorJustComplete().map { index -> SortType in
      switch index {
      case 0:
        return SortType.byName
      case 1:
        return SortType.byRate
      default:
        return SortType.none
      }
    }

    let share = PublishSubject<Restaurant>()
    let saveFavourite = PublishSubject<Restaurant>()

    let input = RestaurantListViewModel.Input(
      start: Driver.merge(viewWillAppear),
      sort: sortDriver,
      share: share.asDriverOnErrorJustComplete(),
      favourite: saveFavourite.asDriverOnErrorJustComplete())

    //MARK: OUTPUTS
    let output = viewModel.transform(input: input)

    output.started.drive { [weak self] models in
      self?.dataSource.accept(models)
    }.disposed(by: disposeBag)

    output.sorted.drive { [weak self] models in
      self?.dataSource.accept(models)
      if !(self?.tableView.indexPathsForVisibleRows?.isEmpty ?? true){
        self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
      }
    }.disposed(by: disposeBag)

    output.favourite.drive { [weak self] models in
      self?.animateInReload = false
    }.disposed(by: disposeBag)

    output.share.drive { [weak self] promo in
      self?.coordinator.presentShare(text: promo)
    } onCompleted: {
      print("Completed")
    } onDisposed: {
      print("Disposed")
    }.disposed(by: disposeBag)


    self.dataSource.bind(to: self.tableView.rx.items(cellIdentifier: RestaurantViewCell.identifier, cellType: RestaurantViewCell.self)) { index, model, cell in
      cell.bind(viewModel: model,
                share: share,
                saveFavourite: saveFavourite)
    }.disposed(by: self.disposeBag)

  }

  func style () {
    self.view.backgroundColor = AppColor.white

    tableView.rx.willDisplayCell.subscribe { [weak self] cell in
      if (self?.animateInReload ?? false) {
        cell.cell.alpha = 0
        UIView.animate(withDuration: 0.4) {cell.cell.alpha = 1}
      }
    } onCompleted: { [weak self] in
      self?.animateInReload = true
    }.disposed(by: disposeBag)


    setLogo()
  }

  override func viewDidLayoutSubviews() {

    header.pin
      .top(view.pin.safeArea.top)
      .horizontally()
      .height(60)

    tableView.pin
      .below(of: header)
      .bottom()
      .horizontally()

    segmentControl.pin
      .horizontally(30)
      .vCenter()
      .height(80%)

  }
}
