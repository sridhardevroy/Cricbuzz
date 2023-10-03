//
//  SectionHeaderView.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 27/09/23.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, CollapseSectionHeader {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var indicatorImageView: UIImageView {
        return imageView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "arrow_down").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white        
    }
    
    func setHeader(_ title: String) {
        titleLabel.text = title
    }
}

