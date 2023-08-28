//
//  PencilView.swift
//  FashionApp
//
//  Created by Krasivo on 27.08.2023.
//

import UIKit
import SnapKit

protocol PencilViewDelegate: AnyObject {
    func didTapClose()
    func didTapApply(opacity: Int, size: Int)
}

extension PencilView {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    }
}

final class PencilView: UIView {
    // MARK: - Property
    
    private let appearance: Appearance
    weak var delegate: PencilViewDelegate?
    private var opacity: Int = 100
    private var size: Int = 34
    
    
    // MARK: - View
    
    private lazy var containterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.clipsToBounds = false
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.layer.applyFigmaShadow(color: UIColor(rgb: 0x000000), alpha: 0.1, x: 0, y: -6, blur: 20, spread: 0)
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage.PayWall.closeIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return closeButton
    }()
    
    private lazy var pencilTitle: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .blackColor
        label.text = "Pencil"
        return label
    }()
    
    private lazy var applyButton: UIButton = {
        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.mainColor, for: .normal)
        applyButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        
        return applyButton
    }()
    
    private lazy var opacitySlider: CustomSlider = {
        let slider = CustomSlider()
        slider.thumbImage = UIImage.Base.scrubber
        slider.gradientColor = .blue
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 100
        slider.layer.cornerRadius = 24
        slider.baseLayer.contents = UIImage.Base.pixel.cgImage
        slider.baseLayer.contentsGravity = .resizeAspectFill
        return slider
    }()
    
    private lazy var sizeSlider: CustomSlider = {
        let slider = CustomSlider()
        slider.minimumValue = 1
        slider.maximumValue = 68
        slider.value = 34
        slider.backgroundValueColor = .black
        return slider
    }()
    
    private lazy var opacityLabel: UILabel = {
        let label = UILabel()
        label.text = "OPACITY"
        label.textColor = UIColor.secondGrayColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
         return label
    }()
    
    private lazy var sizeLabel: UILabel = {
       let label = UILabel()
        label.text = "SIZE"
        label.textColor = UIColor.secondGrayColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var opacityPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "100%"
        return label
    }()
    
    private lazy var sizeFontLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "34 PT"
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        appearance = Appearance()
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: BrushViewModel) {
        pencilTitle.text = viewModel.type.rawValue
    }
    
    func updateColor(with color: UIColor) {
        opacitySlider.gradientColor = color
    }
 }

// MARK: - private PencilView

private extension PencilView {
    func setupUI() {
        self.backgroundColor = .clear
        addViews()
        addConstraints()
        addTargets()
    }
    
    func addViews() {
        self.addSubview(containterView)
        [closeButton, pencilTitle, applyButton,
         opacitySlider, sizeSlider,
         opacityPercentLabel, opacityLabel,
         sizeLabel, sizeFontLabel].forEach({ containterView.addSubview($0) })
    }
    
    func addConstraints() {
        containterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(appearance.isIpad ? 24 : 16)
        }
        
        pencilTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(appearance.isIpad ? -24 : -16)
        }
        
        opacityLabel.snp.makeConstraints { make in
            make.leading.equalTo(opacitySlider)
            make.bottom.equalTo(opacitySlider.snp.top).offset(-5)
        }
        
        opacityPercentLabel.snp.makeConstraints { make in
            make.trailing.equalTo(opacitySlider)
            make.bottom.equalTo(opacitySlider.snp.top).offset(-5)
        }
        
        opacitySlider.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(167)
            make.top.equalTo(pencilTitle.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
        }
        
        sizeSlider.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(167)
            make.top.equalTo(pencilTitle.snp.bottom).offset(50)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.leading.equalTo(sizeSlider)
            make.bottom.equalTo(sizeSlider.snp.top).offset(-5)
        }
        
        sizeFontLabel.snp.makeConstraints { make in
            make.trailing.equalTo(sizeSlider)
            make.bottom.equalTo(sizeSlider.snp.top).offset(-5)
        }
    }
    
    func addTargets() {
        closeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapClose()
        }), for: .touchUpInside)
        
        applyButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapApply(opacity: self?.opacity ?? 100, size: self?.size ?? 34)
        }), for: .touchUpInside)
        
        opacitySlider.addTarget(self, action: #selector(opacityValueChanged(_:)), for: .valueChanged)
        sizeSlider.addTarget(self, action: #selector(sizeValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func opacityValueChanged(_ slider: UISlider) {
        let value = Int(slider.value)
        opacityPercentLabel.text = "\(value)%"
        opacity = value
    }
    
    @objc func sizeValueChanged(_ slider: UISlider) {
        let value = Int(slider.value)
        sizeFontLabel.text = "\(value) PT"
        size = value
    }
}
