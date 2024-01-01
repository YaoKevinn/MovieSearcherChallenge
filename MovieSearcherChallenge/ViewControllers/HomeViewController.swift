//
//  HomeViewController.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 30/12/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var headerView: UIView = {
        let vc = UIHostingController(rootView: HeaderView())
        return vc.view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(Color.theme.primaryBlack)
        let stackView = UIStackView(arrangedSubviews: [headerView, tableView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.topSafeArea)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeMovieCardTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PaginatorViewCell")
        tableView.backgroundColor = UIColor(Color.theme.primaryBlack)
        tableView.separatorColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 3 {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieCardTableViewCell", for: indexPath)
            cell.backgroundColor = UIColor(Color.theme.primaryBlack)
            cell.selectionStyle = .none
             cell.contentConfiguration = UIHostingConfiguration {
                 MovieCardView()
             }
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaginatorViewCell", for: indexPath)
            cell.backgroundColor = UIColor(Color.theme.primaryBlack)
            cell.selectionStyle = .none
             cell.contentConfiguration = UIHostingConfiguration {
                 PaginatorView(isPreviousAvailable: .constant(false), isNextAvailable: .constant(true))
             }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // count + 1
    }
}


