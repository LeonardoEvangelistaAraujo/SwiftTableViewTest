//
//  TextViewTableViewCell.swift
//  TesteTableView
//
//  Created by Leonardo Evangelista on 26/09/21.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var placeholder: String? {
        willSet{
            self.textView.text = newValue
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat {
         return 200.0
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.contentView.addSubview(textView)
        textView.topAnchor.constraint(
            equalTo: self.topAnchor).isActive = true
        textView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor).isActive = true
      
    }

}
