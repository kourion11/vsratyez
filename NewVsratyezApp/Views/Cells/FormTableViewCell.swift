//
//  FormTableViewCell.swift
//  NewVsratyezApp
//
//  Created by Сергей Юдин on 17.06.2022.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUdpateField updatedModel: EditProfileFormModel?)
}

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private lazy var formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        formConfigure()
    }
    
    private func formConfigure() {
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        textField.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        formLabel.text = model.label
        textField.placeholder = model.placeholder
        textField.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        textField.frame = CGRect(x: formLabel.right + 5,
                                 y: 0,
                                 width: contentView.width-10-formLabel.height,
                                 height: contentView.height)
    }
}

// MARK: - Field

extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.formTableViewCell(self, didUdpateField: textField.text)
        textField.resignFirstResponder()
        return true
    }
}
