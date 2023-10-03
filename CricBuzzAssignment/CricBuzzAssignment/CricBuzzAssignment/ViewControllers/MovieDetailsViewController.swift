//
//  MovieDetailsViewController.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 01/10/23.
//
import UIKit
import SDWebImage
import SwiftUI

class MovieDetailsViewController: UIViewController {

    let movie: Movie
    let headerHeight: CGFloat = 400
    let segmentedControlHeight: CGFloat = 44
    let contentViewPadding: CGFloat = 100
    let ratingControltag = 111

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let castAndCrewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releasedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ratingSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentTintColor = .blue
        return segmentControl
    }()

    private var ratingSources: [String]!
    private var ratingValues: [String]!

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(castAndCrewLabel)
        contentView.addSubview(releasedDateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(ratingSegmentControl)
        
        setUpRatingSegmentControl()


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: headerHeight),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            castAndCrewLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 12),
            castAndCrewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            castAndCrewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            releasedDateLabel.topAnchor.constraint(equalTo: castAndCrewLabel.bottomAnchor, constant: 12),
            releasedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releasedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genreLabel.topAnchor.constraint(equalTo: releasedDateLabel.bottomAnchor, constant: 12),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ratingSegmentControl.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12),
            ratingSegmentControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingSegmentControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ratingSegmentControl.heightAnchor.constraint(equalToConstant: segmentedControlHeight),
            ratingSegmentControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        if let poster = movie.poster, let imageURL = URL(string: poster) {
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"))
        }
        titleLabel.text = "Title: \n \(movie.title)"
        overviewLabel.text = "Plot: \n \(movie.plot)"
        castAndCrewLabel.text = "Cast & Crew: \n \(movie.actors)"
        releasedDateLabel.text = "Released Date: \(movie.released)"
        genreLabel.text = "Genre: \(movie.genre)"
        
        

        // Calculate and update the frames for titleLabel, overviewLabel, cast & crew Label, release date label and genre label
        let titleLabelHeight = heightForLabel(text: movie.title, font: titleLabel.font, width: view.bounds.width - 32)
        let overviewLabelHeight = heightForLabel(text: movie.plot, font: overviewLabel.font, width: view.bounds.width - 32)
        let castAndCrewLabelHeight = heightForLabel(text: castAndCrewLabel.text, font: castAndCrewLabel.font, width: view.bounds.width - 32)
        let releasedDateLabelHeight = heightForLabel(text: releasedDateLabel.text, font: releasedDateLabel.font, width: view.bounds.width - 32)
        let genreLabelHeight = heightForLabel(text: genreLabel.text, font: genreLabel.font, width: view.bounds.width - 32)

        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: headerHeight + titleLabelHeight + overviewLabelHeight + castAndCrewLabelHeight + releasedDateLabelHeight + genreLabelHeight + segmentedControlHeight + contentViewPadding
        )
        
        
    }
    
    func setUpRatingSegmentControl() {
        ratingSources = movie.ratings.map { rating in
            rating.source
        }
        ratingValues = movie.ratings.map { rating in
            let value = rating.value
            if value.contains("/") {
                let components = value.components(separatedBy: "/")
                if components.count > 1 {
                    let divider = Int(components[1])
                    return divider == 100 ? String(((Double(components[0]) ?? 0) / 10)) : components[0]
                } else {
                    return value.replacingOccurrences(of: "/", with: "")
                }
            } else if value.contains("%") {
                let percentage = value.replacingOccurrences(of: "%", with: "")
                return String((Double(percentage) ?? 0) / 10)
                
            } else {
                return value
            }
        }
        
        for rating in movie.ratings {
            addSegmentWith(rating.source)
        }
        ratingSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        ratingSegmentControl.selectedSegmentIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Create a SwiftUI view
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: scrollView.contentSize.height + segmentedControlHeight
        )
        let movieRating = CGFloat(Float(ratingValues.first ?? "0") ?? 0)
        self.addRatingControlWith(movieRating)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
           let selectedSegmentIndex = sender.selectedSegmentIndex
           // Perform actions based on the selected segment index
        let rating = self.ratingValues[selectedSegmentIndex]
        self.addRatingControlWith(CGFloat(Float(rating) ?? 0))
       }

       // Function to add a new segment
    func addSegmentWith(_ title: String) {
           ratingSegmentControl.insertSegment(withTitle: title, at: ratingSegmentControl.numberOfSegments, animated: true)
       }

       // Function to remove the last segment
       func removeSegment() {
           if ratingSegmentControl.numberOfSegments > 0 {
               ratingSegmentControl.removeSegment(at: ratingSegmentControl.numberOfSegments - 1, animated: true)
           }
       }
    
    func addRatingControlWith(_ rating: CGFloat) {
        if let ratingView = contentView.viewWithTag(ratingControltag) {
            ratingView.removeFromSuperview()
        }
        let starRatingControl = ContentView(currentRating: rating)
        

        // Create a UIHostingController and set its rootView to the SwiftUI view
        let hostingController = UIHostingController(rootView: starRatingControl)
        hostingController.view.backgroundColor = .clear
        hostingController.view.tag = ratingControltag
        var ratingFrame = contentView.frame
        ratingFrame.size.height = segmentedControlHeight
        ratingFrame.origin.y = scrollView.contentSize.height - segmentedControlHeight
        hostingController.view.frame = ratingFrame

        // Add the UIHostingController as a child view controller
        addChild(hostingController)

        // Add the UIHostingController's view as a subview
        contentView.addSubview(hostingController.view)

        // Notify the child view controller that it has been moved to the parent
        hostingController.didMove(toParent: self)
    }

    private func heightForLabel(text: String?, font: UIFont, width: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
