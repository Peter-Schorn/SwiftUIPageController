import SwiftUI
import AppKit

struct PageView<Page: View>: NSViewControllerRepresentable {
    
    let pages: [Page]
    
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeNSViewController(context: Context) -> NSPageController {
        
        print("makeNSViewController")

        let pageController = NSPageController()
        pageController.view = NSView()
        pageController.transitionStyle = .horizontalStrip
        pageController.delegate = context.coordinator
        pageController.arrangedObjects = Array(self.pages.indices)
        pageController.selectedIndex = self.currentPage
        
        return pageController
        
    }
    
    func updateNSViewController(
        _ pageController: NSPageController,
        context: Context
    ) {
        
        print("updateNSViewController")
        
        if pageController.selectedIndex != self.currentPage {
            DispatchQueue.main.async {
                pageController.animator().selectedIndex = self.currentPage
            }
        }
        
    }
    
    class Coordinator: NSObject, NSPageControllerDelegate {
        
        let parent: PageView
        let viewControllers: [NSViewController]
        
        init(_ pageController: PageView) {
            self.parent = pageController
            self.viewControllers = parent.pages.map {
                NSHostingController(rootView: $0)
            }
        }
        
        func pageController(
            _ pageController: NSPageController,
            identifierFor object: Any
        ) -> NSPageController.ObjectIdentifier {
            
         return String(describing: object)
            
        }
        
        func pageController(
            _ pageController: NSPageController,
            viewControllerForIdentifier identifier: NSPageController.ObjectIdentifier
        ) -> NSViewController {
            
            let index = Int(identifier)!
            return self.viewControllers[index]
            
        }
        
        func pageController(
            _ pageController: NSPageController,
            didTransitionTo object: Any
        ) {
            
            DispatchQueue.main.async {
                self.parent.currentPage = pageController.selectedIndex
            }
            
        }
        
        func pageControllerDidEndLiveTransition(
            _ pageController: NSPageController
        ) {
            pageController.completeTransition()
        }
        
    }
    
}
