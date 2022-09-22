//
//  ViewController.swift
//  Splitter
//
//  Created by Aleksandr Morozov on 04.12.2021.
//

import UIKit
import CoreDataManager
import CoreData

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var buttonZero: UIButton!
    @IBOutlet weak var buttonTen: UIButton!
    @IBOutlet weak var buttonFifteen: UIButton!
    @IBOutlet weak var buttonTwenty: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonCalculate: UIButton!
    
    //MARK: - Variables
    var tip = 1.0
    var billTotal = 0.0
    var finalResult = "0.0"
    var groupSize = 2 {
        didSet {
            groupLabel.text = "\(groupSize)"
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        billTextField.setLeftPaddingPoints(10)
    }
    
    //MARK: - @IBAction
    @IBAction func buttonPlusPressed(_ sender: UIButton) {
        groupSize += 1
    }
    
    @IBAction func buttonMinusPressed(_ sender: UIButton) {
        if groupSize <= 2 {return}
        groupSize -= 1
    }
    
    @IBAction func tipsButtonAction(_ sender: UIButton) {
        updateTipsButton(selectedButton: sender)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        guard let billAmount = billTextField.text?.trimmingCharacters(in: .whitespaces) , !billAmount.isEmpty else {
            totalLabel.text = "Please enter bill total!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.billTextField.becomeFirstResponder()
            }
            return
        }

        let billDot = billAmount.replacingOccurrences(of: ",", with: ".")
        billTotal = Double(billDot) ?? 0
        if billTotal > 10000 {
            let alert = UIAlertController(title: "Error", message: "Maximum bill cannot exceed 10000", preferredStyle: .alert)
            alert.view.accessibilityIdentifier = "maximumBillAlert"
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        let result = billTotal * tip / Double(groupSize)
        finalResult = String(format: "%.2f", result)
        totalLabel.text = finalResult
        
        let context = CoreDataManager.sharedInstance.backgroundContext
        context.perform { [weak self] in
            let manager = NSEntityDescription.insertNewObject(forEntityName: "Bill", into: context) as! Bill
            manager.numberOfPeople = Int64(self?.groupSize ?? 0)
            manager.totalBill = result
            try! context.save()
        }
        
    }
    
    @IBAction func viewBillHistory() {
        
    }
}

//MARK: - Helping methods
extension ViewController {
    
    private  func setupView() {
        billTextField.layer.cornerRadius  =  billTextField.frame.height/2
        billTextField.layer.masksToBounds = true
        groupLabel.layer.cornerRadius  = 10
        groupLabel.layer.masksToBounds = true
        
        let tipsButtonArray = [buttonZero , buttonTen , buttonFifteen , buttonTwenty]
        for button in tipsButtonArray {
            button?.layer.cornerRadius = 10
        }
        
        let stepperButtons = [buttonPlus , buttonMinus]
        for button in stepperButtons {
            button?.layer.cornerRadius = button!.frame.height/2
        }
        buttonCalculate.layer.cornerRadius = buttonCalculate.frame.height/2
        updateTipsButton(selectedButton:buttonZero)
    }
    
    func updateTipsButton(selectedButton: UIButton) {
        let tipsButtonArray = [buttonZero , buttonTen , buttonFifteen , buttonTwenty]
        for button in tipsButtonArray {
            button?.backgroundColor =  selectedButton == button ? #colorLiteral(red: 0.6196078431, green: 0.8588235294, blue: 0.8196078431, alpha: 1) : #colorLiteral(red: 0.8941176471, green: 0.9568627451, blue: 0.9411764706, alpha: 1)
        }
        if selectedButton == buttonZero {
            tip = 1.0
        } else if selectedButton == buttonTen {
            tip = 1.1
        } else if selectedButton == buttonFifteen {
            tip = 1.15
        } else {
            tip = 1.20
        }
    }
}

//MARK: - Padding
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
