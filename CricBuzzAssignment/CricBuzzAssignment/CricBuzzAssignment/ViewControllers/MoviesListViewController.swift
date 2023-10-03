//
//  MoviesListViewController.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 03/10/23.
//

import Foundation
import UIKit

class MoviesListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var moviesList: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        tableView.reloadData()
        CATransaction.commit()
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getMoviesCellFor(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: self.moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getMoviesCellFor(indexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.moviesList[indexPath.row]
        navigateToMovieDetailsScreenWith(movie)
    }
    
    func navigateToMovieDetailsScreenWith(_ selectedMovie: Movie) {
        
        let movieDetailsVC = MovieDetailsViewController(movie: selectedMovie)
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}
