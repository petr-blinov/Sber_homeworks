//
//  DrawView.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

//MARK: - Enum Tool
public enum ToolType {
    case pen
    case line
    case rectangle
    case ellipse
}

//MARK: - DrawView
public class DrawView: UIView {
    
    //MARK: - Private Properties
    public var lineColor = UIColor.black
    public var lineWidth = CGFloat(10)
    public var lineAlpha = CGFloat(1)
    public var drawTool: ToolType = .line
    public var image: UIImage?
    
    //MARK: - Public Properties
    private var currentTool: ToolProtocol?
    private let pathArray: NSMutableArray = NSMutableArray()
    private let bufferArray: NSMutableArray = NSMutableArray()
    private var currentPoint: CGPoint?
    private var previousPoint1: CGPoint?
    private var previousPoint2: CGPoint?
    private var backgroundImage: UIImage?

    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInitial()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        prepareForInitial()
    }

    
    private func prepareForInitial() {
        backgroundColor = UIColor.clear    }

    //MARK: - Draw
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        image?.draw(at: CGPoint.zero)
        currentTool?.draw()
    }
    

      //MARK: - Cache 
    private func updateCacheImage(_ isUpdate: Bool) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)

        if isUpdate {
            image = nil
            if let backgroundImage = backgroundImage  {
            (backgroundImage.copy() as! UIImage).draw(at: CGPoint.zero)
            }

            for obj in pathArray {
                if let tool = obj as? ToolProtocol {
                    tool.draw()
                }
            }
        } else {
            image?.draw(at: .zero)
            currentTool?.draw()
        }

        /// Create Image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    private func toolWithCurrentSettings() -> ToolProtocol? {
        switch drawTool {
        case .pen:
            return ToolPen()
        case .line:
            return ToolLine()
        case .rectangle:
            let rectTool = ToolRect()
            return rectTool
        case .ellipse:
            let ellipse = ToolEllipse()
            return ellipse
        }
    }

      //MARK: - Touch Began
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        if currentTool != nil {
            finishDrawing()
        }

        previousPoint1 = touch.previousLocation(in: self)
        currentPoint = touch.location(in: self)
        currentTool = toolWithCurrentSettings()
        currentTool?.lineWidth = lineWidth
        currentTool?.lineColor = lineColor
        currentTool?.lineAlpha = lineAlpha
        
        switch currentTool! {
        case is ToolPen :
            guard let penTool = currentTool as? ToolPen else { return }
            pathArray.add(penTool)
        default:
            guard let currentTool = currentTool else { return }
            pathArray.add(currentTool)
            currentTool.setInitialPoint(currentPoint!)
        }
    }

      //MARK: - Touch Moved
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        previousPoint2 = previousPoint1
        previousPoint1 = touch.previousLocation(in: self)
        currentPoint = touch.location(in: self)

        if let penTool = currentTool as? ToolPen {
            let renderingBox = penTool.createBezierRenderingBox(previousPoint2!, widhPreviousPoint: previousPoint1!, withCurrentPoint: currentPoint!)

            setNeedsDisplay(renderingBox)
        } else {
            currentTool?.moveFromPoint(previousPoint1!, toPoint: currentPoint!)
            setNeedsDisplay()
        }
        
      
    }

      //MARK: - Touch Ended
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesMoved(touches, with: event)
        finishDrawing()
    }

    fileprivate func finishDrawing() {
        updateCacheImage(false)
        currentTool = nil
    }

    private func resetTool() {
        currentTool = nil
    }
    
      //MARK: - Undo
    
    public func undo() {
        if canUndo() {
            resetTool()
            pathArray.removeLastObject()
            updateCacheImage(true)
            setNeedsDisplay()
        }
    }
    
    public func canUndo() -> Bool {
        return pathArray.count > 0
    }
}
