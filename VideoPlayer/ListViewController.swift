//
//  ListViewController.swift
//  VideoPlayer
//
//  Created by Neven on 8/17/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate:class {
    func didTapOnListRow(listString: String)
}

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var listTableView: UITableView?
    weak var delegate: ListViewControllerDelegate?
    var selectedListString: String?
    
    let listArray: [String] = ["1","2","Calendar","Camera Controller","Coach Marks","Comment Compose","Compose Screens","Custom Navigation","Detail Views","Empty Data Sets","Feeds","Lists","Log In","Maps","Galleries","Popovers","Search","Settings","Sign Up Flows","Splash Screens","Stats","Timelines","User Profiles","Walkthroughs"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
        
        self.listTableView?.dataSource = self
        self.listTableView?.delegate = self
//        self.listTableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configView() {
        selectedListString = ""
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Category"
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 32
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as!ListTableViewCell
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,NSUnderlineColorAttributeName: UIColor(white: 1, alpha: 0.5) ]
        let underlineAttributedString = NSAttributedString(string: listArray[indexPath.row], attributes: underlineAttribute)
        cell.listLabel?.attributedText = underlineAttributedString
        cell.listLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedListString = listArray[indexPath.row]
        
        if let listString = selectedListString {
            delegate?.didTapOnListRow(listString)
            print("detect list tap")
        }
    }
    
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor.clearColor()
        cell?.selectedBackgroundView = highlightView
    }
    
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.clearColor()
//        view.frame.size.height = 128
//        
//        if let header = view as? UITableViewHeaderFooterView {
//            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 10.0)
//            header.textLabel?.textColor = UIColor(white: 1, alpha: 0.8)
//            header.textLabel?.frame.origin.x = 60.0
//        }
//    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 100)
    }
    

}
