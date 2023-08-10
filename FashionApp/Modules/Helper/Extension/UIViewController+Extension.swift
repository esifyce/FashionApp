//
//  UIViewController+Extension.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

extension UIViewController {
    func showCustomView(view: UIView, inWindow: Bool = true) {
        if inWindow {
            let keyWindow: UIWindow? = UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .last { $0.isKeyWindow }
            keyWindow?.addSubview(view)
        } else {
            self.view.addSubview(view)
        }
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
