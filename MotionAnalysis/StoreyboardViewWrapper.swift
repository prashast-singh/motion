import SwiftUI
import UIKit

struct StoryboardViewWrapper: UIViewControllerRepresentable {
    var shoulderSide: ShoulderSide // Enum for left or right shoulder
    
    func makeUIViewController(context: Context) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.selectedShoulder = shoulderSide // Pass shoulder side to ViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}


