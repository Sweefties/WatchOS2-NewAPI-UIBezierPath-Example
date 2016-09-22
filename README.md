![](https://img.shields.io/badge/build-pass-brightgreen.svg?style=flat-square)
![](https://img.shields.io/badge/platform-WatchOS2-ff69b4.svg?style=flat-square)
![](https://img.shields.io/badge/Require-XCode%208-lightgrey.svg?style=flat-square)


# WatchOS2 - New API - UIBezierPath - Example
WatchOS 2 Experiments - New API Components - Drawing with UIBezierPath

## Example

![](https://raw.githubusercontent.com/Sweefties/WatchOS2-NewAPI-UIBezierPath-Example/master/source/Apple_Watch_template-UIBezierPath.jpg)

## Requirements

- >= XCode 8.0.
- >= Swift 3.

Tested on WatchOS2 Simulator.

## Important

this is the Xcode 8 / Swift 3 updated project.

## Usage

To run the example project, download or clone the repo.

### Example Code!


Configure your Storyboard :

- Drag and drop WKInterfaceImage to Interface Controller
- connect your WKInterfaceImage `image` to your Interface Controller class
- put code to your controller class.

```swift
// Begin context for image
UIGraphicsBeginImageContextWithOptions(self.contentFrame.size, false, scale)

// Define content frame, center, radius
let contentFrameWidth = self.contentFrame.size.width
let contentFrameHeight = self.contentFrame.size.height
let center = CGPointMake(contentFrameWidth / 2.0, contentFrameHeight / 2.0)
let radius = min(contentFrameWidth / 2.0, contentFrameHeight / 2.0) - 2

// Set Color, Circle, Stroke, LineWidth
let strokeColor = color
let circle:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
circle.lineWidth = 2.0
strokeColor.setStroke()

if circleDash {
    let dashes:[CGFloat] = [circle.lineWidth * 0, circle.lineWidth * 2]
    circle.setLineDash(dashes, count: dashes.count, phase: 0)
    circle.lineCapStyle = .Round
}
// Draw line / dashes for circle
circle.stroke()

// Set text title with attributes
let title:String = "UIBezierPath"
let rectTitle = CGRectMake(center.x - radius / 4.0, center.y - radius / 4.0, radius / 2.0, radius / 2.0)
let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
textStyle.alignment = NSTextAlignment.Center

let textAttributes: [String: AnyObject] = [
    NSForegroundColorAttributeName : color.CGColor,
    NSFontAttributeName : UIFont.systemFontOfSize(8),
    NSParagraphStyleAttributeName : textStyle
]
title.drawInRect(rectTitle, withAttributes: textAttributes)

// Context create image
let drawingImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()

// Drawing in WKInterfaceImage
self.drawImage.setImage(drawingImage)
```


Build and Run!
