//
//  DiscoverMovieTableViewCell.swift
//  iSeeMovie
//
//  Created by Tais on 7/21/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import Combine

class DiscoverMovieTopTableViewCell: BaseTableViewCell, ConfigurableCell {
    @IBOutlet var movieCollectionView: UICollectionView?
    var circularProgressView: CircularProgressView?
    
    let arrayCollectionView = ArrayCollectionViewDelegateDataSource<MovieModel>()
    var movieCollectionViewModel: MovieCollectionViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCollectionView()
    }
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.frame.size.width, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        movieCollectionView?.collectionViewLayout = layout
    }
    
    func configureCollectionView() {
        movieCollectionView?.register(UINib(nibName: "BackDropMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BaseCollectionViewCell")
        movieCollectionView?.delegate = arrayCollectionView
        movieCollectionView?.dataSource = arrayCollectionView
        movieCollectionView?.isPagingEnabled = true
        
        arrayCollectionView.collectionItemSelectionHandler = { [weak self] indexPath in
            if let movieId = self?.movieCollectionViewModel?.getMovieIdForMovieAtRow(indexPath.row) {
                if movieId != -1 {
                    self?.delegate?.didSelectWithMovieId(movieId: movieId)
                }
            }
        }
        
        arrayCollectionView.collectionWillDisplayCellHandler = { [weak self] indexPath in
            if let viewModel = self?.movieCollectionViewModel,
                let paginatedResponse = self?.movieCollectionViewModel?.paginatedResponse {
                if indexPath.row == (viewModel.items.count - 1) && viewModel.items.count < paginatedResponse.totalResults {
                    self?.fetchData()
                }
            }
        }
        
    }
    
    func fetchData() {
        movieCollectionViewModel?.$items.sink { [self] movies in
            DispatchQueue.main.async {
                self.arrayCollectionView.array.append(contentsOf: movies)
                self.movieCollectionView?.reloadData()
            }
        }.store(in: &cancellable)
        movieCollectionViewModel?.discoverUpComingMoviesCurrentYear()
//        movieCollectionViewModel?.discoverUpComingMoviesCurrentYear(success: { [weak self] tvModelArray in
//            if let array = tvModelArray {
//                self?.arrayCollectionView.array.append(contentsOf: array)
//                self?.movieCollectionView?.reloadData()
//            }
//        })
    }
    
    func configure(data: MovieCollectionViewModel) {
        self.movieCollectionViewModel = data
        self.arrayCollectionView.array = data.items
    }
}

//MARK:- CollectionView
class BackDropMovieCollectionViewCell: ValueCollectionViewCell<MovieModel> {
    @IBOutlet var movieImageView: UIImageView?
    @IBOutlet var title: UILabel?
    @IBOutlet var releaseDate: UILabel?
    
    
    var circularProgressView: CircularProgressView?
    
    override var value: MovieModel? {
        didSet {
            guard let movie = value else {
                return
            }
            if movie.backdrop_path == "" {
                if let size = ConfigurationManager.sharedInstance.getPosterImageSize(for: PosterSizes.wOriginal) {
                    self.movieImageView?.setPosterImageWith(movie.poster_path,size: size)
                }
            } else {
                if let size = ConfigurationManager.sharedInstance.getBackdropImageSize(for: BackdropSizes.w780), let backdrop_path = movie.backdrop_path {
                    self.movieImageView?.setBackdropImageWith(backdrop_path, size: size)
                }
            }
            
            title?.text = movie.title
            releaseDate?.text = movie.release_date
            circularProgressView?.removeFromSuperview()
            if let circularProgressView = CircularProgressView.instanceFromNib() {
                self.circularProgressView = circularProgressView
                circularProgressView.layer.cornerRadius = circularProgressView.frame.size.width/2;
                self.addSubview(circularProgressView)
                bringSubviewToFront(circularProgressView)
                circularProgressView.drawCircularProgress(withProgress: movie.voteAverage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        layoutCircularProgressView()
    }
    
    func layoutCircularProgressView() {
        guard let progressView = circularProgressView else {
            return
        }
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let heightContraints = NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40)
        
        let widthContraints = NSLayoutConstraint(item: progressView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0,constant: 40)
        let bottomLayout = NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -5)
        let leadingLayout = NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 5)
        
        self.addConstraint(heightContraints)
        self.addConstraint(widthContraints)
        self.addConstraint(bottomLayout)
        self.addConstraint(leadingLayout)
    }
}


