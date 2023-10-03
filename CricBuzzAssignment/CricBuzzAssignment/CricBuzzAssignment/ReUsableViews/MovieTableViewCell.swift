//
//  MovieTableViewCell.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 01/10/23.
//

import Foundation
import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews to the cell's content view
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(yearLabel)
        
        // Define constraints for the subviews
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
            
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            languageLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            languageLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
            
            yearLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        languageLabel.text = "Language: \(movie.language)"
        yearLabel.text = "Released Year: \(movie.year)"
        if let poster = movie.poster, let imageURL = URL(string: poster){
            movieImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"))
        }
    }
}
