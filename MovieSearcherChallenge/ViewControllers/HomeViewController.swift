//
//  HomeViewController.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 30/12/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    var repository: MovieRepositoryProtocol? = nil
    var movies: [Movie] = []
    var currentPage: Int = 1
    var totalPage: Int = 1
    var searchText: String = ""
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var headerView: UIView = {
        let view = HeaderView { searchText in
            self.getData(searchText: searchText)
        }
        let vc = UIHostingController(rootView: view)
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getData(searchText: String, page: Int = 1) {
        let isDifferentSearchText: Bool = searchText != self.searchText
        if isDifferentSearchText {
            self.searchText = searchText
        }
        repository?.getMovies(
            searchText: searchText,
            page: isDifferentSearchText ? 1 : page,
            completion: { [weak self] movies, currentPage, totalPage in
                self?.movies = movies
                self?.currentPage = currentPage
                self?.totalPage = totalPage
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
                }
                print("🔥 PASA POR ACA: Page \(currentPage) with \(movies.count) movies and a total \(totalPage)")
            },
            errorHandler: { error in
                print("🔥 PASA POR ACA: \(error)")
            })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != movies.count {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieCardTableViewCell", for: indexPath)
            cell.backgroundColor = UIColor(Color.theme.primaryBlack)
            cell.selectionStyle = .none
             cell.contentConfiguration = UIHostingConfiguration {
                 MovieCardView(movie: self.movies[indexPath.row], onTapCard: {
                     self.dismissKeyboard()
                     let vc = UIHostingController(rootView: MovieDetailView(movie: self.movies[indexPath.row]))
                     self.navigationController?.pushViewController(vc, animated: true)
                 })
             }
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaginatorViewCell", for: indexPath)
            cell.backgroundColor = UIColor(Color.theme.primaryBlack)
            cell.selectionStyle = .none
             cell.contentConfiguration = UIHostingConfiguration {
                 PaginatorView(
                    currentPage: currentPage,
                    totalPage: totalPage,
                    previousPageAction: {
                        if self.currentPage != 1 {
                            self.getData(searchText: self.searchText, page: self.currentPage - 1)
                        }
                    },
                    nextPageAction: {
                        if self.currentPage < self.totalPage {
                            self.getData(searchText: self.searchText, page: self.currentPage + 1)
                        }
                    }
                 )
             }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count + (movies.count == 0 ? 0 : 1) // count + 1
    }
}


