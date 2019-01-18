//
//  ImageManager.swift
//  Deskemo
//
//  Created by TriNgo on 1/18/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum ImagePickerError: Error {
}

protocol ImageManagerProtocol {
    func pickImage(_ type: UIImagePickerController.SourceType) -> Observable<UIImage>
}

final class ImageManager: ImageManagerProtocol {
    
    let viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pickImage(_ type: UIImagePickerController.SourceType) -> Observable<UIImage> {
        return UIImagePickerController.rx.createWithParent(viewController) { picker in
            picker.sourceType = type
            picker.allowsEditing = false
            }
            .flatMap { $0.rx.didFinishPickingMediaWithInfo }
            .take(1)
            .map { info in
                guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
                    return UIImage()
                }
                return image
        }
    }
}
