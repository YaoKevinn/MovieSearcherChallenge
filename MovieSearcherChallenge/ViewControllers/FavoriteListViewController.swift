//
//  FavoriteListViewController.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import UIKit
import SwiftUI

class FavoriteListViewController: UIViewController {
    
    var repository: MovieRepositoryProtocol? = nil
    var movies: [MovieDTO] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(Color.theme.primaryBlack)
        let stackView = UIStackView(arrangedSubviews: [tableView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeMovieCardTableViewCell")
        tableView.backgroundColor = UIColor(Color.theme.primaryBlack)
        tableView.separatorColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func getData() {
        movies = repository?.getAllFavorites() ?? []
        if movies.isEmpty {
            self.showAlert(
                title: "No result found",
                message: "Please add a movie to favorite"
            )
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAlertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alertController.dismiss(animated: true)
            completion?()
        }
    
        alertController.addAction(okAlertAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieCardTableViewCell", for: indexPath)
        cell.backgroundColor = UIColor(Color.theme.primaryBlack)
        cell.selectionStyle = .none
         cell.contentConfiguration = UIHostingConfiguration {
             MovieCardView(movie: self.movies[indexPath.row], onTapCard: {
                 let vc = UIHostingController(rootView: MovieDetailView(movie: self.movies[indexPath.row]))
                 self.navigationController?.pushViewController(vc, animated: true)
             })
         }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}
