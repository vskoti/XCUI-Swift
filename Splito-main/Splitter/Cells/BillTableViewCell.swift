//
//  BillTableViewCell.swift
//  Splito
//
//  Created by Shahid Latif on 22/06/2022.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    @IBOutlet weak var billDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
