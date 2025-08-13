//
//  DiscoverTableViewCell.swift
//  iSeeMovie
//
//  Created by Tais on 7/12/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import AlamofireImage
import Combine


class DiscoverMovieTableViewCell: BaseTableViewCell, ConfigurableCell {
    
    @IBOutlet var title: UILabel?
    @IBOutlet var movieCollectionView: UICollectionView?
    let arrayCollectionView = ArrayCollectionViewDelegateDataSource<MovieModel>()
    var movieCollectionViewModel: MovieCollectionViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        movieCollectionView?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BaseCollectionViewCell")
        movieCollectionView?.delegate = arrayCollectionView
        movieCollectionView?.dataSource = arrayCollectionView
        //Selection Handler
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
                self.movieCollectionViewModel?.isLoadingPages = false
                self.arrayCollectionView.array.append(contentsOf: movies)
                self.movieCollectionView?.reloadData()
            }
        }.store(in: &cancellable)
        
        movieCollectionViewModel?.isLoadingPages = true
        movieCollectionViewModel?.fetchModelData()
//        movieCollectionViewModel?.fetchModelData(success: { [weak self] tvModelArray in
//            if let array = tvModelArray {
//                self?.movieCollectionViewModel?.isLoadingPages = false
//                self?.arrayCollectionView.array.append(contentsOf: array)
//                self?.movieCollectionView?.reloadData()
//            }
//        })
    }
    
    func configure(data: MovieCollectionViewModel) {
        print("title: \(data.title)")
        self.movieCollectionViewModel = data
        title?.text = data.title
        self.arrayCollectionView.array = data.items
    }
}

//MARK:- CollectionView
class MovieCollectionViewCell: ValueCollectionViewCell<MovieModel> {
    @IBOutlet var movieImageView: UIImageView?
    
    override var value: MovieModel? {
        didSet {
            guard let movie = value else {
                return
            }
            if movie.poster_path == "" {
                if let size = ConfigurationManager.sharedInstance.getBackdropImageSize(for: BackdropSizes.w300), let backdrop_path = movie.backdrop_path {
                    self.movieImageView?.setBackdropImageWith(backdrop_path, size: size)
                }
            } else {
                if let size = ConfigurationManager.sharedInstance.getPosterImageSize(for: PosterSizes.w154) {
                    self.movieImageView?.setPosterImageWith(movie.poster_path,size: size)
                }
            }
        }
    }
}


/*
class DiscoverTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet var title: UILabel?
    @IBOutlet var movieCollectionView: UICollectionView?
    
    
    
    @IBOutlet var releaseDate: UILabel?
    @IBOutlet var posterImageView: UIImageView?
    @IBOutlet var videoCardView: UIView?
    var circularProgressView: CircularProgressView?
    
    
    override func awakeFromNib() {
        movieCollectionView?.register(UINib(nibName: "KeepWatchingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeepWatchingCollectionViewCell")
        
        
        if let circularProgressView = CircularProgressView.instanceFromNib() {
            self.circularProgressView = circularProgressView
            circularProgressView.layer.cornerRadius = circularProgressView.frame.size.width/2;
            self.videoCardView?.addSubview(circularProgressView)
            self.circularProgressView?.isHidden = true
            bringSubview(toFront: circularProgressView)

        }
       
    }
    
    func setVideoCardView() {
        let shadowPath = UIBezierPath(rect: (videoCardView?.bounds)!)
        videoCardView?.layer.masksToBounds = false
        videoCardView?.layer.shadowColor = UIColor.black.cgColor
        videoCardView?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        videoCardView?.layer.shadowOpacity = 0.5
        videoCardView?.layer.shadowPath = shadowPath.cgPath
    }
    
    
    func configure(data: MovieCollectionViewModel) {
//        circularProgressView?.isHidden = false
//        title?.text = data.title
//        releaseDate?.text = data.release_date
//        circularProgressView?.drawCircularProgress(withProgress: data.voteAverage)
//        posterImageView?.setPosterImageWith(data.poster_path)
    }
    
    
    /**
     Setting Auto layout of funding state view
     */
    override func layoutSubviews() {
//        setVideoCardView()
//        layoutCircularProgressView()
    }
    
    func layoutCircularProgressView() {
        guard let progressView = circularProgressView else {
            return
        }
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let heightContraints = NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 40)
        
        let widthContraints = NSLayoutConstraint(item: progressView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,constant: 40)
        let bottomLayout = NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: self.videoCardView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -5)
        let leadingLayout = NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: self.videoCardView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 5)
        
        self.addConstraint(heightContraints)
        self.addConstraint(widthContraints)
        self.addConstraint(bottomLayout)
        self.addConstraint(leadingLayout)
    }
    
}

*/
