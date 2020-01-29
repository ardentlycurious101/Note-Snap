//
//  PageViewController.swift
//  NoteSnap
//
//  Created by Elina Lua Ming and Jacob Nguyen on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit

struct PageContent {
    let title: String?
    let content: String?
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

class PageViewController: UIViewController {

    private lazy var pageTitle: UITextView = {
        let title = UITextView()
        title.text = ""
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.isScrollEnabled = false
        title.sizeToFit()
        
        return title
    }()
    
    private lazy var pageTextView: UITextView = {
        let pageTextView = UITextView()
        pageTextView.translatesAutoresizingMaskIntoConstraints = false
        pageTextView.text = ""
        pageTextView.font = UIFont.systemFont(ofSize: 14)
        
        return pageTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubviews()
        self.applyConstraints()
    }

}

extension PageViewController {
    
    func setPageContent(title: String, content: String) {
        self.pageTitle.text = title
        self.pageTextView.text = content
    }
    
    func addSubviews() {
        self.view.addSubview(pageTitle)
        self.view.addSubview(pageTextView)
    }
    
    func applyConstraints() {
        let layoutMargins = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.pageTitle.topAnchor.constraint(equalTo: layoutMargins.topAnchor, constant: 20),
            self.pageTitle.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            self.pageTitle.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            
            self.pageTextView.topAnchor.constraint(equalTo: self.pageTitle.bottomAnchor),
            self.pageTextView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            self.pageTextView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            self.pageTextView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor)
        ])
    }
    
}
