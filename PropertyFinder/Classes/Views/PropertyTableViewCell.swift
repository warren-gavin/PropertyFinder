//
//  PropertyTableViewCell.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var amenities: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    
    func setProperty(_ property: Property) {
        let viewModel = PropertyViewModel(property)

        title.text     = viewModel.title
        subtitle.text  = viewModel.subject
        amenities.text = viewModel.amenities
        price.text     = viewModel.price
        
        if let url = viewModel.thumbnail {
            thumbnail.image(at: url, placeholder: #imageLiteral(resourceName: "placeholder"), completionHandler: nil)
        }
    }
}
