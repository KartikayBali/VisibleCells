//
//  ViewController.swift
//  GeniusPlaza
//
//  Created by Bali on 22/11/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let limit = 100
  let tableView = UITableView(frame: .zero, style: .plain)
  var cellInfos = [CellInfo]()
  var currentSecond = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    initializeData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
  }
  
  @objc private func timerUpdated() {
    currentSecond += 1
    updateVisibleCells()
  }
  
  private func updateVisibleCells() {
    if let indexPaths = tableView.indexPathsForVisibleRows {
      for indexPath in indexPaths {
        cellInfos[indexPath.row].totalTime += 1
      }
      
      tableView.reloadRows(at: indexPaths, with: .automatic)
    }
  }
  
  private func initializeData() {
    for _ in 0..<limit {
      cellInfos.append(CellInfo())
    }
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return limit
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Identifier"
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
    }
    
    cell!.textLabel?.text = "\(cellInfos[indexPath.row].totalTime)"
    return cell!
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
}

