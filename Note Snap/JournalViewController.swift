//
//  JournalViewController.swift
//  NoteSnap
//
//  Created by Elina Lua Ming and Jacob Nguyen on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {
    
    var filteredNotes: [PageContent] = []

    private lazy var searchResultController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Notes"
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubviews()
        self.applyConstraints()
        self.setupSearchBar()
        self.setupTableView()
    }

}

extension JournalViewController {
    
    func setupSearchBar() {
//        self.searchResultController = self.searchBar
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func addSubviews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
    }
    
    func applyConstraints() {
        let layoutMargins = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            self.searchBar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8),
            
            self.tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor)
        ])
        
    }
    
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PageViewController()
        vc.setPageContent(title: items[indexPath.row].title!, content: items[indexPath.row].content!)
        self.present(vc, animated: true, completion: nil)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension JournalViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
}
