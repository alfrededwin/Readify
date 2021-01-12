//
//  OnboardingViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2021-01-12.
//
// Reference : https://www.youtube.com/watch?v=1F_HVMHocdA&t=3375s

import UIKit

class OnboardingViewController: UIViewController, OnboardingPageViewControllerDelegate {

    // MARK - Outlets
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    // MARK: - Properties
    
    var onboardingPageViewController: OnboardingPageViewController?
    
    // MARK - Actions
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewOnboarding")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = onboardingPageViewController?.currentIndex {
            switch index {
            case 0...1:
                onboardingPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewOnboarding")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        updateUI()
    }
    
    // MARK : - View Controller Life Cycle
    func updateUI() {
        if let index = onboardingPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = true
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardDelegate = self
        }
        
    }
 

}
