//
//  TableViewCell.swift
//  Lesson17HomeworkNewsApp
//
//  Created by Петр Блинов on 04.06.2021.
//

import UIKit

final class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    func configure(with model: Get2ArticleDataResponse) {
        textLabel?.text = model.title
    }
}
