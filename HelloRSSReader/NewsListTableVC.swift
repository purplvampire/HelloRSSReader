//
//  NewsListTableVC.swift
//  HelloRSSReader
//
//  Created by 陳信彰 on 2023/7/10.
//

import UIKit
import Network

class NewsListTableVC: UITableViewController {
    
    let pathMonitor = NWPathMonitor()   // 網路狀態追蹤器

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Start pathMonitor.
        pathMonitor.pathUpdateHandler = pathUpdateHandler   // 將func存成屬性值
        
        // 指定一個Queue背景監控網路狀態
        let monitorQueue = DispatchQueue(label: "PathMonitorQueue")
        pathMonitor.start(queue: monitorQueue)
        
    }
    
    @IBAction func refreshBtnPressed(_ sender: UIBarButtonItem) {
        // 先檢查連線狀態是否正常，再執行更新
        let path = pathMonitor.currentPath
        guard path.status == .satisfied else {
            // show alert...
            let alertVC = UIAlertController(title: "Warming!!", message: "Network is not available.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            present(alertVC, animated: true)
            return
        }

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // 將closure存成function,當成參數傳遞
    func pathUpdateHandler(path: NWPath) {
        // 偵測網路狀態
        switch path.status {
        case .satisfied:
            print("Internet connection is OK!")
        default:
            print("Internet connection is not available!")
        }
        // 檢查連線方式(31_closure P.51)
//        let interfaces = path.availableInterfaces.filter { interface in
//            return path.usesInterfaceType(interface.type)
//        }
        // closure參數簡寫並省略return(31_closure P.48)
        let interfaces = path.availableInterfaces.filter { path.usesInterfaceType($0.type)
        }
        // 判斷網路類型
        if let type = interfaces.first?.type {
            if type == .cellular {
                // ...
            }
            print("Current type: \(type)")
        }
    }

}
