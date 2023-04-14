//
//  LibraryViewModel.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import Foundation

protocol LibraryProtocol {
    func getBooks() -> [Work]
    func sendRequest()
    func getCovers() -> [String:Data]
}

final class LibraryViewModel: LibraryProtocol {
    //MARK: - Properties
    private weak var viewController: LibraryControllerProtocol?
    private var books: [Work] = []
    private var covers: [String:Data] = [:]
    
    init(viewController: LibraryControllerProtocol) {
        self.viewController = viewController
    }
    
    //MARK: - Get books
    func getBooks() -> [Work] {
        books
    }
    //MARK: - Get covers
    func getCovers() -> [String : Data] {
        covers
    }
    
    //MARK: - Send request
    func sendRequest() {
        let url = URL(string: "https://openlibrary.org/trending/daily.json")!
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data, error == nil else {
                self.viewController?.onError()
                return
            }
            do {
                let libraryResponce = try JSONDecoder().decode(Library.self, from: data)
                self.books = libraryResponce.works
                DispatchQueue.main.async {
                    self.viewController?.successfully()
                }
                addCovers()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        task.resume()
    }
    //MARK: - Add covers
    private func addCovers() {
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        DispatchQueue.concurrentPerform(iterations: self.books.count) { index in
            if let id = books[index].coverI {
                group.enter()
                downloadImage(id: id) { data, error in
                    guard let data = data else {
                        group.leave()
                        return
                    }
                    semaphore.wait()
                    self.covers[self.books[index].title] = data
                    group.leave()
                    semaphore.signal()
                }
            }
            group.notify(queue: .main) {
                self.viewController?.successfully()
            }
        }
    }
    
    //MARK: - Download imgage
    private func downloadImage(id: Int, completition: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://covers.openlibrary.org/b/id/\(String(id))-L.jpg")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completition(nil, error)
                return
            }
            completition(data, nil)
        }.resume()
    }
}
