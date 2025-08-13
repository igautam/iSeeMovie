//
//  VideoDetailTitleViewTableViewCell.swift
//  iSeeMovies
//
//  Created by Himanshu Juneja on 06/07/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import AlamofireImage
class VideoDetailTitleTableViewCell: BaseTableViewCell, ConfigurableCell {

    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var userScoreView: CircularProgressView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoThumbImageView: UIImageView!
    @IBOutlet weak var videoBannerImageView: UIImageView!
    var circularProgressView: CircularProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(data: MovieModel) {
        overViewLabel.text = data.overview
        videoTitleLabel.text = data.title
        if let size = ConfigurationManager.sharedInstance.getBackdropImageSize(for: BackdropSizes.w1280), let backdrop_path = data.backdrop_path {
            videoBannerImageView.setBackdropImageWith(backdrop_path, size: size)
        }
        if let size = ConfigurationManager.sharedInstance.getPosterImageSize(for: PosterSizes.w185) {
            videoThumbImageView.setPosterImageWith(data.poster_path, size: size)
        }
        
        circularProgressView?.removeFromSuperview()
        if let circularProgressView = CircularProgressView.instanceFromNib() {
            self.circularProgressView = circularProgressView
            circularProgressView.layer.cornerRadius = circularProgressView.frame.size.width/2;
            self.addSubview(circularProgressView)
            bringSubviewToFront(circularProgressView)
            circularProgressView.drawCircularProgress(withProgress: data.voteAverage)
        }
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
        let topLayout = NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: .equal, toItem: videoThumbImageView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 17)
        let leadingLayout = NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 40)
        
        self.addConstraint(heightContraints)
        self.addConstraint(widthContraints)
        self.addConstraint(topLayout)
        self.addConstraint(leadingLayout)
    }

}
