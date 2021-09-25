//
//  DateTableViewCell.swift
//  TesteTableView
//
//  Created by Leonardo Evangelista on 24/09/21.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Data"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    class func cellHeight() -> CGFloat {
         return 44.0
     }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        self.addSubview(dateLabel)
        
        label.topAnchor.constraint(
            equalTo: self.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(
            equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        dateLabel.topAnchor.constraint(
            equalTo: self.topAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
        
        // Configure the view for the selected state
    }
    
    func updateText(text: String, date: Date) {
        label.text = text
        dateLabel.text = date.ISO8601Format()
    }
    
}
