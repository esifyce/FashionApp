//
//  IphoneSettingsView.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit
import FrameBuilder

enum SettingItems: Int, CaseIterable, CustomStringConvertible {
    case subscribe = 0
    case community
    case terms
    case contactUs
    case importTo
    
    var description: String {
        switch self {
        case .subscribe:
            return "Subscribe Now"
        case .community:
            return "Community"
        case .terms:
            return "Terms"
        case .contactUs:
            return "Contact Us"
        case .importTo:
            return "Import"
        }
    }
}

final class IphoneSettingsView: UIView {
    var maskLayer: CAShapeLayer?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissapearAnimation)))
        return view
    }()
    
    private lazy var settingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemWhiteColor
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setCornerRadius()
        appearAnimation()
    }
    
    func setCornerRadius() {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        if maskLayer == nil {
            maskLayer = CAShapeLayer()
            maskLayer?.path = path.cgPath
            settingView.layer.mask = maskLayer
        }
    }
    
    func show() {
        appearAnimation()
    }
    
    func appearAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.settingView.frame.origin.y = self.frame.size.height - 372
            self.backgroundView.alpha = 1
        }
    }
    
    @objc func dissapearAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.settingView.frame.origin.y = self.frame.size.height
            self.backgroundView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let newPosition = max(settingView.frame.minY + translation.y, frame.height - settingView.frame.height)
        settingView.frame.origin.y = newPosition
        backgroundView.alpha = newPosition / settingView.frame.height
        
        recognizer.setTranslation(.zero, in: self)
        
        switch recognizer.state {
        case .ended:
            if settingView.frame.origin.y > frame.height - (settingView.frame.height / 2) {
                dissapearAnimation()
            } else {
                appearAnimation()
            }
        default:
            break
        }
    }
}

private extension IphoneSettingsView {
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(backgroundView)
        addSubview(settingView)
    }
    
    func makeConstraints() {
        backgroundView.frame = bounds
        settingView.buildFrame(
            FrameBuilder()
                .y(frame.size.height)
                .height(372)
                .width(frame.size.width)
        )
        
        for item in SettingItems.allCases {
            let itemView = IphoneItemView()
            itemView.setTitle(item.description)
            settingView.addSubview(itemView)
            itemView.tag = item.rawValue
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:))))
            itemView.layer.cornerRadius = 10
            itemView.frame = CGRect(x: 16, y: 60 + (item.rawValue * 44 + item.rawValue * 12), width: Int(frame.size.width) - 32, height: 44)
        }
    }
    
    @objc func itemTapped(_ view: UIView) {
        guard let item = SettingItems(rawValue: view.tag) else { return }
        switch item {
        case .subscribe:
            print("Subscribe Now")
        case .community:
            print("Community")
        case .terms:
            print("Terms")
        case .contactUs:
            print("Contact Us")
        case .importTo:
            print("Import")
        }
    }
}
