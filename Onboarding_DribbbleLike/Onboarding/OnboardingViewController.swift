//
//  OnboardingViewController.swift
//  Onboarding_DribbbleLike
//
//  Created by Дмитрий Молодецкий on 06.09.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var onboardingSlideViews = [OnboardingSlideView]()
    private var slides: [Slide] = [
        Slide(title: "This is the best onboarding ever!",
              content: "This onboarding is made of beautiful slides."),
        
        Slide(title: "When you slide, the background moves!",
              content: "Isn't that the coolest thing ever?"),
        
        Slide(title: "The title shrinks as you slide away...",
              content: "...and gets bigger as it slides in!"),
        
        Slide(title: "Follow the tutorial to see how it's done!",
              content: "Don't worry, it's easier than you think."),
        
        Slide(title: "Press the button below...",
              content: "...and make the magic happen!")
    ]
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = .background
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let onboardingScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.automaticallyAdjustsScrollIndicatorInsets = false
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = true
        scroll.isDirectionalLockEnabled = true
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    private let onboardingPageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let onboardingContinueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.alpha = 0
        button.backgroundColor = .tintColor
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        view.tintColor = .tintColor
        
        addSubviews()
        setupConstraints()
        
        onboardingScrollView.contentSize = CGSize(width: onboardingScrollView.contentSize.width,
                                                  height: 0)
        onboardingContinueButton.layer.cornerRadius = 20
        setupBackgrounImageView()
        addSlides()
        
        onboardingScrollView.delegate = self
        onboardingPageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
    }
    
    private func addSubviews() {
        for subview in [backgroundImageView, onboardingScrollView, onboardingPageControl, onboardingContinueButton] { view.addSubview(subview) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            onboardingScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            onboardingScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            onboardingPageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            onboardingPageControl.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            onboardingPageControl.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            onboardingContinueButton.widthAnchor.constraint(equalToConstant: 40),
            onboardingContinueButton.heightAnchor.constraint(equalToConstant: 40),
            onboardingContinueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            onboardingContinueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    private func setupBackgrounImageView() {
        let viewHeight = view.frame.size.height
        let imageWidth = viewHeight * 1.4
        let padding: CGFloat = 10
        backgroundImageView.alpha = 0.5
        backgroundImageView.frame = CGRect(x: 0, y: -padding,
                                           width: imageWidth, height: viewHeight+padding*2)
    }
    
    private func addSlides() {
        for slide in slides {
            let slideView = OnboardingSlideView(with: slide)
            onboardingSlideViews.append(slideView)
        }
        for slideViewIndex in onboardingSlideViews.indices {
            onboardingScrollView.addSubview(onboardingSlideViews[slideViewIndex])
            onboardingSlideViews[slideViewIndex].frame = CGRect(
                x: slideViewIndex == 0 ? 0 : onboardingSlideViews[slideViewIndex-1].frame.maxX,
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            if slideViewIndex > 0 {
                onboardingSlideViews[slideViewIndex].stackView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }
        }
        guard let lastSlideView = onboardingSlideViews.last else { return }
        onboardingScrollView.contentSize.width = lastSlideView.frame.maxX
        onboardingPageControl.numberOfPages = slides.count
    }
    
    @objc private func pageChanged() {
        print(onboardingPageControl.currentPage)
        let newOffset = CGPoint(x: onboardingScrollView.frame.width * CGFloat(onboardingPageControl.currentPage),
                             y: 0)
        onboardingScrollView.setContentOffset(newOffset, animated: true)
        updateContinueButtonState()
    }
    
    private func setIndiactorForCurrentPage()  {
        let page = Int(onboardingScrollView.contentOffset.x/onboardingScrollView.frame.width)
        onboardingPageControl.currentPage = page
        updateContinueButtonState()
    }
    
    private func updateContinueButtonState() {
        if onboardingPageControl.currentPage == slides.count - 1 {
            self.onboardingContinueButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.onboardingContinueButton.alpha = 1
            }
        } else {
            self.onboardingContinueButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.onboardingContinueButton.alpha = 0
            }
        }
    }
    
    var previosLoc: CGFloat = 0
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isOffsetGreaterThanZero = scrollView.contentOffset.x > 0
        let isOffsetLessThanMaxX = scrollView.contentOffset.x < (scrollView.contentSize.width - view.frame.width)
        
        if isOffsetGreaterThanZero && isOffsetLessThanMaxX {
            backgroundImageView.frame.origin.x = -scrollView.contentOffset.x/3
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
}

