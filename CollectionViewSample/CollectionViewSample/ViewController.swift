import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var events: Array<Dictionary<String, String>>!
    
    let COL_NUM = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "events", ofType: "plist")
        self.events = NSArray(contentsOfFile: plistPath!) as! Array<Dictionary<String, String>>
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = self.events.count % COL_NUM
        if (num == 0) {
            return self.events.count / COL_NUM
        } else {
            return self.events.count / COL_NUM + 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! EventCollectionViewCell
        
        let event = self.events[indexPath.section * COL_NUM + indexPath.row]
        
        cell.label.text = event["name"]
        cell.imageView.image = UIImage(named: event["image"]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events[indexPath.section * COL_NUM + indexPath.row]
        NSLog("select event name: \(event["name"]!)")
    }
}

