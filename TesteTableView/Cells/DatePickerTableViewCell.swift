//
//  DatePickerTableViewCell.swift
//  TesteTableView
//
//  Created by Leonardo Evangelista on 24/09/21.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath!
    weak var delegate: DatePickerDelegate?
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.isUserInteractionEnabled = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    class func cellHeight() -> CGFloat {
        return 162.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        self.contentView.addSubview(datePicker)
        datePicker.topAnchor.constraint(
            equalTo: self.topAnchor).isActive = true
        datePicker.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(
            equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
       
    }
    
    func updateCell(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        self.indexPath = indexPath
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        let indexPathForDisplayDate = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        delegate?.didChangeDate(date: sender.date, indexPath: indexPathForDisplayDate)
    }
    
}
