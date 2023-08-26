//
//  Utils.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import UIKit

protocol UtilsProtocol {
    func saveImage(image: UIImage, filename: String, completion: @escaping (String) -> ())
    func obtainImage(from key: String) -> UIImage?
}

class Utils: UtilsProtocol {
    
    func saveImage(image: UIImage, filename: String, completion: @escaping (String) -> ()) {
        if let imageData = image.pngData() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsDirectory.appendingPathComponent(filename + ".png")
            
            do {
                try imageData.write(to: fileURL)
                completion(fileURL.absoluteString)
                print("Image saved to \(fileURL)")
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
    func obtainImage(from key: String) -> UIImage? {
        if let url = URL(string: key), let imageData = try? Data(contentsOf: url) {
            if let loadedImage = UIImage(data: imageData) {
                // Use `loadedImage` as needed
                return loadedImage
            } else {
                print("Error creating UIImage from data.")
                return nil
            }
        } else {
            print("Error loading image data from file.")
            return nil
        }
    }
    
    private func filePath(for key: String) -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(key)
    }
}
