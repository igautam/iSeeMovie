//
//  VideoDetailOverviewTableViewCell.swift
//  iSeeMovies
//
//  Created by Himanshu Juneja on 06/07/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit

class VideoDetailCastCrewTableViewCell: BaseTableViewCell, ConfigurableCell {

    @IBOutlet var featuredCrewView: UIView?
    @IBOutlet weak var castCollectionView: UICollectionView!
    let arrayCollectionView = ArrayCollectionViewDelegateDataSource<Cast>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castCollectionView?.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BaseCollectionViewCell")
        castCollectionView?.delegate = arrayCollectionView
        castCollectionView?.dataSource = arrayCollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 160)
        //layout.estimatedItemSize = CGSize(width: 100, height: 160)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        castCollectionView?.collectionViewLayout = layout
    }
    
    
    func configure(data: MovieCredit) {
        self.arrayCollectionView.array = data.casts
        castCollectionView.reloadData()
    }
    
}

//MARK:- CollectionView
class CastCollectionViewCell: ValueCollectionViewCell<Cast> {
    @IBOutlet var castImageView: UIImageView?
    @IBOutlet var name: UILabel?
    @IBOutlet var character: UILabel?
    
    override var value: Cast? {
        didSet {
            guard let cast = value else {
                return
            }
            name?.text = cast.name
            character?.text = cast.character
            if let size = ConfigurationManager.sharedInstance.getProfileImageSize(for: ProfileSizes.w185), let profile_path = cast.profile_path {
                self.castImageView?.setBackdropImageWith(profile_path, size: size)
            }
        }
    }
}

