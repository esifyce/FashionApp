//
//  BrushListView.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit
import SnapKit

extension BrushListView {
    struct Appearance {
        
    }
}

protocol BrushListViewDelegate: AnyObject {
    func colorPickerTapped()
    func closeTapped()
    func didTapBrush(with viewModel: BrushViewModel)
}

final class BrushListView: UIView {
    
    // MARK: - Property
    
    private let appearance: Appearance
    private let collectionManager: BrushCollectionManagerProtocol
    
    weak var delegate: BrushListViewDelegate?
    var viewModels: [BrushViewModel] = [
        .init(image: .Pen.penMenu, isSelected: false, opacity: 100, size: 34, type: .pen, color: .mainColor),
        .init(image: .Pen.pencilMenu, isSelected: false, opacity: 100, size: 34, type: .pencil, color: .mainColor),
        .init(image: .Pen.markerMenu, isSelected: false, opacity: 100, size: 34, type: .marker, color: .mainColor),
        .init(image: .Pen.feltMenu, isSelected: false, opacity: 100, size: 34, type: .flomaster, color: .mainColor),
        .init(image: .Pen.easicMenu, isSelected: false, opacity: 100, size: 34, type: .erasse, color: .mainColor),
    ]
    
    var customViewModels: [BrushViewModel] = [
        .init(image: .Pen.pencilMenu, isSelected: false, opacity: 100, size: 34, type: .pencil, color: .mainColor),
        .init(image: .Pen.pencilMenu, isSelected: false, opacity: 100, size: 34, type: .pencil, color: .mainColor),
        .init(image: .Pen.pencilMenu, isSelected: false, opacity: 100, size: 34, type: .pencil, color: .mainColor),
        .init(image: .Pen.pencilMenu, isSelected: false, opacity: 100, size: 34, type: .pencil, color: .mainColor)
    ]
    
    // MARK: - Views
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.closeMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var colorPicker: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.applyFigmaShadow(color: UIColor(rgb: 0x000000), alpha: 0.1, x: 0, y: 0, blur: 3, spread: 0)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        appearance = Appearance()
        collectionManager = BrushCollectionManager()
        super.init(frame: frame)
        configureUI()
        injectCollection()
        
        collectionManager.displaySquareEditors(viewModels)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBrush(with viewModel: BrushViewModel) {
        if let index = viewModels.firstIndex(where: { $0 == viewModel }) {
            for (i, _) in viewModels.enumerated() {
                viewModels[i].isSelected = false
            }
            viewModels[index] = viewModel
            viewModels[index].isSelected = true
        }
        collectionManager.displaySquareEditors(viewModels)
    }
    
    func update(with color: UIColor) {
        colorPicker.backgroundColor = color
    }
    
    func setCustomBrush() {
        collectionManager.displaySquareEditors(customViewModels)
    }
}

// MARK: - private BrushListView

private extension BrushListView {
    func configureUI() {
        addViews()
        addConstraints()
        addTargets()
    }
    
    func injectCollection() {
        collectionManager.injectCollection(collectionView)
        collectionManager.injectDelegate(self)
    }
    
    func addViews() {
        [closeButton, colorPicker, collectionView].forEach({ self.addSubview($0) })
    }
    
    func addConstraints() {
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.top.equalToSuperview()
        }
        
        colorPicker.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalTo(closeButton.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.leading.equalTo(colorPicker.snp.trailing).offset(16)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func addTargets() {
        closeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.closeTapped()
        }), for: .touchUpInside)
        
        colorPicker.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.colorPickerTapped()
        }), for: .touchUpInside)
    }
}

extension BrushListView: BrushCollectionManagerDelegate {
    func didTapBrush(model: BrushViewModel) {
        delegate?.didTapBrush(with: model)
    }
}
