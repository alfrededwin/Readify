//
//  OnboardingPageViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2021-01-12.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}


class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource , UIPageViewControllerDelegate {

    // MARK: Properties
    
    weak var onboardDelegate: OnboardingPageViewControllerDelegate?
    
    var pageHeadings = ["SEARCH FOR ANY BOOK THAT YOU LOVE", "MAKE READING SIMPLE AND SIGNIFICANT", "TRACK YOUR OWN READING AND READ MORE"]
    var pageSubHeadings = ["Choose from a wide range of books available in the Readify app. Choose, add & read.", "Read more books and keep on the flow. Never leave a page unturned.", "Structure your reading in a way that is best for you. Get insights of your reading."]
    var pageImages = ["onboarding3", "onboarding2", "onboarding1"]
    
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set datasource and delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first onboarding Screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Page View Controller Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index += 1
        return contentViewController(at: index) 
    }
    
    // MARK : - Helper
    
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
    
    // Create a new View Controller and pass relevant data
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingContentViewController") as?
            OnboardingContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
                currentIndex = contentViewController.index
                onboardDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
