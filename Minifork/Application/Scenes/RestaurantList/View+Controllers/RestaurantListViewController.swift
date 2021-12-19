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
    let tableView = UITableView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .white
//    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.backgroundColor = AppColor.gray
//    tableView.dataSource = self
    tableView.allowsSelection = false
    self.view.addSubview(tableView)
    tableView.register(RestaurantViewCell.self, forCellReuseIdentifier: RestaurantViewCell.identifier)
    return tableView
  }()

  var viewModel: RestaurantListViewModel!
  weak var coordinator: RestaurantListCoordinator!

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }

  func bindViewModel() {
    assert(viewModel != nil)

    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .mapToVoid()
      .asDriverOnErrorJustComplete()
    
    let input = RestaurantListViewModel.Input(start: Driver.merge(viewWillAppear))

    let output = viewModel.transform(input: input)

    output.list.drive(tableView.rx.items(cellIdentifier: RestaurantViewCell.identifier, cellType: RestaurantViewCell.self)) { [weak self] tv, viewModel, cell in
      guard let self = self else { return }
      cell.bind(viewModel: viewModel, onShareTap: self.coordinator.presentShare(text:))
    }.disposed(by: disposeBag)
  }

  override func viewDidLayoutSubviews() {
    tableView.pin
      .top(view.pin.safeArea.top)
      .bottom()
      .horizontally()

  }
}

