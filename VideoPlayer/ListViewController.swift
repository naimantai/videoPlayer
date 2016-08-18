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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 24
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath)
        let listItem = listArray[indexPath.row]
        cell.textLabel?.text = listItem
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedListString = listArray[indexPath.row]
        
        if let listString = selectedListString {
            delegate?.didTapOnListRow(listString)
            print("detect list tap")
        }
    }
    

}
