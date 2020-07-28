//
//  LocationTableViewCell.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var aliasLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cityLbl.font = .locationCity
        aliasLbl.font = .locationAlias
        addressLbl.font = .locationAddress
        distanceLbl.font = .locationDistance
        
        selectedImg.image = UIImage(named: "check_box")
    }
}
