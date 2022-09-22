//
//  ViewBillsHistoryViewController.swift
//  Splito
//
//  Created by Shahid Latif on 22/06/2022.
//

import UIKit
import CoreDataManager

class ViewBillsHistoryViewController: UIViewController {
    var bills:[Bill]?
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var numberOfPeopleInBill: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "billHistoryTableView"
        Timer.scheduledTimer(timeInterval: Double.random(in: 10...20), target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        activityIndicator.startAnimating()
    }
    
    @objc func updateUI() {
        bills = CoreDataManager.sharedInstance.mainContext.managerFor(Bill.self).array
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            
            let totalPeopleInBillHistory: Int = CoreDataManager.sharedInstance.mainContext.managerFor(Bill.self).sum("numberOfPeople") as? Int ?? 0
            self?.numberOfPeopleInBill.text = String(format: "Total People: %d ", totalPeopleInBillHistory)
            let totalBillInBillHistory = CoreDataManager.sharedInstance.mainContext.managerFor(Bill.self).sum("totalBill") as? Double ?? 0
            self?.totalBillLabel.text =  String(format: "Total Bill: %.2f", totalBillInBillHistory)
            
            self?.emptyView.isHidden =  (self?.bills?.count ?? 0) > 0
        }
    }
}

extension ViewBillsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billHistoryCell", for: indexPath) as! BillTableViewCell
        let bill  = bills?[indexPath.row]
        cell.billDescription.text = String(format: "Sr. %d | Total Bill: %.2f | number OF People: %d", indexPath.row + 1, bill?.totalBill ?? 0, bill?.numberOfPeople ?? 0)
        return cell
    }
}
