import UIKit
import os

class OverlayView: UIImageView {

    private enum Config {
            static let dot = (radius: CGFloat(10), color: UIColor.orange)
            static let line = (width: CGFloat(10.0), color: UIColor.orange)
            static let angleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 150),
                .foregroundColor: UIColor.white
            ]
            static let warningTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24),
                .foregroundColor: UIColor.red
            ]
        }

        private let warningLabel: UILabel = {
            let label = UILabel()
            label.text = "⚠︎ SHOW YOUR SIDE PROFILE"
            label.textColor = .red
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            label.isHidden = true // Initially hidden
            return label
        }()
      
        private static let lines = [
            (from: BodyPart.leftElbow, to: BodyPart.leftShoulder),
            (from: BodyPart.rightShoulder, to: BodyPart.rightElbow),
            (from: BodyPart.leftShoulder, to: BodyPart.leftHip),
            (from: BodyPart.rightHip, to: BodyPart.rightShoulder),
        ]
      
        var context: CGContext!

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupWarningLabel()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupWarningLabel()
        }

        private func setupWarningLabel() {
            addSubview(warningLabel)
            warningLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                warningLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                warningLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }

        func draw(at image: UIImage, person: Person, shoulderSide: ShoulderSide) {
            if context == nil {
                UIGraphicsBeginImageContext(image.size)
                guard let context = UIGraphicsGetCurrentContext() else {
                    fatalError("Failed to get current context")
                }
                self.context = context
            }
            image.draw(at: .zero)
            context.setLineWidth(Config.dot.radius)

            // Draw only the selected shoulder
            if shoulderSide == .left {
                drawLeftShoulder(person: person)
            } else {
                drawRightShoulder(person: person)
            }

            checkShoulderDistance(person: person)
            context.setStrokeColor(UIColor.white.cgColor)
            context.strokePath()
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { fatalError() }
            self.image = newImage
        }

        private func checkShoulderDistance(person: Person) {
            guard let leftShoulder = getKeyPointPosition(of: .leftShoulder, in: person),
                  let rightShoulder = getKeyPointPosition(of: .rightShoulder, in: person) else {
                warningLabel.isHidden = true
                return
            }

            let shoulderDistance = abs(leftShoulder.x - rightShoulder.x)
            if shoulderDistance > 150 {
                warningLabel.isHidden = false // Show warning if distance exceeds threshold
            } else {
                warningLabel.isHidden = true // Hide warning if within threshold
            }
        }
    /// nameing is opposite of drawRightShoulder because of mirroring
        private func drawRightShoulder(person: Person) {
            if let leftShoulder = getKeyPointPosition(of: .leftShoulder, in: person),
               let leftElbow = getKeyPointPosition(of: .leftElbow, in: person),
               let leftHip = getKeyPointPosition(of: .leftHip, in: person) {

                let leftShoulderAngle = Int(calculateAngle(pointA: leftElbow, pointB: leftShoulder, pointC: leftHip))
                let leftAngleText = String(format: "%d°", 180 - leftShoulderAngle)
                
                let leftAnglePosition = CGPoint(x: leftShoulder.x + 20, y: leftShoulder.y - 10)
                leftAngleText.draw(at: leftAnglePosition, withAttributes: Config.angleTextAttributes)
                
                drawLine(from: leftShoulder, to: leftElbow)
                drawLine(from: leftShoulder, to: leftHip)
            }
        }
/// nameing is opposite of drawLeftShoulder because of mirroring 
        private func drawLeftShoulder(person: Person) {
            if let rightShoulder = getKeyPointPosition(of: .rightShoulder, in: person),
               let rightElbow = getKeyPointPosition(of: .rightElbow, in: person),
               let rightHip = getKeyPointPosition(of: .rightHip, in: person) {
                
                let rightShoulderAngle = Int(calculateAngle(pointA: rightElbow, pointB: rightShoulder, pointC: rightHip))
                let rightAngleText = String(format: "%d°", 180 - rightShoulderAngle )
                
                let rightAnglePosition = CGPoint(x: rightShoulder.x - 300, y: rightShoulder.y - 10)
                rightAngleText.draw(at: rightAnglePosition, withAttributes: Config.angleTextAttributes)
                
                drawLine(from: rightShoulder, to: rightElbow)
                drawLine(from: rightShoulder, to: rightHip)
            }
        }

        private func getKeyPointPosition(of bodyPart: BodyPart, in person: Person) -> CGPoint? {
            guard let index = BodyPart.allCases.firstIndex(of: bodyPart) else { return nil }
            return CGPoint(
                x: person.keyPoints[index].coordinate.x,
                y: person.keyPoints[index].coordinate.y)
        }

        private func calculateAngle(pointA: CGPoint, pointB: CGPoint, pointC: CGPoint) -> CGFloat {
            let vectorAB = CGPoint(x: pointA.x - pointB.x, y: pointB.y - pointA.y)
            let vectorBC = CGPoint(x: pointC.x - pointB.x, y: pointC.y - pointB.y)
            let dotProduct = vectorAB.x * vectorBC.x + vectorAB.y * vectorBC.y
            let magnitudeAB = hypot(vectorAB.x, vectorAB.y)
            let magnitudeBC = hypot(vectorBC.x, vectorBC.y)
            let cosineAngle = dotProduct / (magnitudeAB * magnitudeBC)
            return acos(cosineAngle) * (180 / .pi) // Convert radians to degrees
        }
      
        private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
            context.move(to: startPoint)
            context.addLine(to: endPoint)
        }
}

/// The strokes to be drawn in order to visualize a pose estimation result.
fileprivate struct Strokes {
  var dots: [CGPoint]
  var lines: [Line]
}

/// A straight line.
fileprivate struct Line {
  let from: CGPoint
  let to: CGPoint
}

fileprivate enum VisualizationError: Error {
  case missingBodyPart(of: BodyPart)
}
