//
//  RaitingView.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import UIKit

class RaitingView: UIView {
    
    //MARK: - Properties
    private var raiting: Double = 0 {
        didSet {
            for i in 0..<stackView.arrangedSubviews.count {
                if let imageView = stackView.arrangedSubviews[i] as? UIImageView {
                    let raitingValue = Double(i + 1)
                    if raitingValue <= raiting {
                        imageView.image = UIImage(systemName: "star.fill")
                    } else {
                        imageView.image = UIImage(systemName: "star")
                    }
                }
            }
        }
    }
    
    //MARK: - Views
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 15
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        for _ in 1...5 {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(systemName: "star")
            image.tintColor = .yellow
            stackView.addArrangedSubview(image)
            image.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.0/1.0).isActive = true
        }
    }
    
    //MARK: - Set raiting
    func setRaiting(_ raiting: Double) {
        self.raiting = raiting
    }
}
