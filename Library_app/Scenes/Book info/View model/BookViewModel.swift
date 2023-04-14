//
//  BookViewModel.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 14.04.23.
//

import Foundation

protocol BookInfoProtocol {
    func setupCover()
    func sendRequest()
    func getBook() -> Work
    func sendBookRequest()
}

final class BookInfoViewModel: BookInfoProtocol {
    //MARK: - Properties
    private weak var viewController: BookViewControllerProtocol?
    var book: Work
    var cover: Data?
    
    init(viewController: BookViewControllerProtocol, book: Work, cover: Data?) {
        self.viewController = viewController
        self.book = book
        self.cover = cover
    }
    //MARK: - Get book
    func getBook() -> Work {
        book
    }
    
    //MARK: - Setup cover
    func setupCover() {
        if let cover = cover {
            viewController?.setupCover(cover: cover)
        } else {
            guard let id = book.coverI else { return }
            downloadImage(id: id)
        }
    }
    //MARK: - Download imgage
    private func downloadImage(id: Int) {
        let url = URL(string: "https://covers.openlibrary.org/b/id/\(String(id))-L.jpg")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            self.viewController?.setupCover(cover: data)
        }.resume()
    }
    //MARK: - Send raiting request
    func sendRequest() {
        let url = URL(string: "https://openlibrary.org\(book.key)/ratings.json")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let raitingResponse = try JSONDecoder().decode(Raiting.self, from: data)
                DispatchQueue.main.async {
                    self.viewController?.addRaiting(raiting: raitingResponse.summary.average)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        task.resume()
    }
    //MARK: - Send book request
    func sendBookRequest() {
        let id = book.key.components(separatedBy: "/").last?.components(separatedBy: "/").first
        let url = URL(string: "https://openlibrary.org/books/\(id!).json")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            do {
                let bookResponse = try JSONDecoder().decode(Book.self, from: data)
                DispatchQueue.main.async {
                    self.viewController?.addDescription(description: bookResponse.description.value)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        task.resume()
    }
}
