import UIKit

enum DirectionForward: Int {
    case Before = 1
    case After = 2
}

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageIndex = 0
    
    var directionForward = DirectionForward.After
    var viewControllers: [UIViewController]!
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageViewController1 = UIViewController()
        let pageViewController2 = UIViewController()
        let pageViewController3 = UIViewController()
        
        self.viewControllers = [pageViewController1, pageViewController2, pageViewController3]
        
        let imageView1 = UIImageView(frame: self.view.frame)
        imageView1.image = UIImage(named: "保罗克利-肖像.png")
        pageViewController1.view.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: self.view.frame)
        imageView2.image = UIImage(named: "罗丹-思想者.png")
        pageViewController2.view.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: self.view.frame)
        imageView3.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        pageViewController3.view.addSubview(imageView3)
        
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.pageViewController.setViewControllers([pageViewController1], direction: .forward, animated: true, completion: nil)
        
        self.view.addSubview(self.pageViewController.view)
        
        pageIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageIndex -= 1
        
        if (pageIndex < 0) {
            pageIndex = 0
            return nil
        }
        directionForward = .Before
        return self.viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageIndex += 1
        
        if (pageIndex > 2) {
            pageIndex = 2
            return nil
        }
        directionForward = .After
        return self.viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        self.pageViewController.isDoubleSided = false
        return .min
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed == false) {
            if (directionForward == .After) {
                pageIndex -= 1
            }
            if (directionForward == .Before) {
                pageIndex += 1
            }
        }
    }
}

