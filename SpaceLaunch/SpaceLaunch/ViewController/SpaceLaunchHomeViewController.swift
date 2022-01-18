//
//  SpaceLaunchHomeViewController.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//


import UIKit

class SpaceLaunchHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private var sortBarItem: UIBarButtonItem!
    
    var sortType: SortType = .ascending
    
    var viewModel =  SpaceLaunchListViewModel(astronautService: AstronautService.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getAstronautList()
        title = viewModel.title
    }
    
    private func setupUI() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        if sortBarItem == nil {
            sortBarItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.sortBarItemTapped(_:)))
        }
        sortBarItem.title = "Name<\( sortType.rawValue)>"
        navigationItem.rightBarButtonItem = sortBarItem
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.getAstronautList()
    }
}

// MARK: TableView DataSource
extension SpaceLaunchHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpaceLaunchCell.self), for: indexPath) as? SpaceLaunchCell else {
            return UITableViewCell()
        }
        cell.configure(model: viewModel.fetchSpaceLaunchCellViewModel(index: indexPath.row))
        return cell
    }
}

// MARK: TableView Delegate
extension SpaceLaunchHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(for: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func navigateToDetailView(for index: Int) {
        guard  let astronautDetail = viewModel.astronauts?[index] else {
            return
        }
        let spaceLaunchDetailViewController = UIStoryboard.spaceLaunchDetailViewController
        spaceLaunchDetailViewController.viewModel = SpaceLaunchDetailViewModel(astronautService: AstronautService.default, id: astronautDetail.id)
        navigationController?.pushViewController(spaceLaunchDetailViewController, animated: true)
    }
}

// MARK: SpaceLaunchListViewModelDelegate

extension SpaceLaunchHomeViewController: SpaceLaunchListViewModelDelegate {
    func shouldReloadView() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showErrorMessage(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK:  Sort by Name
extension SpaceLaunchHomeViewController {
    
    @objc func sortBarItemTapped(_ sender: Any) {
        switch sortType {
        case .ascending:
            sortType = .descending
        case .descending:
            sortType = .ascending
        }
        sortBarItem.title = "Name<\( sortType.rawValue)>"
        viewModel.sortAstronauts(type: sortType)
    }
}

