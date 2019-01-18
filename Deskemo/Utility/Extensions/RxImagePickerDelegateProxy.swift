//
//  RxImagePickerDelegateProxy.swift
//  Deskemo
//
//  Created by TriNgo on 1/18/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

#if os(iOS)

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy
: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
    
}

#endif
