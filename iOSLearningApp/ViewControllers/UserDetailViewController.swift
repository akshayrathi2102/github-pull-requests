//
//  UserDetailViewController.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 15/09/22.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    
    private let mainActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private let userDetail: User
    private var userDetailArray: [cellModel] = []
    private let userDetailTableView: UITableView
    private let userDetailViewModel: UserDetailViewModel
    private let alertController = UIAlertController(title:Constants.String.alertControllerTitle, message:Constants.String.alertControllerMessage, preferredStyle: .alert)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(user: User) {
        userDetailViewModel = UserDetailViewModel(user: user)
        userDetail = user
        userDetailTableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userDetail.login
        setupMainActivityIndicatorView()
        setupAlertController()
        userDetailViewModel.userDetailViewModelDelegate = self
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(), UIBarButtonItem()]
        userDetailViewModel.viewDidLoad(user: userDetail)
        setupTableView()
    }
    
    private func setupAlertController() {
        let okAction = UIAlertAction(title: Constants.String.okActionTitle, style: .default) {
            (action: UIAlertAction) in
            self.userDetailViewModel.rightSideBarButtonItemTapped()
        }
        let cancelAction = UIAlertAction(title: Constants.String.cancelActionTitle, style: .cancel) {
            (action: UIAlertAction) in return
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    private func setupMainActivityIndicatorView() {
        mainActivityIndicatorView.color = Constants.Theme.primaryColor
        view.addSubview(mainActivityIndicatorView)
        mainActivityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    func setupRightBarButton(buttonName: String) {
        self.navigationItem.rightBarButtonItems?[0] = UIBarButtonItem(
            image: UIImage(systemName: buttonName),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped(sender:))
        )
    }
    
    func setupFavouriteButton(buttonName: String) {
        self.navigationItem.rightBarButtonItems?[1] = UIBarButtonItem(
            image: UIImage(systemName: buttonName),
            style: .plain,
            target: self,
            action: #selector(favouriteButtonTapped(sender:))
        )
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem) {
        userDetailViewModel.rightSideBarButtonItemTapped()
    }
    
    @objc func favouriteButtonTapped(sender: UIBarButtonItem) {
        userDetailViewModel.favouriteButtonTapped()
    }
}

// MARK: toast from stackoverflow

extension UIViewController {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-100, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: Constants.Theme.primaryFontSize)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = Constants.Theme.cornerRadius;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: ViewModelDelegate implementation
extension UserDetailViewController: UserDetailViewModelDelegate {
    func setupTableView() {
        userDetailTableView.dataSource = self
        userDetailTableView.delegate = self
        userDetailTableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.self.description())
        userDetailTableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.self.description())
        userDetailTableView.separatorStyle = .none
        userDetailTableView.backgroundColor = .white
        userDetailTableView.allowsSelection = false
        view.addSubview(userDetailTableView)
        userDetailTableView.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func loadData(_ data: [cellModel]) {
        userDetailArray = data
        userDetailTableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        if(show == true) {
            mainActivityIndicatorView.startAnimating()
        } else {
            mainActivityIndicatorView.stopAnimating()
        }
    }
    
    func showError() {
        print(Constants.ErrorMessage.defaultErrorMessage)
    }
}


// MARK: UITableViewDataSource implementation

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != 0) {
            guard let cell = userDetailTableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.self.description(), for: indexPath) as? UserDetailTableViewCell else {
                return UserDetailTableViewCell()
            }
            let data: cellModel = userDetailArray[indexPath.row - 1]
            cell.setData(key: data.leftLabel, value: data.rightLabel)
            return cell
        } else {
            guard let cell =  userDetailTableView.dequeueReusableCell(withIdentifier: ProfileImageTableViewCell.self.description(), for: indexPath) as? ProfileImageTableViewCell else {
                return ProfileImageTableViewCell()
            }
            if let avatar_url = userDetail.avatar_url {
                cell.setData(imageUrl: avatar_url)
            }
            return cell
        }
    }
}

