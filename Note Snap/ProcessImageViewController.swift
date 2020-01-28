//
//  ProcessImageViewController.swift
//  NoteSnap
//
//  Created by Elina Lua Ming and Jacob Nguyen on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit
import FirebaseMLVision

class ProcessImageViewController: UIViewController {
    
    private let image: UIImage?
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView(image: image)
        imageview.frame = .zero
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
    
        return imageview
    }()
    
    private lazy var processButton: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Process"
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupViews()
        self.applyConstraints()
        self.setupTapGesture()
        
        print("view did load")
    }
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

}

extension ProcessImageViewController: UINavigationControllerDelegate {
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(processButtonTapped(_:)))
        processButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func processButtonTapped(_ sender: UITapGestureRecognizer) {
        print("process button tapped")
        
        DispatchQueue.main.async {
            let imageView = UIImageView(image: self.image)
            
            let vision = Vision.vision()
            textRecognizer = vision.onDeviceTextRecognizer()
            runTextRecognition(with: (imageView.image!))
        }
        
        self.dismiss(animated: true, completion: nil)
        // process text
        
        // completion handler: create new page content instance
        
        // add to journal view controller items array (core data)
            // if no title, "Untitled"
        
        // reload table view with items array
        
    }
    
    func setupViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(processButton)
    }
    
    func applyConstraints() {
        let layoutMargins = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor, constant: -100),
            self.imageView.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor),
            self.imageView.heightAnchor.constraint(equalTo: layoutMargins.widthAnchor),
            
            self.processButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 100),
            self.processButton.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor, multiplier: 3/5),
            self.processButton.heightAnchor.constraint(equalTo: layoutMargins.heightAnchor, multiplier: 1/10),
            self.processButton.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor)
        ])
    }
    
}
