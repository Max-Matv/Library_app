//
//  AlertView.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import UIKit

class AlertView: UIView {

    //MARK: - Property
    weak var delegate: AlertViewProtocol?
    
    //MARK: - Views
    private lazy var message: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 30)
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - Setup view
    private func setup() {
        backgroundColor = .clear
        addSubview(message)
        addSubview(button)
        setupMessage()
        setupButton()
    }
    
    //MARK: - Setup message label
    private func setupMessage() {
        message.text = "failed to load data"
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: topAnchor),
            message.leadingAnchor.constraint(equalTo: leadingAnchor),
            message.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    //MARK: - Setup button
    private func setupButton() {
        button.backgroundColor = UIColor(named: "background")
        button.layer.cornerRadius = 20
        button.setTitle("try again", for: .normal)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalTo: message.widthAnchor, multiplier: 0.5)
        ])
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc
    private func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed()
    }
}
