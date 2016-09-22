//
//  InterfaceController.swift
//  WatchOS2-NewAPI-UIBezierPath-Example WatchKit Extension
//
//  Created by Wlad Dicario on 01/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Interface
    @IBOutlet var drawImage: WKInterfaceImage!
    
    // MARK: - Properties
    fileprivate let color = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    fileprivate let scale = WKInterfaceDevice.current().screenScale
    fileprivate let circleDash:Bool = true // false to draw a classic circle
    
    // MARK: - Calls
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        drawUIBezierPathInImage()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}

//MARK: - DrawUIBezierPath -> InterfaceController Extension
typealias DrawUIBezierPath = InterfaceController
extension DrawUIBezierPath {
    
    fileprivate func drawUIBezierPathInImage() {
        // Begin context for image
        UIGraphicsBeginImageContextWithOptions(self.contentFrame.size, false, scale)
        
        // Define content frame, center, radius
        let contentFrameWidth = self.contentFrame.size.width
        let contentFrameHeight = self.contentFrame.size.height
        let center = CGPoint(x: contentFrameWidth / 2.0, y: contentFrameHeight / 2.0)
        let radius = min(contentFrameWidth / 2.0, contentFrameHeight / 2.0) - 2
        
        // Set Color, Circle, Stroke, LineWidth
        let strokeColor = color
        let circle:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        circle.lineWidth = 2.0
        strokeColor.setStroke()
        
        if circleDash {
            let dashes:[CGFloat] = [circle.lineWidth * 0, circle.lineWidth * 2]
            circle.setLineDash(dashes, count: dashes.count, phase: 0)
            circle.lineCapStyle = .round
        }
        // Draw line / dashes for circle
        circle.stroke()
        
        // Set text title with attributes
        let title:String = "UIBezierPath"
        let rectTitle = CGRect(x: center.x - radius / 4.0, y: center.y - radius / 4.0, width: radius / 2.0, height: radius / 2.0)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : color.cgColor,
            NSFontAttributeName : UIFont.systemFont(ofSize: 8),
            NSParagraphStyleAttributeName : textStyle
        ]
        title.draw(in: rectTitle, withAttributes: textAttributes)
        
        // Context create image
        let drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Drawing in WKInterfaceImage
        self.drawImage.setImage(drawingImage)
    }
}
