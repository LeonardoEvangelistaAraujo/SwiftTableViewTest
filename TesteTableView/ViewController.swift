//
//  ViewController.swift
//  TesteTableView
//
//  Created by Leonardo Evangelista on 24/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var datePickerIndexPath: IndexPath?
    
    var inputTexts: [String] = ["Data", "Hora"]
    var inputDates: [Date] = []
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.separatorColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(DateTableViewCell.self, forCellReuseIdentifier: "DateTableViewCell")
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: "DatePickerTableViewCell")
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "TextViewTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        inputDates = Array(repeating: Date(), count: inputTexts.count)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            tableView.beginUpdates()
            if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                self.datePickerIndexPath = nil
            } else {
                if let datePickerIndexPath = datePickerIndexPath {
                    tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                }
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
            }
            tableView.endUpdates()
        default:
            if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                self.datePickerIndexPath = nil
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if datePickerIndexPath != nil {
                return inputTexts.count + 1
            } else {
                return inputTexts.count
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0 :
            if datePickerIndexPath == indexPath {
                return DatePickerTableViewCell.cellHeight()
            } else {
                return DateTableViewCell.cellHeight()
            }
        default :
            return TextViewTableViewCell.cellHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 :
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell") as! DatePickerTableViewCell
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.delegate = self
            
            if indexPath.row == 1 {
                datePickerCell.datePicker.datePickerMode = .date
            }else if indexPath.row == 2{
                datePickerCell.datePicker.datePickerMode = .time
            }
            
            return datePickerCell
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as! DateTableViewCell
                
            if indexPath.row == 0 {
                dateCell.label.text = inputTexts[indexPath.row]
                dateCell.setupDate(date: inputDates[indexPath.row])
            }else if indexPath.row == 1{
                dateCell.label.text = inputTexts[indexPath.row]
                dateCell.setupTime(date: inputDates[indexPath.row])
            }
            return dateCell
        }
        default:
            let commentsCell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell") as! TextViewTableViewCell
            return commentsCell
        }
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
}

extension ViewController: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
