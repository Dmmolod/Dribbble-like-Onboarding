//
//  OnboardingSlideView.swift
//  Onboarding_DribbbleLike
//
//  Created by Дмитрий Молодецкий on 06.09.2022.
//

import Foundation
import UIKit

class OnboardingSlideView: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.tintColor = .tintColor
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.tintColor = .tintColor
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    init(with slide: Slide) {
        super.init(frame: .zero)
        backgroundColor = .clear
        titleLabel.text = slide.title
        contentLabel.text = slide.content
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) { nil }
    
    private func addSubviews() {
        addSubview(stackView)
        for subview in [titleLabel, contentLabel] { stackView.addArrangedSubview(subview) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -30)
        ])
    }
}
