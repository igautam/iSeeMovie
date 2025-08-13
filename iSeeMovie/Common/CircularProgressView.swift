//
//  CircularProgressView.swift
//
//
//

import UIKit

/// This class is responsible for UI imaplementation of project funding state view which show the progress indicator with percentage 
class CircularProgressView: UIView {
    
    //MARK: @IBOutlet
    @IBOutlet weak var fundingStateLabel: UILabel!
    
    //MARK: Constants
    private let lineWidth: CGFloat = 3.0
    
    //MARK: View Life Cycle
    class func instanceFromNib() -> CircularProgressView? {
        if let progressView = Bundle.main.loadNibNamed("CircularProgressView", owner: self, options: nil)?.first as? CircularProgressView {
            return progressView
        }
        return nil
    }
    
    override func layoutSubviews() {
        //layoutCircularProgressView()
    }
    
    /**
     Setting autolayout of funding state view
     */
    func layoutCircularProgressView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightContraints = NSLayoutConstraint(item: self, attribute:
            .height, relatedBy: .equal, toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0,
            constant: 70)
        let widthContraints = NSLayoutConstraint(item: self, attribute:
            .width, relatedBy: .equal, toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0,
            constant: 70)
        let topLayout = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 130)
        let trailingLayout = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -20)
        
        self.superview!.addConstraint(heightContraints)
        self.superview!.addConstraint(widthContraints)
        self.superview!.addConstraint(trailingLayout)
        self.superview!.addConstraint(topLayout)

    }
    
    //MARK: Public Methods
    
    /**
    Drawing project funding as circular progress with percentage
    
    - parameter progress:     progress in percentage
    - parameter projectState: can be pitch, pilot, series
    */
    
    internal func drawCircularProgress(withProgress progress: Double) {
        DispatchQueue.main.async {
            self.fundingStateLabel.text = "\(Int(progress * 10))%"
            let progress = (progress*10) / 100.0
            let endAngle: CGFloat = CGFloat( (Double.pi * 2 * Double(progress)) - Double.pi/2)
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2,y: self.frame.height/2), radius: CGFloat(self.frame.width/2 - 5), startAngle: CGFloat(-Double.pi/2), endAngle:endAngle, clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            //change the fill color
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.green.cgColor
            //you can change the line width
            shapeLayer.lineWidth = self.lineWidth
            self.layer.addSublayer(shapeLayer)
        }
    }
}
