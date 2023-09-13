//
//  CharacterListCell.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 12/9/23.
//

import UIKit
import SDWebImage

class CharacterListCell: UITableViewCell {
    // MARK: Properties
    private enum Constants {
        static let circleViewWidth = 12.0
        static let circleViewHeight = 12.0
        static let borderWidth = 2.0
        static let lbCharacterSize = 20.0
        static let lbStatusSize = 17.0
        static let characterStatusAlive = "Alive"
        static let characterStatusUnknow = "unknown"
        static let characterStatusDead = "Dead"
        static let backgroundColorDead = "#FF0015"
        static let borderColorDead = "#98020F"
        static let borderColorImageView = "#2A2D34"
        static let lbCharacterFont = "AppleSDGothicNeo-Medium"
        static let lbStatusFont = "AppleSDGothicNeo-Light"
    }
    
    static let identifier = "CharacterListCellCellIdentifier"
    static let nibName = "CharacterListCell"
    
    @IBOutlet weak var lbCharacterName: UILabel!
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var lbStatus: UILabel!
    
    // MARK: - Public Methods
    
    func config(characterElement: CharacterListDecorator) {
        configCircle(characterElement.status)
        configImageView(characterElement.image)
        configLabels(characterElement)
    }

    // MARK: - Private Methods
    private func configLabels(_ characterElement: CharacterListDecorator) {
        lbCharacterName.text = characterElement.characterName
        lbStatus.text = characterElement.status.capitalizeFirstLetter()
        lbCharacterName.font = UIFont(name: Constants.lbCharacterFont, size: Constants.lbCharacterSize)
        lbStatus.font = UIFont(name: Constants.lbStatusFont, size: Constants.lbStatusSize)
        lbCharacterName.adjustsFontSizeToFitWidth = true
        lbCharacterName.minimumScaleFactor = 0.5
        lbCharacterName.numberOfLines = 1
        lbStatus.textColor = .gray
    }
    
    private func configImageView(_ image: String) {
        ivCharacter.makeCircle()
        ivCharacter.layer.borderColor = UIColor(hex: Constants.borderColorImageView).cgColor
        ivCharacter.layer.borderWidth = 1.0
        self.ivCharacter.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    private func configCircle(_ characterStatus: String) {
        circleView.makeCircle()
        circleView.layer.borderWidth = Constants.borderWidth
        switch characterStatus {
        case Constants.characterStatusAlive:
            circleView.backgroundColor = .green
            circleView.layer.borderColor = UIColor.systemGreen.cgColor
        case Constants.characterStatusUnknow:
            circleView.backgroundColor = .lightGray
            circleView.layer.borderColor = UIColor.gray.cgColor
        case Constants.characterStatusDead:
            circleView.backgroundColor = UIColor(hex: Constants.backgroundColorDead)
            circleView.layer.borderColor =  UIColor(hex: Constants.borderColorDead).cgColor
        default:
            return
        }
    }
}
