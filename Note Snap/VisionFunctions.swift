//
//  VisionFunctions.swift
//  NoteSnap
//
//  Created by Elina Lua Ming and Jacob Nguyen on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//

import UIKit
import FirebaseMLVision

var items: [PageContent] = [
    PageContent(title: "QWER Hacks 2020", content: "This is fun"),
    PageContent(title: "Hello World", content: "This is testing")
]

var textRecognizer: VisionTextRecognizer!

func runTextRecognition(with image: UIImage) {
     let visionImage = VisionImage(image: image)
     textRecognizer.process(visionImage){ (features, error) in
        processResult(from: features, error: error) {
            
        }
     }
 }

func processResult(from text: VisionText?, error: Error?, completionHandler: ()->()) {
    guard let features = text else { return }
    
    var contentText = ""
    for block in features.blocks{
     for line in block.lines{
         for element in line.elements{
            contentText.append(contentsOf: element.text + " ")
         }
     }
    }
    
    let newPage = PageContent(title: "New Note", content: contentText)
    items.insert(newPage, at: 0)
 }
