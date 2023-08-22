//
//  LayerCustomizeView.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit
import SnapKit

enum LayerAction {
    case hide
    case lock
    case duplicate
    case mergePrevious
    case mergeAll
    case delete
}

extension LayerCustomizeView {
    struct Appearance {
        let closeImage = UIImage.PayWall.closeIcon
    }
}

final class LayerCustomizeView: UIView {
    let appearance = Appearance()
    private var actions: [LayerAction] = []
    var layerName: String = ""
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.text = "Layer Number One"
        tf.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var tapToRenameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Tap to rename"
        
        return label
    }()
    
    private lazy var renameStackView: UIStackView = {
        [nameTextField, tapToRenameLabel].toStackView(spacing: 2, distibution: .fill, alignment: .leading)
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(appearance.closeImage, for: .normal)
        return button
    }()
    
    private lazy var titleContainerView: UIView = {
        UIView()
    }()
    
    private lazy var opacityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondGrayColor
        label.text = "OPACITY"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var slider: CustomSlider = {
        let slider = CustomSlider()
        slider.thumbImage = UIImage.Base.scrubber
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.gradientColor = UIColor.mainColor
        slider.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var percentLabel: PercentLabel = {
        let label = PercentLabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.backgroundColor = UIColor.lightGrayColor
        label.text = "0%"
        return label
    }()
    
    private lazy var sliderContainerView: UIView = {
        UIView()
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.thirdGrayColor
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var hideActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.hide.withRenderingMode(.alwaysTemplate), text: "Hide") {
            self.actionTapped(.hide)
        }
        
        return view
    }()
    
    private lazy var lockActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.lock.withRenderingMode(.alwaysTemplate), text: "Lock") {
            self.actionTapped(.lock)
        }
        
        return view
    }()
    
    private lazy var duplicateActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.duplicate.withRenderingMode(.alwaysTemplate), text: "Duplicate") {
            self.actionTapped(.duplicate)
        }
        
        return view
    }()
    
    private lazy var mergePreviousActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.mergePrevious.withRenderingMode(.alwaysTemplate), text: "Merge with previous") {
            self.actionTapped(.mergePrevious)
        }
        
        return view
    }()
    
    private lazy var mergeAllActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.mergeAll.withRenderingMode(.alwaysTemplate), text: "Merge all layers") {
            self.actionTapped(.mergeAll)
        }
        
        return view
    }()
    
    private lazy var deleteActionView: LayerActionView = {
        let view = LayerActionView()
        view.setup(image: UIImage.LayerAction.delete.withRenderingMode(.alwaysTemplate), text: "Delete") {
            self.actionTapped(.delete)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionTapped(_ action: LayerAction) {
        if actions.contains(action) {
            actions.removeAll { $0 == action }
        } else {
            actions.append(action)
        }
        print(actions)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        percentLabel.layer.cornerRadius = 13
        percentLabel.layer.masksToBounds = true
    }
}

private extension LayerCustomizeView {
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(titleContainerView)
        [renameStackView, closeButton].forEach({titleContainerView.addSubview($0)})
        addSubview(sliderContainerView)
        [opacityLabel, slider, percentLabel].forEach({sliderContainerView.addSubview($0)})
        [separator, hideActionView, lockActionView, duplicateActionView, mergePreviousActionView, mergeAllActionView, deleteActionView].forEach({ addSubview($0)})
    }
    
    func makeConstraints() {
        titleContainerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        renameStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(closeButton.snp.leading).offset(-16)
            make.height.equalTo(38)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.trailing.equalToSuperview()
            make.size.equalTo(30)
        }
        
        sliderContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleContainerView.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(59)
        }

        opacityLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(77)
        }

        slider.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(percentLabel.snp.leading).offset(-11)
            make.height.equalTo(36)
            make.bottom.equalToSuperview()
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(sliderContainerView.snp.bottom).offset(23)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }

        hideActionView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        lockActionView.snp.makeConstraints { make in
            make.top.equalTo(hideActionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        duplicateActionView.snp.makeConstraints { make in
            make.top.equalTo(lockActionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        mergePreviousActionView.snp.makeConstraints { make in
            make.top.equalTo(duplicateActionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        mergeAllActionView.snp.makeConstraints { make in
            make.top.equalTo(mergePreviousActionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        deleteActionView.snp.makeConstraints { make in
            make.top.equalTo(mergeAllActionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(55)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension LayerCustomizeView {
    @objc func valueChanged(_ slider: UISlider) {
        percentLabel.text = "\(Int(slider.value))%"
    }
}

extension LayerCustomizeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        layerName = text
        print(layerName)
        textField.resignFirstResponder()
        return true
    }
}