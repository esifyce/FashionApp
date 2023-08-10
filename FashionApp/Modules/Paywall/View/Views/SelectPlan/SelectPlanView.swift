//
//  SelectPlanView.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit
import SnapKit
import FrameBuilder

enum SelectSubscription {
    case weekly
    case lifetime
}

extension SelectPlanView {
    struct Appearance {
        let backgroundColor = UIColor(rgb: 0x1C1C1C).withAlphaComponent(0.6)
        let closeIcon = UIImage.PayWall.closeIcon.withRenderingMode(.alwaysOriginal)
        let blackColor = UIColor(rgb: 0x1C1C1C)
        let blueColor = UIColor(rgb: 0x1777F0)
        let whiteColor = UIColor(rgb: 0xFCFCFC)
        let grayColor = UIColor(rgb: 0x424242)
    }
}

class SelectPlanView: UIView {
    let appearance = Appearance()
    
    var selectedSubscription: SelectSubscription = .weekly
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.backgroundColor
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissapearAnimation)))
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(appearance.closeIcon, for: .normal)
        button.addTarget(self, action: #selector(dissapearAnimation), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select plan"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = appearance.blackColor
        
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = appearance.blueColor
        let attributedString = NSAttributedString(string: "Continue", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: appearance.whiteColor])
        button.setAttributedTitle(attributedString, for: .normal)
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let attributedString = NSAttributedString(string: "Cancel anytime", attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: appearance.grayColor])
        button.setAttributedTitle(attributedString, for: .normal)
        
        return button
    }()
    
    private lazy var weeklyView: CurrentPlanView = {
        let view = CurrentPlanView()
        view.update(text: "Weekly", price: "4,99 USD/week")
        view.customize(true)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:))))
        
        return view
    }()
    
    private lazy var lifeTimeView: CurrentPlanView = {
        let view = CurrentPlanView()
        view.update(text: "Lifetime", price: "99,99 USD")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:))))
        
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        [weeklyView, lifeTimeView, continueButton].toStackView(spacing: 16, distibution: .fillEqually, alignment: .fill)
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        appearAnimation()
        setupObserver()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRounded()
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(traitCollectionChanged(_:)),
                                               name: NSNotification.Name("traitCollectionDidChangeNotification"),
                                               object: nil)
    }
    
    @objc func traitCollectionChanged(_ notification: Notification) {
        if let traitCollection = notification.object as? UITraitCollection {
            print("hello")
        }
    }
}

private extension SelectPlanView {
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(backgroundView)
        addSubview(containerView)
        bringSubviewToFront(containerView)
        //insertSubview(containerView, aboveSubview: backgroundView)
        [closeButton, titleLabel, containerStack].forEach{ containerView.addSubview($0)}
    }
    
    func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
            make.bottom.equalToSuperview().offset(400)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.size.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.leading.equalToSuperview().offset(24)
        }

        containerStack.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().offset(-90)
        }
    }
    
    func makeRounded() {
        let path = UIBezierPath(roundedRect: containerView.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        containerView.layer.mask = maskLayer
    
        continueButton.layer.cornerRadius = 16
    }
    
    func appearAnimation() {
        self.containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    @objc func dissapearAnimation() {
        self.containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(400)
        }
        
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc func viewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let tappedView = gestureRecognizer.view else { return }
        weeklyView.customize(tappedView == weeklyView)
        lifeTimeView.customize(tappedView == lifeTimeView)
        selectedSubscription = tappedView == weeklyView ? .weekly : .lifetime
    }
}



