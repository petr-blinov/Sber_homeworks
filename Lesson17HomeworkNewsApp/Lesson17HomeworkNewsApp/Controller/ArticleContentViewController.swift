//
//  ArticleContentViewController.swift
//  Lesson17HomeworkNewsApp
//
//  Created by Петр Блинов on 06.06.2021.
//

import UIKit


final class ArticleContentViewController: BaseViewController {
  
    // MARK: - Dependencies
    private var networkService : NetworkServiceProtocol
    private var model: Get2ArticleDataResponse
  
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol, model: Get2ArticleDataResponse) {
      self.networkService = networkService
      self.model = model
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    
  // MARK: - UI
 
    private lazy var articleTitle: UILabel = {
        let articleTitle = UILabel()
        articleTitle.numberOfLines = 0
        articleTitle.font = UIFont.systemFont(ofSize: 33)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        return articleTitle
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    private lazy var articlePublishedAt: UILabel = {
        let articlePublishedAt = UILabel()
        articlePublishedAt.numberOfLines = 0
        articlePublishedAt.font = UIFont.systemFont(ofSize: 15)
        articlePublishedAt.translatesAutoresizingMaskIntoConstraints = false
        return articlePublishedAt
    }()
    private lazy var articleContent: UILabel = {
        let articleDescription = UILabel()
        articleDescription.numberOfLines = 0
        articleDescription.font = UIFont.systemFont(ofSize: 18)
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        return articleDescription
    }()
    private lazy var readInSource: UILabel = {
        let readOnSource = UILabel()
        readOnSource.numberOfLines = 0
        readOnSource.font = UIFont.systemFont(ofSize: 12)
        readOnSource.translatesAutoresizingMaskIntoConstraints = false
        return readOnSource
    }()

  
  // MARK: - LifeCircle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(articleTitle)
    view.addSubview(imageView)
    view.addSubview(articlePublishedAt)
    view.addSubview(articleContent)
    view.addSubview(readInSource)

    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setConstraints()
  }
  

  
// MARK: - Constraints
  private func setConstraints() {
    NSLayoutConstraint.activate([
        articleTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        articleTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        articleTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
    
    NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: articleTitle.bottomAnchor,constant: 10),
        imageView.bottomAnchor.constraint(equalTo: imageView.topAnchor,constant: 200),
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
        articlePublishedAt.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        articlePublishedAt.bottomAnchor.constraint(equalTo: articlePublishedAt.topAnchor, constant: 20),
        articlePublishedAt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        articlePublishedAt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
    
    NSLayoutConstraint.activate([
        articleContent.topAnchor.constraint(equalTo: articlePublishedAt.bottomAnchor, constant: 20),
        articleContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        articleContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
    
    NSLayoutConstraint.activate([
        readInSource.topAnchor.constraint(equalTo: articleContent.bottomAnchor, constant: 20),
        readInSource.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        readInSource.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
  }
  
  // MARK: - LoadData
  private func loadData() {
    
    self.isLoading = true
    
    networkService.loadImage(with: model) { (data) in
        
      if let data = data, let image = UIImage(data: data) {
        
          DispatchQueue.main.async {
            
            self.articleTitle.text = self.model.title
            self.imageView.image = image
            self.articlePublishedAt.text = self.model.publishedAt
            self.articleContent.text = self.model.description
            self.readInSource.text = "Read in source: \(self.model.url)"

            self.isLoading = false
            
          }
      }
    }
  }
}
