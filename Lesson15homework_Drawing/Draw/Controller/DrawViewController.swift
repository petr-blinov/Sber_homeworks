//
//  DrawViewController.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit


class DrawViewController: UIViewController {

    //MARK: - PROPERTIES
    
    private var instrument = [ToolProtocol]()
    let drawViewBottomAnchorConstant  : CGFloat = -60
    private var layout: ToolsCollectionViewLayout!
    
    lazy var drawView: DrawView =  {
        let drawView = DrawView()
        drawView.translatesAutoresizingMaskIntoConstraints = false
        drawView.backgroundColor = .clear
        return drawView
    }()
    
    lazy var colorTableView: ColorsTableView = {
        let tableView = ColorsTableView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var colorIndicator: ColorIndicator = {
        let indicator = ColorIndicator()
        indicator.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var images = [UIImage]()
    
    private lazy var saveItem : UIBarButtonItem = {
        let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDraw))
        return add
    }()
    
    private lazy var undoItem : UIBarButtonItem = {
        let add = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undo))
        return add
    }()
    
    lazy var toolsCollectionView: UICollectionView = {
        let tCV = UICollectionView(frame: CGRect(x: 0,
                                                 y: self.view.bounds.maxY - 150,
                                                 width: self.view.bounds.width,
                                                 height: 150),
                                   collectionViewLayout: self.layout)
        tCV.backgroundColor = .white
        tCV.register(ToolsCollectionViewCell.self, forCellWithReuseIdentifier: ToolsCollectionViewCell.reuseIdentifier)
        tCV.dataSource = self
        tCV.delegate =  self
        tCV.translatesAutoresizingMaskIntoConstraints = false
        return tCV
    }()
    
    //MARK: - VIEW CONTROLLER LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInstrument()
        
        self.layout = ToolsCollectionViewLayout()
        
        view.addSubview(drawView)
        view.addSubview(toolsCollectionView)
        setColorsModule()
        view.backgroundColor = .white
        setLayout()
        self.navigationItem.rightBarButtonItems = [saveItem,undoItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - LAYOUT
    func setLayout() {
        //guard let bottomNaviBar = self.navigationController?.navigationBar.bottomAnchor else { return }
        NSLayoutConstraint.activate([
            drawView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            drawView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            drawView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drawView.bottomAnchor.constraint(equalTo: toolsCollectionView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            toolsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
        NSLayoutConstraint.activate([
            colorIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            colorIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            colorIndicator.heightAnchor.constraint(equalToConstant: 40),
            colorIndicator.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            colorTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            colorTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            colorTableView.widthAnchor.constraint(equalToConstant: 40),
            colorTableView.heightAnchor.constraint(equalToConstant: CGFloat(colorTableView.colors.count * 50))
        ])
    }
    
    func configureInstrument(){
        instrument.append(ToolPen())
        instrument.append(ToolRect())
        instrument.append(ToolEllipse())
        instrument.append(ToolLine())
    }
    
    func setColorsModule() {
        view.addSubview(colorTableView)
        view.addSubview(colorIndicator)
        colorTableView.delegate = self
        colorTableView.dataSource = self
    }
    //MARK: - Save
    @objc func saveDraw() {
        guard let image = drawView.image else {return}
        DataManager.shared.add(with: image)
    }
    
    //MARK: - Undo
    @objc func undo() {
        drawView.undo()
    }
    
    //MARK: - Change Color
    @objc func changeColor() {
        colorTableView.isHidden = colorTableView.isHidden ? false : true
    }
    
}
//MARK: - UITableViewDelegate & DataSource
extension DrawViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorTableView.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ColorsTableViewCell()
        cell.configure(with: colorTableView.colors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        colorIndicator.backgroundColor = colorTableView.colors[indexPath.row]
        drawView.lineColor = colorTableView.colors[indexPath.row]
        tableView.isHidden = true
    }
}

//MARK: - UICollectionViewDataSource
extension DrawViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instrument.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToolsCollectionViewCell.reuseIdentifier, for: indexPath) as! ToolsCollectionViewCell
        let tool = instrument[indexPath.item]
        cell.configure(with: tool)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension DrawViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = instrument[indexPath.item]
        switch item {
        case is ToolPen:
            drawView.drawTool = .pen
        case is ToolRect:
            drawView.drawTool = .rectangle
        case is ToolEllipse:
            drawView.drawTool = .ellipse
        case is ToolLine:
            drawView.drawTool = .line
        default:
            print("Error")
        }
    }
}

