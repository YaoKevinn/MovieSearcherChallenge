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
        let vc = UIHostingController(rootView: VStack { Text("Header") }.frame(maxWidth: .infinity, alignment: .leading).padding(20).background(Color.theme.accent) )
        return vc.view
    }()
    
    private lazy var paginatorView: UIView = {
        let vc = UIHostingController(rootView: VStack { Text("Paginator") }.frame(maxWidth: .infinity, alignment: .leading).padding(20).background(Color.theme.accent) )
        return vc.view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [headerView, tableView, paginatorView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.topSafeArea),
            paginatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.bottomSafeArea)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeMovieCardTableViewCell")
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieCardTableViewCell", for: indexPath)
         cell.contentConfiguration = UIHostingConfiguration {
             Text("This is an table cell")
         }
         return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}


