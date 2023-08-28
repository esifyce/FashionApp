//
//  StatusBar.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit
import SnapKit

class StatusBar: UIView {
    
    // MARK: - Property
    
    var items = [UIButton]()
    var selectedItem = UIButton()
    var didTapCallBack: ((UIImage.Clothes) -> Void)?
    
    // MARK: - Views
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        scroll.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 20)
        return scroll
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        setupConstraints()
    }
    
    // MARK: - Configure View
    
    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        backgroundColor = .lightGrayColor
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(57)
         }
        
        stackView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(4)
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    
    @objc func tapped(_ sender: UIButton) {
        selectedItem.setStatusBar(backgroundColor: .clear, titleColor: .black, borderWidth: 1)
        selectedItem = sender
        sender.setStatusBar(backgroundColor: .white, titleColor: .mainColor, borderWidth: 0)
        let buttonFrame = sender.superview?.convert(sender.frame, from: scrollView)
        scrollView.scrollRectToVisible(buttonFrame ?? .zero, animated: true)
        didTapCallBack?(UIImage.Clothes(rawValue: sender.tag) ?? .hair)
    }
    
    // MARK: - Helpers
    
    func setup(models: [StatusBarViewModel], index: Int?) {
        items = []
        removeItemsFromParent()
        models.forEach { style in
            let button = UIButton()
            button.setTitle(style.name, for: .normal)
            button.tag = style.id
            button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
            button.setStatusBar(backgroundColor: .clear, titleColor: .black, borderWidth: 1)
            items.append(button)
            stackView.addArrangedSubview(button)
        }
        
        tapped(items[index ?? 0])
    }
    
    func addTargets(_ target: Any?, action: Selector, For: UIControl.Event) {
        items.forEach { button in
            button.addTarget(target, action: action, for: For)
        }
    }
     
    func getSelectedItemId() -> Int {
        return selectedItem.tag
    }
    
    private func removeItemsFromParent() {
        for i in stackView.subviews {
            i.removeFromSuperview()
        }
    }
}

extension UIButton {
    func setStatusBar(backgroundColor: UIColor, titleColor: UIColor, borderWidth: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.backgroundColor = backgroundColor
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.lightGrayColor.cgColor
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
}
