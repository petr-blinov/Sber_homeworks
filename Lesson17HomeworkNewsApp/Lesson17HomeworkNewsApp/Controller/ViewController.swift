//
//  ViewController.swift
//  Lesson17HomeworkNewsApp
//
//  Created by Петр Блинов on 03.06.2021.
//

import UIKit

final class ViewController: BaseViewController {

    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    

    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Internal Properties
    private var dataSource = [Get2ArticleDataResponse]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()
    }
    
    
    // MARK: - Private methods
    private func configureUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadData() {
        isLoading = true
        self.networkService.getArticles {
            self.processDataLoading($0) }
    }

    private func processDataLoading(_ response: GetAPIResponse) {
         DispatchQueue.main.async {
            switch response {
            
            case .success(let data):
                self.dataSource.append(contentsOf: data.articles)
                self.tableView.reloadData()
                
            case .failure(let error):
                self.showErrorAlert(for: error)
            }
            self.isLoading = false
        }
    }
    
    // MARK: - Error handling
    private func showErrorAlert(for error: NetworkServiceError) {
        let alert = UIAlertController(title: "Что-то пошло не так",
                                      message: setAlertMessage(for: error),
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
    private func setAlertMessage(for error: NetworkServiceError) -> String {
        switch error {
        case .network:
            return "Ошибка подключения к сети"
        case .decodable:
            return "Ошибка парсинга"
        case .unknown:
            return "Неизвестная ошибка, обратитесь к администратору"
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath)
        
//       Используем DTO - чтобы ячейка конфигурировалась на стороне
//       Data Transfer Object (DTO) — шаблон проектирования, используется для передачи данных между подсистемами приложения. DTO в отличие от business object или data access object не должен содержать какого-либо поведения.
        (cell as? ArticleCell)?.configure(with: dataSource[indexPath.row])
        return cell
    }
}


extension ViewController: UITableViewDelegate {

//    Используем willDisplay cell для того чтобы таблица загружала новый кусок данных когда мы пролистываем до последней ячейки
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1, !isLoading {
            isLoading = true
            networkService.getArticles { self.processDataLoading($0) }
        }
    }

}
