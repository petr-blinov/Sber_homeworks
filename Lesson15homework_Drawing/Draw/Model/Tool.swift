//
//  Tool.swift
//  Draw
//
//  Created by Марк Шнейдерман on 05.06.2021.
//

import UIKit

  //MARK: - Enum Instrument
enum ImageTool {
    static let pen = "pencil.circle"
    static let rectangle = "rectangle"
    static let ellipse = "oval"
    static let line = "line.diagonal"
}


  //MARK: - Pen

class ToolPen: UIBezierPath, ToolProtocol {
    
    var imageTool: UIImage?
    var path: CGMutablePath
    var lineColor: UIColor
    var lineAlpha: CGFloat

    override init() {
        path = CGMutablePath.init()
        lineColor = .black
        lineAlpha = 0
        imageTool = UIImage(systemName: ImageTool.pen)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setInitialPoint(_ firstPoint: CGPoint) {}

    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {}

    func createBezierRenderingBox(_ previousPoint2: CGPoint, widhPreviousPoint previousPoint1: CGPoint, withCurrentPoint cpoint: CGPoint) -> CGRect {
        let mid1 = middlePoint(previousPoint1, previousPoint2: previousPoint2)
        let mid2 = middlePoint(cpoint, previousPoint2: previousPoint1)
        let subpath = CGMutablePath.init()

        subpath.move(to: CGPoint(x: mid1.x, y: mid1.y))
        subpath.addQuadCurve(to: CGPoint(x: mid2.x, y: mid2.y), control: CGPoint(x: previousPoint1.x, y: previousPoint1.y))
        path.addPath(subpath)
        
        var boundingBox: CGRect = subpath.boundingBox
        boundingBox.origin.x -= lineWidth * 2.0
        boundingBox.origin.y -= lineWidth * 2.0
        boundingBox.size.width += lineWidth * 4.0
        boundingBox.size.height += lineWidth * 4.0

        return boundingBox
    }

    private func middlePoint(_ previousPoint1: CGPoint, previousPoint2: CGPoint) -> CGPoint {
        return CGPoint(x: (previousPoint1.x + previousPoint2.x) * 0.5, y: (previousPoint1.y + previousPoint2.y) * 0.5)
    }
    
    func draw() {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.addPath(path)
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(lineColor.cgColor)
        ctx.setAlpha(lineAlpha)
        ctx.strokePath()
    }
}

  //MARK: - Rectangle

class ToolRect: ToolProtocol {
    var lineWidth: CGFloat
    var lineAlpha: CGFloat
    var lineColor: UIColor
    var firstPoint: CGPoint
    var lastPoint: CGPoint
    var imageTool: UIImage?

    init() {
        lineWidth = 1.0
        lineAlpha = 1.0
        lineColor = .blue
        firstPoint = CGPoint(x: 0, y: 0)
        lastPoint = CGPoint(x: 0, y: 0)
        imageTool = UIImage(systemName: ImageTool.rectangle)
        
    }

    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }

    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }

    func draw() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let rectToFill = CGRect(x: firstPoint.x, y: firstPoint.y, width: lastPoint.x - self.firstPoint.x, height: lastPoint.y - firstPoint.y)
        
        context.setAlpha(lineAlpha)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        context.stroke(rectToFill)
    }
}

  //MARK: - Ellipse

class ToolEllipse : ToolProtocol {

    
    var lineWidth: CGFloat
    var lineColor: UIColor
    var lineAlpha: CGFloat
    var firstPoint : CGPoint
    var lastPoint : CGPoint
    var imageTool : UIImage?

    init() {
        lineWidth = 1.0
        lineColor = .blue
        lineAlpha = 1.0
        firstPoint = CGPoint(x: 0, y: 0)
        lastPoint =  CGPoint(x: 0, y: 0)
        imageTool = UIImage(systemName: ImageTool.ellipse)
    }

    func draw() {
        guard  let context = UIGraphicsGetCurrentContext() else {return}
        let rectToFill = CGRect(x: firstPoint.x, y: firstPoint.y, width: lastPoint.x - self.firstPoint.x, height: lastPoint.y - firstPoint.y) // добавляет CGRectпрямоугольник к текущему контуру контекста, который нужно нарисовать.
        context.setAlpha(lineAlpha)
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        context.strokeEllipse(in:rectToFill)
    }
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }

    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }
}

class ToolLine : ToolProtocol {
    var lineWidth: CGFloat
    var lineColor: UIColor
    var lineAlpha: CGFloat
    var firstPoint: CGPoint
    var lastPoint: CGPoint
    var imageTool: UIImage?

    init() {
        lineWidth = 1.0
        lineAlpha = 1.0
        lineColor = .blue
        firstPoint = CGPoint(x: 0, y: 0)
        lastPoint = CGPoint(x: 0, y: 0)
        imageTool = UIImage(systemName: ImageTool.line)
    }

    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }

    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }

    func draw() {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setStrokeColor(lineColor.cgColor)
        ctx.setLineCap(.square)
        ctx.setLineWidth(lineWidth)
        ctx.setAlpha(lineAlpha)
        ctx.move(to: CGPoint(x: firstPoint.x, y: firstPoint.y))
        ctx.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        ctx.strokePath()
    }

    func angleWithFirstPoint(first: CGPoint, second: CGPoint) -> Float {
        let dx: CGFloat = second.x - first.x
        let dy: CGFloat = second.y - first.y
        let angle = atan2f(Float(dy), Float(dx))

        return angle
    }

    func pointWithAngle(angle: CGFloat, distance: CGFloat) -> CGPoint {
        let x = Float(distance) * cosf(Float(angle))
        let y = Float(distance) * sinf(Float(angle))

        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
}
