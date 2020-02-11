//
//  VisionFunctions.swift
//  NoteSnap
//
//  Created by Elina Lua Ming on 1/26/20.
//  Copyright © 2020 Elina Lua Ming. All rights reserved.
//
//  Description:- Functions to run Vision requests. 

import UIKit
import FirebaseMLVision
import CoreData

var items: [PageContent] = [
    PageContent(title: "QWER Hacks 2020", content: "This is fun", languages: ["English"]),
    PageContent(title: "Hello World", content: "This is testing", languages: ["English"])
]

//var textRecognizer: VisionTextRecognizer!
var documentTextRecognizer: VisionDocumentTextRecognizer!

func runTextRecognition(with image: UIImage) {
    let visionImage = VisionImage(image: image)
        documentTextRecognizer.process(visionImage){ (features, error) in
               processDocTextResult(from: features, error: error) {
        }
    }
    
    
 }

func processDocTextResult(from text: VisionDocumentText?, error: Error?, completionHandler: ()->()) {
    if let error = error {
        print(error.localizedDescription)
    }
    
    guard let features = text else {
        print("Unable to scan text.")
        return
    }

    var content = ""
    var languages: [String] = []
    
    for block in features.blocks{
        content.append(contentsOf: block.text + "\n\n")
        for language in block.recognizedLanguages {
            if let languageCode = language.languageCode {
                let decodedLanguage = checkLanguage(languageCode: languageCode)
                if !languages.contains(decodedLanguage) {
                    languages.append(decodedLanguage)
                }
            }
        }
    }
//    print("this is context text:\n" + content)
//    print("these are the languages")
//    for language in languages {
//        print(language)
//    }
    let newNote = PageContent(title: "New Note", content: content, languages: languages)
//    items.insert(newPage, at: 0)
    let persistentManager = PersistentManager.shared
    let context = persistentManager.context
    
//    let note = Notes(context: context)
    
 }

func checkLanguage(languageCode language: String) -> String {
    switch language {
    case "af":
        return "Afrikaans"
    case "sq":
        return "Albanian"
    case "ar":
        return "Arabic"
    case "hy":
        return "Armenian"
    case "be":
        return "Belorussian"
    case "bn":
        return "Bengali"
    case "bg":
        return "Bulgarian"
    case "ca":
        return "Catalan"
    case "zh":
        return "Chinese"
    case "hr":
        return "Croatian"
    case "cs":
        return "Czech"
    case "da":
        return "Danish"
    case "nl":
        return "Dutch"
    case "en":
        return "English"
    case "et":
        return "Estonian"
    case "fil", "tl":
        return "Filipino"
    case "fn":
        return "Finnish"
    case "fr":
        return "French"
    case "de":
        return "German"
    case "el":
        return "Greek"
    case "gu":
        return "Gujarati"
    case "iw":
        return "Hebrew"
    case "hi":
        return "Hindi"
    case "hu":
        return "Hungarian"
    case "is":
        return "Icelandic"
    case "id":
        return "Indonesian"
    case "it":
        return "Italian"
    case "ja":
        return "Japanese"
    case "kn":
        return "Kannada"
    case "km":
        return "Khmer"
    case "ko":
        return "Korean"
    case "lo":
        return "Lao"
    case "lv":
        return "Latvian"
    case "lt":
        return "Lithuanian"
    case "mk":
        return "Macedonian"
    case "ms":
        return "Malay"
    case "ml":
        return "Malayalam"
    case "mr":
        return "Marathi"
    case "ne":
        return "Nepali"
    case "no":
        return "Norwegian"
    case "fa":
        return "Persian"
    case "pl":
        return "Polish"
    case "pt":
        return "Portuguese"
    case "pa":
        return "Punjabi"
    case "ro":
        return "Romanian"
    case "ru":
        return "Russian"
    case "ru-PETR1708":
        return "Russian"
    case "sr":
        return "Serbian"
    case "sr-Latn":
        return "Serbian"
    case "sk":
        return "Slovak"
    case "sl":
        return "Slovenian"
    case "es":
        return "Spanish"
    case "sv":
        return "Swedish"
    case "ta":
        return "Tamil"
    case "te":
        return "Telugu"
    case "th":
        return "Thai"
    case "tr":
        return "Turkish"
    case "uk":
        return "Ukrainian"
    case "vi":
        return "Vietnamese"
    case "yi":
        return "Yiddish"
    default:
        return "Undetected"
    }
}
