//// 
//  MessageViewCell.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/18
//  
//
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    public lazy var body: UITextView = {
        let bodyLabel = UITextView(frame: .zero)
        bodyLabel.textAlignment = .right
        return bodyLabel
    }()
    
    public lazy var name: UITextView = {
        let bodyLabel = UITextView(frame: .zero)
        bodyLabel.textAlignment = .right
        return bodyLabel
    }()
    
    public lazy var time: UITextView = {
        let bodyLabel = UITextView(frame: .zero)
        bodyLabel.textAlignment = .right
        return bodyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI() {
        self.contentView.addSubview(self.body)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.time)
        
        self.name.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(2)
            make.right.equalTo(self.contentView.snp.right).offset(-12.0)
            make.width.equalTo(100)
            make.height.equalTo(0)
        }
        
        self.body.snp.makeConstraints { make in
            make.right.equalTo(self.name.snp.right)
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        self.time.snp.makeConstraints { make in
            make.top.equalTo(self.body.snp.bottom)
            make.right.equalTo(self.body.snp.right)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
    }
    
    func setModel(messageVo: MessageVo) {
        self.name.text = messageVo.name
        self.body.text = messageVo.content
        self.time.text = timeStampToDateString(timestamp: messageVo.time)
    }
    
    func timeStampToDateString(timestamp: Int) -> String {
        let timeInterval: TimeInterval = TimeInterval(timestamp/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

}
