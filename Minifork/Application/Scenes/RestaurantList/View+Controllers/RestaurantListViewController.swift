//
//  ListViewController.swift
//  Minifork
//
//  Created by Felipe Fernandes on 18/12/21.
//

import Foundation
import UIKit
import PinLayout

class RestaurantListViewController: UIViewController {

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .white
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.backgroundColor = AppColor.gray
    tableView.dataSource = self
    tableView.allowsSelection = false
    tableView.register(RestaurantViewCell.self, forCellReuseIdentifier: RestaurantViewCell.identifier)
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .red
    configureTableView()
  }

  func configureTableView() {
    self.view.addSubview(tableView)
  }

  override func viewDidLayoutSubviews() {
    tableView.pin
      .top(view.pin.safeArea.top)
      .bottom()
      .horizontally()

  }
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantViewCell.identifier,
                                                   for: indexPath)

    cell.prepareForReuse()

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

}
