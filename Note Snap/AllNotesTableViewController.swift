//
//  AllNotesTableViewController.swift
//  Note Snap
//
//  Created by Elina Lua Ming on 1/28/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit

class AllNotesTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var filteredNotes: [PageContent] = []
    
    private lazy var pageViewController: PageViewController = {
        let vc = PageViewController()
//        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.definesPresentationContext = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive &&
            self.searchController.searchBar.text != "" {
                return filteredNotes.count
        }
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if self.searchController.isActive &&
            self.searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredNotes[indexPath.row].title
        } else {
            cell.textLabel?.text = items[indexPath.row].title
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var note: PageContent

        if self.searchController.isActive &&
            self.searchController.searchBar.text != "" {
                note = filteredNotes[indexPath.row]
        } else {
            note = items[indexPath.row]
        }
        
        self.searchController.dismiss(animated: true)

        pageViewController.setPageContent(title: note.title!, content: note.content!)
//        let vc = UINavigationController(rootViewController: pageViewController)
//        vc.modalPresentationStyle = .fullScreen
        
        self.present(pageViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllNotesTableViewController {
    
    func setup() {
        self.view.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterNotes(for searchText:String) {
        let searchText = searchText.lowercased()
        
        filteredNotes = items.filter({ page -> Bool in
            return (page.title?.lowercased().contains(searchText))! || (page.content?.lowercased().contains(searchText))!
        })
        self.tableView.reloadData()
    }
    
}

extension AllNotesTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterNotes(for: searchController.searchBar.text ?? "")
    }
        
}
