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
    
    func setupDate(date: Date) {
    
        if date.diffDateToPresentDays > 0 {
            var value =  "dia"
            if date.diffDateToPresentDays > 1 {
                value =  "dias"
            }
            let days = " (\(date.diffDateToPresentDays) \(value) ) "
            self.dateLabel.text = date.convertDateToString(format: "dd/MM/yyyy") + days
            
        } else {
            self.dateLabel.text = Date().dateToStringISO8601
        }

    }
    
    func setupTime(date: Date) {

        dateLabel.text = date.convertDateToString(format: "HH:mm a")
        
    }
    
}
