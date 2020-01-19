//
//  NewsTableVC.swift
//  GoodNews
//
//  Created by Naoki Muroya on 2020/01/13.
//  Copyright © 2020 Naoki Muroya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableVC: UITableViewController {

    let disposeBag = DisposeBag()

    private var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        populateNews()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        return cell
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func populateNews() {
        URLRequest.load(resource: ArticlesList.all).subscribe(onNext: { [weak self] result in
            if let result = result {
                self?.articles = result.articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
    }
}
