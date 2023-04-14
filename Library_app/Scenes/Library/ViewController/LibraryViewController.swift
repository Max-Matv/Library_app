//
//  ViewController.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import UIKit
import SwiftUI

protocol LibraryControllerProtocol: AnyObject {
    func onError()
    func successfully()
}

class LibraryViewController: UIViewController {
    //MARK: - Properties
    var viewModel: LibraryProtocol?
    
    //MARK: - Views
    private lazy var header: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var alertView: AlertView = {
        let view = AlertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHeader()
        setupCollectionView()
        setupAlertView()
        setupActivityIndicator()
        addRequest()
    }
    //MARK: - Setup header
    private func setupHeader() {
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
    }
    //MARK: - Setup collection view
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(setupLayout(), animated: false)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: LibraryCell.reuseIdentifire)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    //MARK: - Setup collection view layout
    private func setupLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 10, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    //MARK: - Setup alert view
    private func setupAlertView() {
        collectionView.addSubview(alertView)
        alertView.isHidden = true
        alertView.delegate = self
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
        ])
    }
    //MARK: - Setup activity indicator
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    //MARK: - AddRequest
    private func addRequest() {
        if NetworkMonitor.shared.isConnected {
            viewModel?.sendRequest()
        } else {
            activityIndicator.stopAnimating()
            alertView.isHidden = false
        }
    }

}

//MARK: - Collection view delegeta / data source
extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getBooks().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCell.reuseIdentifire, for: indexPath) as? LibraryCell else { fatalError() }
        if let books = viewModel?.getBooks(), let covers = viewModel?.getCovers() {
            cell.setupCell(book: books[indexPath.row], covers: covers)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BookInfoViewController()
        let book = (viewModel?.getBooks()[indexPath.row])!
        let cover: Data?
        if let covers = viewModel?.getCovers() {
            cover = covers[book.title]
        } else {
            cover = nil
        }
        vc.viewModel = BookInfoViewModel(viewController: vc, book: book, cover: cover)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LibraryViewController: AlertViewProtocol {
    func buttonPressed() {
        alertView.isHidden = true
        activityIndicator.startAnimating()
        addRequest()
    }
}
//MARK: - Controller protocol methods
extension LibraryViewController: LibraryControllerProtocol {
    func successfully() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func onError() {
        alertView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
}

