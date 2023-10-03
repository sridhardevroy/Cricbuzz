//
//  ViewController.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 27/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: CollapseTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel = MovieViewModel()
    var shouldShowSearchResults = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchLocalMovies { [weak self] error in
            if let error = error {
                // Handle error loading or parsing JSON data
                print("Error: \(error.localizedDescription)")
            } else {
                // Update your UI, e.g., reload your table view
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setupTableView()
                    /*self.tableView.didTapSectionHeaderView = { (sectionIndex, isOpen) in
                        debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
                    }
                    self.reloadTableView { [unowned self] in
                        self.tableView.openSection(0, animated: true)
                    }
                    */
                }
            }
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: SectionHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if shouldShowSearchResults {
            return 1
        } else {
            return MovieSection.allCases.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return self.viewModel.filteredMovies.count
        } else {
            switch section {
            case MovieSection.allMovies.rawValue:
                return self.viewModel.filteredMovies.count
            default:
                return self.viewModel.movieSectionsData[section].count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == MovieSection.allMovies.rawValue || shouldShowSearchResults {
            return 100
        }
        return 44
    }
    
    func getMoviesCellFor(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: self.viewModel.filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if shouldShowSearchResults {
            return getMoviesCellFor(indexPath)
        } else {
            switch indexPath.section {
            case MovieSection.allMovies.rawValue:
                print("Movies Section")
                return getMoviesCellFor(indexPath)
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
                cell.textLabel?.text = self.viewModel.getTitleForCellWith(indexPath)
                return cell
            }
        }
        

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView else {
            let view = Bundle.main.loadNibNamed(SectionHeaderView.reuseIdentifier, owner: self, options: nil)?.first as? SectionHeaderView
            view?.setHeader(getHeaderTitleFor(section))
            return view
        }
        view.setHeader(getHeaderTitleFor(section))
        return view
    }
    
    func getHeaderTitleFor(_ section: Int) -> String {
        return shouldShowSearchResults ? "Search Results" : MovieSection(rawValue: section)?.rawSectionValue ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shouldShowSearchResults {
            let movie = self.viewModel.filteredMovies[indexPath.row]
            navigateToMovieDetailsScreenWith(movie)
        } else {
            switch indexPath.section {
            case MovieSection.allMovies.rawValue:
                let movie = self.viewModel.filteredMovies[indexPath.row]
                navigateToMovieDetailsScreenWith(movie)
            default:
                let searchText = self.viewModel.getTitleForCellWith(indexPath)
                let filteredMovies = self.viewModel.getMoviesListWith(searchText, for: MovieSection(rawValue: indexPath.section) ?? .allMovies)
                showTheMoviesListViewControllerWith(filteredMovies)
            }
        }
    }
    
    func showTheMoviesListViewControllerWith(_ movies: [Movie]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "MoviesListViewController") as? MoviesListViewController else {
            return
        }
        
        destinationViewController.moviesList = movies
        self.navigationController?.pushViewController(destinationViewController, animated: true)

    }
    
    func navigateToMovieDetailsScreenWith(_ selectedMovie: Movie) {
        
        let movieDetailsVC = MovieDetailsViewController(movie: selectedMovie)
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            shouldShowSearchResults = true
            self.viewModel.filterMoviesListWith(searchText)
            self.tableView.reloadData()
            self.reloadTableView { [unowned self] in
                self.tableView.openSection(0, animated: true)
            }
        }        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.resetFilteredMovies()
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
}

