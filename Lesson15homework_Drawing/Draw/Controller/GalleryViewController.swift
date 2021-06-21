//
//  GalleryViewController.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

final class GalleryViewController: UIViewController{
    
      //MARK: - Properties
    
    private lazy var collectionView : UICollectionView = {
        let layout = GalleryCollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate  = self
        return collection
    }()
    
    private lazy var addItem : UIBarButtonItem = {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        return add
    }()

    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout = GalleryCollectionViewLayout().createLayout()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: - UI
    func configure() {
        title = "Gallery"
        view.backgroundColor = .white
    }

    //MARK: - Constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - AddTapped
    @objc func addTapped() {
        navigationController?.pushViewController(DrawViewController(), animated: true)
    }
}

//MARK: - Delegate
extension GalleryViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            navigationController?.pushViewController(DrawViewController(), animated: true)
        }
    }
}

//MARK: - DataSource
extension   GalleryViewController  : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return DataManager.shared.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        let images = DataManager.shared.images
        let image = images[indexPath.item]
        cell.configure(with : image)
        return cell
    }
    
    
}
