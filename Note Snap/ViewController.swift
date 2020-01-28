//
//  ViewController.swift
//  NoteSnap
//
//  Created by Elina Lua Ming and Jacob Nguyen on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    private lazy var journalView: UIImageView = {
        let image = UIImage(named: "journal")
        let journalImageView = UIImageView(image: image)
        journalImageView.frame = .zero
        journalImageView.translatesAutoresizingMaskIntoConstraints = false
        journalImageView.isUserInteractionEnabled = true
        
        return journalImageView
    }()
    
    private lazy var cameraView: UIView = {
        let image = UIImage(named: "camera")
        let cameraImageView = UIImageView(image: image)
        cameraImageView.frame = .zero
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        cameraImageView.isUserInteractionEnabled = true
        
        return cameraImageView
    }()
    
    private lazy var photoLibraryView: UIView = {
        let image = UIImage(named: "image")
        let photoLibraryView = UIImageView(image: image)
        photoLibraryView.frame = .zero
        photoLibraryView.translatesAutoresizingMaskIntoConstraints = false
        photoLibraryView.isUserInteractionEnabled = true
        
        return photoLibraryView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubviews()
        self.applyConstraints()
        self.addGestures()
        
//        self.setupPhotos()
//        self.setupCamera()
    }

}

extension ViewController {
    
    func addGestures() {
        let journalTap = UITapGestureRecognizer(target: self, action: #selector(journalTapped(_:)))
        journalView.addGestureRecognizer(journalTap)
        
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(_:)))
        cameraView.addGestureRecognizer(cameraTap)
        
        let photoLibraryTap = UITapGestureRecognizer(target: self, action: #selector(photoLibraryTapped(_:)))
        photoLibraryView.addGestureRecognizer(photoLibraryTap)
    }
    
    @objc func journalTapped(_ sender: UITapGestureRecognizer) {
        self.present(JournalViewController(), animated: true, completion: nil)
    }
    
    func addSubviews() {
        self.view.addSubview(journalView)
        self.view.addSubview(cameraView)
        self.view.addSubview(photoLibraryView)
    }
    
    func applyConstraints() {
        let layoutMargins = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.journalView.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            self.journalView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
            self.journalView.heightAnchor.constraint(equalTo: layoutMargins.widthAnchor, multiplier: 1/6),
            self.journalView.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor, multiplier: 1/6),
            
            self.cameraView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            self.cameraView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.cameraView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4),
            self.cameraView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4),
            
            self.photoLibraryView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50),
            self.photoLibraryView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.photoLibraryView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4),
            self.photoLibraryView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4),
        ])
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func cameraTapped(_ sender: UITapGestureRecognizer) {
        print("camera tapped")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .camera
        
        self.present(imagePickerController, animated: true)
    }
    
    @objc func photoLibraryTapped(_ sender: UITapGestureRecognizer) {
        print("photo library tapped")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.image"]
        
        self.present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true) {
            let vc = ProcessImageViewController(image: image!)
            vc.modalPresentationStyle = .fullScreen
            
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            
            self.present(navVC, animated: true)
        }
    }
    
    @objc func backAction(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
