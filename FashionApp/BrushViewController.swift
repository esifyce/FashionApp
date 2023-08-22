//
//  BrushViewController.swift
//  FashionApp
//
//  Created by Krasivo on 13.08.2023.
//

//import UIKit
//import KMDrawViewSDK
//import SnapKit
//
//final class BrushViewController: UIViewController {
import UIKit
//import KMDrawViewSDK
import SnapKit

final class BrushViewController: UIViewController {
    private lazy var customView: LayerCustomizeView = {
        let view = LayerCustomizeView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        view.addSubview(customView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.layer.applyFigmaShadow(color: UIColor.blackShadowColor, alpha: 0.2, x: 8, y: 0, blur: 40, spread: 0)
    }
    
    func makeConstraints() {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            customView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.68)
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        } else {
            customView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.height.equalTo(573)
                make.width.equalTo(393)
            }
        }
    }
}
