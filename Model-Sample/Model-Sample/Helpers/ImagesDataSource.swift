//
//  ImagesDataSource.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/19/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

/**
Class represents backend images data storage. Only for code samples.
The class allows to load and store image from and to file system.
*/
class ImagesDataSource {
    static func store(image: UIImage, name: String? = nil) -> URL? {
        guard let imageData = image.pngData(),
            let durectoryURL = documentsDirectoryURL else {
                assertionFailure("Unable to save image to Documents directory")
                return nil
        }
        
        let fileUrl = durectoryURL.appendingPathComponent(name ?? UUID().uuidString)
        do {
            try imageData.write(to: fileUrl)
            return URL(fileURLWithPath: fileUrl.absoluteString)
        } catch {
            assertionFailure("Unable to save image to \(fileUrl)")
            return nil
        }
    }
    
    static func store(imageName: String) -> URL? {
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Unable to get image with name: '\(imageName)'")
            return nil
        }
        return store(image: image, name: imageName)
    }
}

private extension ImagesDataSource {
    static var documentsDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
