//
//  ViewController.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 17.06.2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Dependencies
    
    private let filterService: FilterServiceProtocol
    private var filterNamesModel = FilterNamesModel()
    private var filterPreviewModel = FilterPreviewModel()
    
    
    // Создаем переменную для сохранения изначального варианта картинки, к которой применяется фильтр - чтобы при изменении интенсивности фильтра новое значение накладывалось не на предыдущее значение интенсивности, а на изначальную картинку
    private var outputImage = UIImage()
    
    // Создаем переменную для сохранения indexPath выбранной ячейки чтобы использовать его при изменении значения слайдера (который меняет интенсивность фильтра)
    private var currentIndexPath: Int?

    
    // MARK: - Init
    
    init(filterService: FilterServiceProtocol) {
        self.filterService = filterService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    lazy var chooseImageBarButton: UIBarButtonItem = {
        let chooseImageBarButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(chooseImage))
        return chooseImageBarButton
    }()
    lazy var settingsBarButton: UIBarButtonItem = {
        let settingsBarButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(openSettings))
        return settingsBarButton
    }()
    lazy var cancelBarButton: UIBarButtonItem = {
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEditing))
        return cancelBarButton
    }()
    lazy var saveBarButton: UIBarButtonItem = {
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveImage))
        return saveBarButton
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Choose_photo")
        return imageView
    }()
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changeFilterIntensity), for: .valueChanged)
        slider.isHidden = true
        return slider
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (view.frame.width) / 4, height: (view.frame.width / 4))
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filters"
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(slider)
        navigationItem.rightBarButtonItems = [chooseImageBarButton]
        // Note: collectionView добавляем на вью не здесь, а из метода пикера (didFinishPickingMediaWithInfo)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setImageViewConstrants()
        setSliderConstrants()
        // Если хотим сделать слайдер вертикальным:
        // slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }

    
    // MARK: - Methods
    
    private func setImageViewConstrants() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)])
    }
    private func setSliderConstrants() {
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)])
    }
    private func setCollectionViewConstrants() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3)])
    }
    
    @objc func chooseImage() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func changeFilterIntensity() {
        let filteredImage = filterService.doFilter(imageToFilter: outputImage, filterName: filterNamesModel.filters[currentIndexPath ?? 0], intensity: Int(slider.value))
        imageView.image = filteredImage
    }
    
    @objc func openSettings() {
        
        // Скрываем collection view и показываем слайдер
        collectionView.isHidden = true
        slider.isHidden = false
        
        // Устанавливаем значение слайдера на исходное значение (на середину)
        slider.value = 5
        
        // Меняем слева кнопку настроек на кнопку cancel, а справа оставляем только кнопку save
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItems = [saveBarButton]

    }
    @objc func cancelEditing() {
        // Возвращаем все как было до нажатия кнопки настроек
        collectionView.isHidden = false
        slider.isHidden = true
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.rightBarButtonItems = [chooseImageBarButton, saveBarButton]
    }
    
    @objc func saveImage() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        chooseImage()
    }
    
}


// MARK: - Picker Controller

// Подписываем VC на протокол пикер контроллера (и навигейшн контроллера) и юзаем метод didFinishPickingMediaWithInfo чтобы забрать картинку из пикера

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //  Метод didFinishPickingMediaWithInfo возвращает картинки в виде словаря info - из него мы забираем нужные картинки по ключу (нам нужны отредактированные, соответственно, ключ будет .editedImage)
        if let image = info[.editedImage] as? UIImage {
            
            // Сохраняем картинку в переменной - чтобы при изменении интенсивности фильтра новое значение накладывалось не на предыдущее значение интенсивности, а на изначальную картинку
            outputImage = image
            
            // применяем фильтр и передаем полученную картинку в наш imageView
            let filteredImage = filterService.doFilter(imageToFilter: outputImage, filterName: filterNamesModel.filters[0], intensity: 5)
            imageView.image = filteredImage
            
            // Добавляем превьюхи фильтров в filterPreviewModel для использования в collection view
            filterPreviewModel.imagesForPreview.removeAll()
            filterPreviewModel.imagesForPreview = filterNamesModel.filters.compactMap {
                filterService.doFilter(imageToFilter: outputImage, filterName: $0, intensity: 5)
            }
            // Загружаем collectionView
            view.addSubview(collectionView)
            setCollectionViewConstrants()
            
            // Дисмиссим пикер
            dismiss(animated: true, completion: nil)
            
            // Добавляем кнопку настроек и кнопку save
            navigationItem.leftBarButtonItem = settingsBarButton
            navigationItem.rightBarButtonItems = [chooseImageBarButton, saveBarButton]
        }
    }
}

// MARK: - Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNamesModel.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: filterNamesModel, filterPreviewModel: filterPreviewModel, index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Сохраняем indexPath выбранной ячейки чтобы использовать его при изменении значения слайдера (который меняет интенсивность фильтра)
        currentIndexPath = indexPath.item
        
        let filteredImage = filterService.doFilter(imageToFilter: outputImage, filterName: filterNamesModel.filters[indexPath.item], intensity: 5)
                
        navigationItem.title = "\(filterNamesModel.filters[indexPath.item])"
        
        imageView.image = filteredImage
    }
}
