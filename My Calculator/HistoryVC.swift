//
//  HistoryVC.swift
//  My Calculator
//
//  Created by Khater on 1/31/22.
//  Copyright © 2022 Khater. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var historyArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension HistoryVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(historyArray[indexPath.row])
    }
    
}

extension HistoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = historyArray[indexPath.row]
        return cell
    }
    
    
}
