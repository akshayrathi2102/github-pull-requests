//
//  ViewController.swift
//  iOSLearningApp
//
//  Created by Nveen Bandlamudi on 09/06/22.
//

import UIKit

class PullRequestListViewController: UIViewController {
    private var pullRequestResponse:[PullRequest] = []
    private let pullRequestListTableView = UITableView()
    private let pullRequestViewModel = PullRequestListViewModel()
    private let mainActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    var moreDataAvailable = 1 // set by VM
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Notification.Name.favouriteNotificationName) , object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.String.tableViewTitle
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.toggleFavourite(_:)),
                                               name: NSNotification.Name(rawValue: Notification.Name.favouriteNotificationName),
                                               object: nil)
        setupTableView()
        setupMainActivityIndicatorView()
        pullRequestViewModel.pullRequestViewModelDelegate = self
        pullRequestViewModel.viewDidLoad()
    }
    
    @objc func toggleFavourite(_ notification: Notification) {
        guard let username: String = notification.object as? String else {
            return
        }
        pullRequestViewModel.toggleFavourite(username: username)
    }
    
    func setupMainActivityIndicatorView() {
        mainActivityIndicatorView.color = .lightGray
        mainActivityIndicatorView.backgroundColor = .white
        view.addSubview(mainActivityIndicatorView)
        
        mainActivityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
}

// MARK: ViewModelDelegate implementation

extension PullRequestListViewController: PullRequestViewModelDelegate {
    
    func setupTableView() {
        pullRequestListTableView.dataSource = self
        pullRequestListTableView.delegate = self
        pullRequestListTableView.register(PullRequestListTableViewCell.self, forCellReuseIdentifier: PullRequestListTableViewCell.self.description())
        pullRequestListTableView.register(LoaderTableViewCell.self, forCellReuseIdentifier: LoaderTableViewCell.self.description())
        pullRequestListTableView.separatorStyle = .none
        pullRequestListTableView.backgroundColor = .white
        view.addSubview(pullRequestListTableView)
        pullRequestListTableView.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func showLoader(_ show: Bool) {
        if(show == true) {
            mainActivityIndicatorView.startAnimating()
        } else {
            mainActivityIndicatorView.stopAnimating()
        }
        
    }
    
    func loadData(_ data: [PullRequest]) {
        pullRequestResponse = data
        pullRequestListTableView.reloadData()
    }
    
    func loadCellData(_ data: PullRequest, indexPath: IndexPath) {
        pullRequestResponse[indexPath.row] = data
        pullRequestListTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    func showError() {
        print(Constants.ErrorMessage.defaultErrorMessage)
    }
}


// MARK: UITableViewDataSource and UITableViewDelegate implementation

extension PullRequestListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestResponse.count + moreDataAvailable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < pullRequestResponse.count, let cell = pullRequestListTableView.dequeueReusableCell(withIdentifier: PullRequestListTableViewCell.self.description(), for: indexPath) as? PullRequestListTableViewCell {
            let item = pullRequestResponse[indexPath.row]
            cell.buttonTapCallback = { [weak self] in
                guard let username = item.user?.login else {
                    return
                }
                self?.pullRequestViewModel.toggleFavourite(username: username)
            }
            cell.setData(item: item)
            return cell
        } else {
            guard let cell = pullRequestListTableView.dequeueReusableCell(withIdentifier: LoaderTableViewCell.self.description(), for: indexPath) as? LoaderTableViewCell else {
                let cell = LoaderTableViewCell()
                cell.showLoader(true)
                return cell
            }
            cell.showLoader(true)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = pullRequestResponse[indexPath.row].user else  { return }
        self.navigationController?.pushViewController(UserDetailViewController(user: user), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pullRequestViewModel.willDisplayTableCell(indexPath: indexPath)
    }
}
