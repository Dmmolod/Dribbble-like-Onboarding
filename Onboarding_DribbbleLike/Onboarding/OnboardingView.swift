//
//  OnboardingView.swift
//  Onboarding_DribbbleLike
//
//  Created by Дмитрий Молодецкий on 07.09.2022.
//

import Foundation
import UIKit

class OnboardingView: UIView {
    
    var currentPage: Int {
        get { pageControl.currentPage }
        set { pageControl.currentPage = newValue }
    }
    
    var numberOfPages: Int {
        get { pageControl.numberOfPages }
        set { pageControl.numberOfPages = newValue }
    }
    
    var backgroundImageFrame: CGRect {
        get { backgroundImageView.frame }
        set { backgroundImageView.frame = newValue }
    }
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.automaticallyAdjustsScrollIndicatorInsets = false
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = true
        scroll.isDirectionalLockEnabled = true
        scroll.isPagingEnabled = true
        return scroll
    }()
            
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = .background
        imageView.clipsToBounds = true
        imageView.alpha = 0.5
        return imageView
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.alpha = 0
        button.backgroundColor = .tintColor
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .backgroundColor
        tintColor = .tintColor
        
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width,
                                                  height: 0)
        
        let viewHeight = frame.size.height
        let imageWidth = viewHeight * 1.4
        let padding: CGFloat = 10
    
        backgroundImageView.frame = CGRect(x: 0, y: -padding,
                                           width: imageWidth, height: viewHeight+padding*2)
    }
    
    private func addSubviews() {
        for subview in [backgroundImageView, scrollView, pageControl, continueButton] { addSubview(subview) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            pageControl.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalToConstant: 40),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    func continueButtonAddTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        continueButton.addTarget(target, action: action, for: event)
    }
    
    func pageControllAddTarget(_ target: Any?, action: Selector, for event: UIControl.Event ) {
        pageControl.addTarget(target, action: action, for: event)
    }
    
    func updateContinueButtonState(needShow: Bool) {
        if needShow {
            self.continueButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.continueButton.alpha = 1
            }
        } else {
            self.continueButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.continueButton.alpha = 0
            }
        }
    }
}