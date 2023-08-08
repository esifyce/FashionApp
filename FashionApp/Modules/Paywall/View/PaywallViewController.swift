//
//  PaywallViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import FrameBuilder

extension PaywallViewController {
    struct Appearance {
        let closeImage: UIImage = UIImage.PayWall.closeIcon
        let logoImage: UIImage = UIImage.PayWall.logo
        let blackColor: UIColor = UIColor(rgb: 0x50505)
        let grayColor: UIColor = UIColor(rgb: 0x66676B)
        let blueColor: UIColor = UIColor(rgb: 0x1777F0)
        let shadowColor: UIColor = UIColor(rgb: 0x031833).withAlphaComponent(0.12)
    }
}

final class PaywallViewController: BaseViewController {
    // MARK: - Property
    let appearance = Appearance()
    var presenter: PaywallPresenterInput
    
    // MARK: - Views
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(appearance.closeImage, for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = appearance.logoImage
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()

    private lazy var titleLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 34, weight: .bold),
                         text: "Boost your fashion design with Premium",
                  textColor: appearance.blackColor)
    }()
    
    private lazy var secondLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 28, weight: .init(600)),
                  text: "Try 3 days free, then US $24,99 per year",
                  alignment: .left,
                  textColor: appearance.blackColor)
    }()
    
    private lazy var menuView: MenuView = {
        MenuView()
    }()
    
    private lazy var trialLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 28, weight: .init(600)),
                  text: "How your trial works",
                  alignment: .left,
                  textColor: appearance.blackColor)
    }()
    
    private lazy var priceView: PriceView = {
        PriceView()
    }()
    
    private lazy var lineView: CustomLineView = {
        CustomLineView()
    }()
    
    private lazy var highQualityLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 18, weight: .medium),
                  text: "High quality templates, brushes, and tips our team adds every week means that your illustrations are constantly improving.",
                  textColor: appearance.blackColor)
    }()
    
    private lazy var privacyLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 13, weight: .regular),
                  text: "Please read our Privacy Policy and Terms of Use before joining",
                  textColor: appearance.grayColor)
    }()
    
    private lazy var highStackView: UIStackView = {
        [highQualityLabel, privacyLabel].toStackView(spacing: 32, distibution: .fillProportionally, alignment: .fill)
    }()
    
    private lazy var alreadyLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                  text: "Already a member?",
                  alignment: .left,
                  textColor: appearance.blackColor)
    }()
    
    private lazy var restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "􀅉 restore", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .regular), .foregroundColor: appearance.blueColor]), for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    private lazy var alreadyStackView: UIStackView = {
        [alreadyLabel, restoreButton].toStackView(axis: .horizontal, spacing: 20, distibution: .fillProportionally, alignment: .leading)
    }()
    
    let trialView = TrialView()
    
    init(presenter: PaywallPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        defer { presenter.viewDidLoad() }
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
}

// MARK: - PaywallViewControllerInput
extension PaywallViewController: PaywallViewControllerInput {
    func makeLabel(font: UIFont,
                   text: String,
                   alignment: NSTextAlignment = .center,
                   textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.text = text
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.backgroundColor = .clear
        
        return label
    }
}

// MARK: - fileprivate PaywallViewController
fileprivate extension PaywallViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
        applyShadow()
    }
    
    func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1800)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(secondLabel)
        contentView.addSubview(trialLabel)
        contentView.addSubview(menuView)
        contentView.addSubview(priceView)
        contentView.addSubview(lineView)
        contentView.addSubview(highStackView)
        contentView.addSubview(alreadyStackView)
        contentView.addSubview(trialView)
    }
    
    func setConstraints() {
        closeButton.buildFrame(
            FrameBuilder()
                .top(equalTo: .top, ofView: view, withOffset: 19)
                .trailing(equalTo: .trailing, ofView: view, withOffset: 32)
                .width(30)
                .height(30)
        )
        
        scrollView.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: closeButton, withOffset: 19)
                .width(view.frame.width)
                .height(view.frame.height)
        )
        
        contentView.buildFrame(
            FrameBuilder()
                .top(equalTo: .top, ofView: scrollView)
                .height(scrollView.contentSize.height)
                .width(scrollView.frame.width)
        )
        
        titleLabel.buildFrame(
            FrameBuilder()
                .x(30)
                .top(equalTo: .top, ofView: contentView, withOffset: 8)
                .width(contentView.frame.width - 59)
                .height(82)
        )
        
        imageView.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: titleLabel, withOffset: 16)
                .height(260)
                .width(contentView.frame.width)
        )
        
        secondLabel.buildFrame(
            FrameBuilder()
                .x(30)
                .top(equalTo: .bottom, ofView: imageView, withOffset: 16)
                .width(contentView.frame.width - 64)
                .height(84)
        )
        
        menuView.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: secondLabel, withOffset: 24)
                .width(contentView.frame.width - 64)
                .height(184)
        )
        
        trialLabel.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: menuView, withOffset: 48)
                .width(contentView.frame.width - 64)
                .height(42)
        )

        priceView.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: trialLabel, withOffset: 48)
                .width(contentView.frame.width - 64)
                .height(66)
        )
        
        lineView.buildFrame(
            FrameBuilder()
                .x(40)
                .top(equalTo: .bottom, ofView: priceView, withOffset: 48)
                .width(16)
                .height(242)
        )
        
        highQualityLabel.buildFrame(
             FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: lineView, withOffset: 40)
                .width(contentView.frame.width - 64)
                .height(96)
        )
        
        highStackView.buildFrame(
             FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: highQualityLabel, withOffset: 32)
                .width(contentView.frame.width - 64)
                .height(172)
        )
        
        alreadyStackView.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: highStackView, withOffset: 24)
                .width(contentView.frame.width - 64)
                .height(24)
        )
        
        trialView.buildFrame(
            FrameBuilder()
                .x(0)
                .top(equalTo: .bottom, ofView: alreadyStackView, withOffset: 24)
                .width(contentView.frame.width)
                .height(178)
        )
        
//        closeButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-16)
//            make.top.equalToSuperview().offset(16)
//            make.size.equalTo(30)
//        }
    }
    
    func applyShadow() {
        trialView.layer.shadowColor = UIColor.black.cgColor
        trialView.layer.shadowOpacity = 0.5
        trialView.layer.shadowOffset = CGSize(width: 0, height: 8)
        trialView.layer.shadowRadius = 5.0
        trialView.layer.cornerRadius = 0.0
        trialView.clipsToBounds = false
    }
}

private extension PaywallViewController {
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
}
