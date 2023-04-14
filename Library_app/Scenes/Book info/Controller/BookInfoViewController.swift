//
//  BookInfoViewController.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import UIKit

protocol BookViewControllerProtocol: AnyObject {
    func setupCover(cover: Data)
    func addRaiting(raiting: Double)
    func addDescription(description: String)
}

class BookInfoViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: BookInfoViewModel?
    
    //MARK: - Views
    private lazy var header: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var raitingView: RaitingView = {
        let view = RaitingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var coverView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var textField: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHeaderView()
        setupCoverView()
        setupRaitingView()
        setupTextView()
        viewModel?.setupCover()
        viewModel?.sendBookRequest()
        viewModel?.sendRequest()
    }
    
    //MARK: - Setup header view
    private func setupHeaderView() {
        view.addSubview(header)
        header.setTitle((viewModel?.book.title)!)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
        ])
    }
    //MARK: - Setup cover view
    private func setupCoverView() {
        view.addSubview(coverView)
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            coverView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            coverView.widthAnchor.constraint(equalTo: coverView.heightAnchor, multiplier: 1),
        ])
    }
    
    //MARK: - Setup raiting view
    private func setupRaitingView() {
        view.addSubview(raitingView)
        NSLayoutConstraint.activate([
            raitingView.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant: 5),
            raitingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            raitingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            raitingView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    //MARK: Setup text view
    private func setupTextView() {
        view.addSubview(textField)
        textField.backgroundColor = .clear
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: raitingView.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension BookInfoViewController: BookViewControllerProtocol {
    func setupCover(cover: Data) {
        DispatchQueue.main.async {
            self.coverView.image = UIImage(data: cover)
        }
    }
    func addRaiting(raiting: Double) {
        raitingView.setRaiting(raiting)
    }
    func addDescription(description: String) {
        textField.text = description
    }
}
