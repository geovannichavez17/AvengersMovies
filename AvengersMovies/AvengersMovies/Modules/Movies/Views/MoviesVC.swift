//
//  MoviesVC.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 28/2/24.
//

import UIKit

class MoviesVC: BaseVC {
    
    let collectionViewCellID = "collectionViewCellID"
    var viewModel: MoviesViewModel?
    var viewAlreadyAppeared = false
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Avengers Films"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MoviesCell.self, forCellReuseIdentifier: collectionViewCellID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelectionDuringEditing = false
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func set(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewAlreadyAppeared {
            viewModel?.retrieveMovies()
            viewAlreadyAppeared = true
        }
    }
    
    func renderUI() {
        self.setNavigationBar(title: "Movies")
        self.configureContentView()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(moviesTableView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22)
        ])
        
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            moviesTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            moviesTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            moviesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    
    private func bindViewModel() {
        viewModel?.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingDialog()
                } else {
                    self.hideLoadingDialog(completion: nil)
                }
            }
        }
        
        viewModel?.errorMessage.bind{ [weak self] message in
            guard let self = self else { return }
            guard let message = message else { return }
            DispatchQueue.main.async {
                let title = Constants.Common.titleError
                self.showAlert(title: title, message: message, accept: nil)
            }
        }
        
        viewModel?.moviesDataSource.bind { [weak self] movies in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
        
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let total = viewModel?.moviesDataSource.value?.count else { return 0 }
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = viewModel?.moviesDataSource.value else { return UITableViewCell() }
        let currentItem = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionViewCellID) as! MoviesCell
        cell.set(item: currentItem)
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.cobrosList[indexPath.row]
        self.presenter?.select(transaction: selectedItem)
    }*/
}
