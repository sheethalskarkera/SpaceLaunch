//
//  SpaceLaunchDetailViewController.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 18/1/22.
//

import UIKit

final class SpaceLaunchDetailViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var firstFlightLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var refreshControl: UIRefreshControl!
    var viewModel : SpaceLaunchDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        viewModel.delegate = self
        loadingIndicator.startAnimating()
        viewModel.getAstronautDetails()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.getAstronautDetails()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
}

// MARK: UI setup
private extension SpaceLaunchDetailViewController {
    
    func updateUI() {
        refreshControl.endRefreshing()
        loadingIndicator.stopAnimating()
        nameLabel.text = viewModel.nameText
        nationalityLabel.text = viewModel.nationality
        bioLabel.text = viewModel.astronaut?.bio
        thumbnailImageView.downloadImage(urlString: viewModel.astronaut?.profileImageThumbnail, placeHolderImage: nil)
        dobLabel.text = viewModel.dateOfBirth
        firstFlightLabel.text = viewModel.firstFlight
    }
}


// MARK: SpaceLaunchDetailViewModelDelegate

extension SpaceLaunchDetailViewController: SpaceLaunchDetailViewModelDelegate {
    func shouldReloadView() {
        updateUI()
    }
    
    func showErrorMessage(message: String?) {
        refreshControl.endRefreshing()
        loadingIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
