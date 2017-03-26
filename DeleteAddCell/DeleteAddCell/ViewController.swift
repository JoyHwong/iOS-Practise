import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    var listTeams: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Insert and Delete table cell"
        
        self.textField.isHidden = true
        self.textField.delegate = self
        
        self.listTeams = Array(arrayLiteral: "黑龙江", "吉林", "辽宁")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(editing, animated: animated)
    
        self.textField.isHidden = !editing
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")!
        
        let b_addCell = indexPath.row == self.listTeams.count
        
        if b_addCell {
            self.textField.frame = CGRect(x: 40, y: 0, width: 300, height: cell.frame.size.height)
            self.textField.text = ""
            cell.addSubview(self.textField)
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.listTeams[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let stringToMove = self.listTeams[sourceIndexPath.row]
        
        self.listTeams.remove(at: sourceIndexPath.row)
        self.listTeams.insert(stringToMove, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.listTeams.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        } else if (editingStyle == .insert) {
            self.listTeams.insert(self.textField.text!, at: self.listTeams.count)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == self.listTeams.count) {
            return false
        } else {
            return true
        }
    }
}

