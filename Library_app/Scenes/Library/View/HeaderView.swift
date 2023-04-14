//
//  HeaderView.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import UIKit

class HeaderView: UIView {
    //MARK: - Views
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 34)
        view.textColor = .white
        view.text = "Trending Books"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Properties
    private let cornerRadius: Double = 20
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        UIColor(named: "background")?.setFill()
        path.fill()
    }
    
    //MARK: - Setup title
    private func setupTitle() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    //MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear
        addSubview(title)
        setupTitle()
    }
    //MARK: - Set title
    func setTitle(_ title: String) {
        self.title.text = title
    }

}
