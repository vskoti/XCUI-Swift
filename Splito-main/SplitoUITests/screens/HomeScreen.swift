//
//  HomeScreen.swift
//  SplitoUITests
//
//  Created by Sindhu Vijayendra on 9/22/22.
//
import XCTest

struct homeScreen {
    let application : XCUIApplication
    let enterBillAmount : XCUIElement
    let incrementPerson : XCUIElement
    let decrementPerson : XCUIElement
    let totalPersonsInBillAmount : XCUIElement
    let tiopPercent_10 : XCUIElement
    let calculateBillButton : XCUIElement
     
    init(application: XCUIApplication) {
        self.application = application
        self.enterBillAmount = self.application.textFields["bill_entered_amount"]
        self.incrementPerson = self.application.buttons["increment_person"]
        self.decrementPerson = self.application.buttons["decrement_person"]
        self.totalPersonsInBillAmount = self.application.buttons["total_person_in_bill"]
        self.tiopPercent_10 = self.application.buttons["10_percent"]
        self.calculateBillButton = self.application.buttons["calculate_bill_button"]
    }
}
