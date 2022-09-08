//
//  OnboardingViewController.swift
//  Onboarding_DribbbleLike
//
//  Created by Дмитрий Молодецкий on 06.09.2022.
//

import UIKit
import SafariServices

class OnboardingViewController: UIViewController {
    
    private var onboardingView = OnboardingView()
    
    private lazy var onboardingSlideViews: [OnboardingSlideView] = []
    private var slides: [Slide]
    
    init(with slides: [Slide]) {
        self.slides = slides
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(onboardingView)
        setupOnboardingView()
        onboardingView.setupBackgroundImageWith(viewHeight: view.frame.size.height)
        
        addSlides()
        
        onboardingView.scrollView.delegate = self
        onboardingView.pageControllAddTarget(self, action: #selector(pageChanged), for: .valueChanged)
        onboardingView.continueButtonAddTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
    
    private func setupOnboardingView() {
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func addSlides() {
        for slideIndex in slides.indices {
            let slideView = OnboardingSlideView(with: slides[slideIndex])
            onboardingSlideViews.append(slideView)
            
            onboardingView.scrollView.addSubview(slideView)
            slideView.frame = CGRect(
                x: slideIndex == 0 ? 0 : onboardingSlideViews[slideIndex-1].frame.maxX,
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
        }
        
        guard let lastSlideView = onboardingSlideViews.last else { return }
        onboardingView.scrollView.contentSize.width = lastSlideView.frame.maxX
        onboardingView.numberOfPages = slides.count
    }
    
    @objc private func continueButtonPressed() {
        guard let url = URL(string: "https://github.com/Dmmolod/Dribbble-like-Onboarding") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        
        present(safariVC, animated: true)
    }
    
    @objc private func pageChanged() {
        let newOffset = CGPoint(x: onboardingView.scrollView.frame.width * CGFloat(onboardingView.currentPage),
                                y: 0)
        onboardingView.scrollView.setContentOffset(newOffset, animated: true)
    }
    
    private func setIndiactorForCurrentPage()  {
        let page = Int(onboardingView.scrollView.contentOffset.x/onboardingView.scrollView.frame.width)
        onboardingView.currentPage = page
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x,
            scrollWidth = scrollView.frame.width,
            currentPage = Int(offsetX/scrollWidth)
        
        let canMoveBackground = offsetX > 0 && offsetX < (scrollView.contentSize.width - scrollWidth)
        
        if canMoveBackground { onboardingView.backgroundImageFrame.origin.x = -offsetX / 3 }
        
        let originalScale: CGFloat = 1, minScale: CGFloat = 0.3
        
        let realOffset = offsetX - scrollWidth * CGFloat(currentPage)
        let isRightSwipe = realOffset < 0
        
        let swipedPage = isRightSwipe ? currentPage - 1 : currentPage + 1
        
        onboardingSlideViews[currentPage].transformScaleWith(startValue: originalScale, endValue: minScale,
                                                             startPostion: 1, endPosition: scrollWidth, currentPosition: realOffset)
        if swipedPage < onboardingSlideViews.count && swipedPage >= 0 {
            onboardingSlideViews[swipedPage].transformScaleWith(startValue: minScale, endValue: originalScale,
                                                                startPostion: 1, endPosition: scrollWidth, currentPosition: realOffset)
        }
        let isLastPage = currentPage == onboardingView.numberOfPages - 1
        onboardingView.updateContinueButtonState(needShow: isLastPage)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
}

