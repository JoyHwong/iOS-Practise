import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.scrollView.frame.size.height)
        self.scrollView.frame = self.view.frame
        
        let w = self.view.frame.size.width
        let h = self.view.frame.size.height
        
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        imageView1.image = UIImage(named: "保罗克利-肖像.png")
        self.scrollView.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x: w, y: 0, width: w, height: h))
        imageView2.image = UIImage(named: "罗丹-思想者.png")
        self.scrollView.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: CGRect(x: 2 * w, y: 0, width: w, height: h))
        imageView3.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        self.scrollView.addSubview(imageView3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / 320
    }

    
    @IBAction func changePage(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: 320 * CGFloat(whichPage), y: 0)
        })
    }
    
}

