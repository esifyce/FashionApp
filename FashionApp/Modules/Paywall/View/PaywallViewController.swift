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
        let clockwise: UIImage = UIImage.PayWall.clockwise
        let upgradeList: UIImage = UIImage.PayWall.upgradeList
        let blackColor: UIColor = UIColor(rgb: 0x50505)
        let grayColor: UIColor = UIColor(rgb: 0x66676B)
        let blueColor: UIColor = UIColor(rgb: 0x1777F0)
        let shadowColor: UIColor = UIColor(rgb: 0x031833).withAlphaComponent(0.12)
        let privacyText: String = "Please read our Privacy Policy and Terms of Use before joining"
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
    
    private lazy var upgradeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = appearance.upgradeList
        iv.contentMode = .scaleAspectFill
        
        return iv
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
        let text = appearance.privacyText
        let underlineAttrString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Privacy Policy")
        underlineAttrString.addAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .semibold), .underlineStyle: NSUnderlineStyle.single.rawValue], range: range1)
        
        let range2 = (text as NSString).range(of: "Terms of Use")
        underlineAttrString.addAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .semibold), .underlineStyle: NSUnderlineStyle.single.rawValue], range: range2)
        
        let label = makeLabel(font: UIFont.systemFont(ofSize: 13, weight: .medium),
                  text: text,
                  textColor: appearance.grayColor)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        underlineAttrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, underlineAttrString.length))
        label.attributedText = underlineAttrString
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyLabelTapped(gesture:))))
        return label
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
        button.setImage(appearance.clockwise, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: " Restore", attributes: [.font : UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: appearance.blueColor]), for: .normal)
        return button
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
        contentView.addSubview(upgradeImageView)
        contentView.addSubview(highStackView)
        contentView.addSubview(alreadyLabel)
        contentView.addSubview(restoreButton)
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
        
        upgradeImageView.buildFrame(
            FrameBuilder()
                .centerXToCenterX(ofView: view, offset: -92)
                .top(equalTo: .bottom, ofView: lineView, withOffset: 48)
                .width(184)
                .height(40)
        )
        
        highStackView.buildFrame(
             FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: upgradeImageView, withOffset: 32)
                .width(contentView.frame.width - 64)
                .height(172)
        )
        
        alreadyLabel.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: highStackView, withOffset: 24)
                .width(contentView.frame.width - 64)
                .height(24)
        )
        
        restoreButton.buildFrame(
            FrameBuilder()
                .x(contentView.frame.width - 126)
                .top(equalTo: .bottom, ofView: highStackView, withOffset: 24)
                .width(94)
                .height(24)
        )
        
        trialView.buildFrame(
            FrameBuilder()
                .x(0)
                .top(equalTo: .bottom, ofView: alreadyLabel, withOffset: 24)
                .width(contentView.frame.width)
                .height(178)
        )
    }
    
    func applyShadow() {
        trialView.layer.applyFigmaShadow(color: UIColor(rgb:0x031833), alpha: 0.12, x: 0, y: -8, blur: 32, spread: 0)
    }
}

private extension PaywallViewController {
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func privacyLabelTapped(gesture: UITapGestureRecognizer) {
        let text = appearance.privacyText
        let range1 = (text as NSString).range(of: "Privacy Policy")
        if gesture.didTapAttributedTextInLabel(label: privacyLabel, inRange: range1) {
            print("Privacy Policy")
        }
    }
}
