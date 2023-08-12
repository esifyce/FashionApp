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
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
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
        scrollView.showsVerticalScrollIndicator = false
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
        makeLabel(font: UIFont.systemFont(ofSize: 28, weight: .bold),
                  text: "Try 3 days free, then US $24,99 per year",
                  alignment: .left,
                  textColor: appearance.blackColor)
    }()
    
    private lazy var menuView: MenuView = {
        MenuView()
    }()
    
    private lazy var trialLabel: UILabel = {
        makeLabel(font: UIFont.systemFont(ofSize: 28, weight: .semibold),
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
    
    let descriptionView = DescriptionView()
    
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
        label.attributedText = underlineAttrString
        label.isUserInteractionEnabled = true
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

    private lazy var trialView: UIView = {
        let trialView = TrialView()
        trialView.seeOtherCallBack = { [weak self] in
            self?.presenter.seeOtherTapped()
        }
        return trialView
    }()
    
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
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyShadow()
        setupLayout(with: traitCollection)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        adjustContentOffsetForOrientation()
    }
    
    func adjustContentOffsetForOrientation() {
        let currentOffset = scrollView.contentOffset
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.bounds.size.height
        
        // Calculate the new content offset based on the orientation change
        let newYOffset = min(0, max(contentHeight - frameHeight, currentOffset.y))

        scrollView.contentOffset = CGPoint(x: currentOffset.x, y: newYOffset)
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
    func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        view.addSubview(trialView)
        scrollView.addSubview(contentView)
        [titleLabel, imageView, secondLabel, trialLabel, menuView, priceView, lineView, descriptionView, upgradeImageView, highStackView, alreadyLabel, restoreButton].forEach({contentView.addSubview($0)})
        
        
        closeButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
    func setupLayout(with traitCollection: UITraitCollection) {
        
        var contentWidth = view.frame.width
        var xPoint: CGFloat = 0
        
        // check if ipad
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            if UIApplication.shared.isLandscape {
                contentWidth = view.frame.width * 0.4
                xPoint = view.frame.width * 0.3
            } else {
                contentWidth = view.frame.width * 0.5
                xPoint = view.frame.width * 0.25
            }
        }
        
        closeButton.buildFrame(
            FrameBuilder()
                .top(equalTo: .top, ofView: view, withOffset: 30)
                .trailing(equalTo: .trailing, ofView: view, withOffset: 46)
                .width(30)
                .height(30)
        )
        
        scrollView.buildFrame(
            FrameBuilder()
                .x(xPoint)
                .top(equalTo: .bottom, ofView: closeButton, withOffset: 19)
                .width(contentWidth)
                .height(view.frame.size.height - 257)
        )
        
        contentView.buildFrame(
            FrameBuilder()
                .top(equalTo: .top, ofView: scrollView)
                .height(scrollView.contentSize.height)
                .width(scrollView.frame.width)
        )
        
        titleLabel.buildFrame(
            FrameBuilder()
                .width(appearance.isIpad ? contentWidth - 20 : contentWidth - 59)
                .top(equalTo: .top, ofView: contentView, withOffset: 8)
                .centerXToCenterX(ofView: contentView)
                .height(82)
        )
        
        imageView.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: titleLabel, withOffset: 16)
                .height(260)
                .width(contentWidth)
        )
        
        secondLabel.buildFrame(
            FrameBuilder()
                .x(30)
                .top(equalTo: .bottom, ofView: imageView, withOffset: 16)
                .width(contentWidth - 64)
                .height(84)
        )
        
        menuView.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: secondLabel, withOffset: 24)
                .width(contentWidth - 64)
                .height(184)
        )
        
        trialLabel.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: menuView, withOffset: 48)
                .width(contentWidth - 64)
                .centerXToCenterX(ofView: contentView)
                .height(42)
        )

        priceView.buildFrame(
            FrameBuilder()
                .width(contentWidth - 64)
                .top(equalTo: .bottom, ofView: trialLabel, withOffset: 48)
                .centerXToCenterX(ofView: contentView)
                .height(66)
        )
        
        lineView.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: priceView, withOffset: 48)
                .width(32)
                .height(242)
        )
        
        descriptionView.buildFrame(
            FrameBuilder()
                .x(64)
                .top(equalTo: .bottom, ofView: priceView, withOffset: 48)
                .width(contentWidth - 50)
                .height(242)
        )
        
        upgradeImageView.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: lineView, withOffset: 48)
                .width(184)
                .centerXToCenterX(ofView: contentView)
                .height(40)
        )
        
        highStackView.buildFrame(
             FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: upgradeImageView, withOffset: 32)
                .width(contentWidth - 64)
                .height(172)
        )
        
        alreadyLabel.buildFrame(
            FrameBuilder()
                .x(32)
                .top(equalTo: .bottom, ofView: highStackView, withOffset: 24)
                .width(contentWidth - 64)
                .height(24)
        )
        
        restoreButton.buildFrame(
            FrameBuilder()
                .x(contentWidth - 126)
                .top(equalTo: .bottom, ofView: highStackView, withOffset: 24)
                .width(94)
                .height(24)
        )
        
        trialView.buildFrame(
            FrameBuilder()
                .x(0)
                .y(view.frame.height - 178)
                .width(view.frame.width)
                .height(178)
        )
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 1540)
        adjustContentOffsetForOrientation()
    }
}

private extension PaywallViewController {
    func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func applyShadow() {
        trialView.layer.applyFigmaShadow(color: UIColor(rgb:0x031833), alpha: 0.12, x: 0, y: -8, blur: 32, spread: 0)
    }
    
    @objc func privacyLabelTapped(gesture: UITapGestureRecognizer) {
        let text = appearance.privacyText
        let range1 = (text as NSString).range(of: "Privacy Policy")
        if gesture.didTapAttributedTextInLabel(label: privacyLabel, inRange: range1) {
            print("Privacy Policy")
        }
    }
}
