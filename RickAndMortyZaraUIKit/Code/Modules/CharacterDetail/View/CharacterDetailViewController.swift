//
//  CharacterDetailView.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 13/9/23.
//

import UIKit
import SDWebImage

class CharacterDetailViewController: BaseViewController {

    // MARK: - Properties
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
        static let lbTopicType = "Type:"
        static let lbTopicSpecies  = "Species:"
        static let lbTopicOrigin  = "Origin:"
        static let lbTopicGender  = "Gender:"
        static let lbTopicLocation  = "Location:"
        static let placeHolderImage  = "placeholder"
    }
    
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var circleStatus: UIView!
    @IBOutlet weak var lbCharacterName: UILabel!
    @IBOutlet weak var vwType: DetailRowView!
    @IBOutlet weak var vwSpecies: DetailRowView!
    @IBOutlet weak var vwOrigin: DetailRowView!
    @IBOutlet weak var vwGender: DetailRowView!
    @IBOutlet weak var vwLocation: DetailRowView!
    private var viewModel: CharacterDetailViewModel?

    //MARK: - Object LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    // MARK: Public Methods
    func set(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Private Methods
    private func configView() {
        guard let characterDecorator = viewModel?.getCharacterDecorator() else { return }
        configCircle(characterDecorator.status)
        configRowViews(characterDecorator)
        ivCharacter.makeCircle()
        ivCharacter.sd_setImage(with: URL(string: characterDecorator.image), placeholderImage: UIImage(named: Constants.placeHolderImage))
        lbCharacterName.text = characterDecorator.characterName
        lbStatus.text = characterDecorator.status.capitalizeFirstLetter()
        
        lbCharacterName.adjustsFontSizeToFitWidth = true
        lbCharacterName.minimumScaleFactor = 0.5
        lbCharacterName.numberOfLines = 1
        
    }
    
    private func configRowViews(_ characterListDecorator: CharacterListDecorator) {
        vwType.lbTopic.text = Constants.lbTopicType
        vwSpecies.lbTopic.text = Constants.lbTopicSpecies
        vwOrigin.lbTopic.text = Constants.lbTopicOrigin
        vwGender.lbTopic.text = Constants.lbTopicGender
        vwLocation.lbTopic.text = Constants.lbTopicLocation
        
        vwType.lbValue.text = characterListDecorator.type
        vwSpecies.lbValue.text = characterListDecorator.species
        vwOrigin.lbValue.text = characterListDecorator.origin
        vwGender.lbValue.text = characterListDecorator.gender
        vwLocation.lbValue.text = characterListDecorator.location
    }
    
    private func configCircle(_ characterStatus: String) {
        
        circleStatus.makeCircle()
        circleStatus.layer.borderWidth = Constants.borderWidth
        
        switch characterStatus {
        case Constants.characterStatusAlive:
            circleStatus.backgroundColor = .green
            circleStatus.layer.borderColor = UIColor.systemGreen.cgColor
        case Constants.characterStatusUnknow:
            circleStatus.backgroundColor = .lightGray
            circleStatus.layer.borderColor = UIColor.gray.cgColor
        case Constants.characterStatusDead:
            circleStatus.backgroundColor = UIColor(hex: Constants.backgroundColorDead)
            circleStatus.layer.borderColor =  UIColor(hex: Constants.borderColorDead).cgColor
        default:
            return
        }
    }
}
