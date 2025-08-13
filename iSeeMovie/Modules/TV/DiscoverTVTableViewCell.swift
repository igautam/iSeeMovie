//
//  DiscoverTableViewCell.swift
//  iSeeMovie
//
//  Created by Tais on 7/12/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import AlamofireImage

class DiscoverTVTableViewCell: BaseTableViewCell, ConfigurableCell {
    
    @IBOutlet var title: UILabel?
    @IBOutlet var tvCollectionView: UICollectionView?
    let arrayCollectionView = ArrayCollectionViewDelegateDataSource<TVModel>()
    var tvCollectionViewModel: TVCollectionViewModel?
    
    override func awakeFromNib() {
        tvCollectionView?.register(UINib(nibName: "TVCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BaseCollectionViewCell")
        tvCollectionView?.delegate = arrayCollectionView
        tvCollectionView?.dataSource = arrayCollectionView
        //Selection Handler
        arrayCollectionView.collectionItemSelectionHandler = { [weak self] indexPath in
            if let movieId = self?.tvCollectionViewModel?.getMovieIdForMovieAtRow(indexPath.row) {
                if movieId != -1 {
                    self?.delegate?.didSelectWithMovieId(movieId: movieId)
                }
            }
        }
        
        arrayCollectionView.collectionWillDisplayCellHandler = { [weak self] indexPath in
            if let viewModel = self?.tvCollectionViewModel,
                let paginatedResponse = self?.tvCollectionViewModel?.paginatedResponse {
                if indexPath.row == (viewModel.items.count - 1) && viewModel.items.count < paginatedResponse.totalResults {
                    self?.fetchData()
                }
            }
        }
    }
    
    func fetchData() {
        tvCollectionViewModel?.fetchModelData(success: { [weak self] tvModelArray in
            DispatchQueue.main.async {
                if let array = tvModelArray {
                    self?.arrayCollectionView.array.append(contentsOf: array)
                    self?.tvCollectionView?.reloadData()
                }
            }
        })
    }
    func configure(data: TVCollectionViewModel) {
        print("title: \(data.title)")
        self.tvCollectionViewModel = data
        title?.text = data.title
        fetchData()
    }
}



//MARK:- CollectionView
class TvCollectionViewCell: ValueCollectionViewCell<TVModel> {
    @IBOutlet var movieImageView: UIImageView?
    
    override var value: TVModel? {
        didSet {
            guard let movie = value else {
                return
            }
            if movie.poster_path == "" {
                if let size = ConfigurationManager.sharedInstance.getBackdropImageSize(for: BackdropSizes.w300) {
                    self.movieImageView?.setBackdropImageWith(movie.backdrop_path, size: size)
                }
            } else {
                if let size = ConfigurationManager.sharedInstance.getPosterImageSize(for: PosterSizes.w154) {
                    self.movieImageView?.setPosterImageWith(movie.poster_path,size: size)
                }
            }
        }
    }
}
