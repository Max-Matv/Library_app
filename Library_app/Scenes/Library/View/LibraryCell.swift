//
//  LibraryCell.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import UIKit

class LibraryCell: UICollectionViewCell {
    
    //MARK: - Views
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    
    private lazy var year: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK: - Setup cell
    func setupCell(book: Work, covers: [String:Data]) {
        title.text = book.title
        year.text = String(book.firstPublishYear)
        if let cover = covers[book.title] {
            image.image = UIImage(data: cover)
        }
    }
    
    //MARK: - Setup
    private func setup() {
        backgroundColor = .brown
        layer.cornerRadius = 20
        addSubview(image)
        addSubview(title)
        addSubview(year)
        setupImage()
        setupTitle()
        setupYear()
    }
    
    //MARK: - setup image
    private func setupImage() {
        image.image = UIImage(systemName: "books.vertical")
        image.tintColor = .white
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1),
            image.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    //MARK: - Setup title
    private func setupTitle() {
        title.text = "some text"
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    //MARK: - Setup year
    private func setupYear() {
        year.text = "1996"
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5),
            year.leadingAnchor.constraint(equalTo: leadingAnchor),
            year.trailingAnchor.constraint(equalTo: trailingAnchor),
            year.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
