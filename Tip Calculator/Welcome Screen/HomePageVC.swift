//
//  HomePageVC.swift
//  Tip Calculator
//
//  Created by Gregory Jones on 8/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //MARK: Properties
    
       // var buttonConstraint: NSLayoutConstraint?
        var isKeyboardAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [displayTitle, billTitle,calculateButton, billView, billInput, callOutStackView, callOutInputStackView, percentTextStackView].forEach { view.addSubview($0)}
        constraintsLayout()
        configureUI()
        billInput.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    

     }
    
    // Listen for keyboard events
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Stop listening for keyboard hide/show events
   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private functions
    
    private let displayTitle: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "tip Calculator %", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratAlternates, size: 35) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            textView.backgroundColor = .none
            textView.isScrollEnabled = false
            return textView
        
    }()
    private let calculateButton: UIButton = {
        let button = salmonButton(type: .system)
        button.setTitle("CALCULATE TIP", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: 24)
        button.addTarget(self, action: #selector(calculateTipButtonPressed), for: .touchUpInside)
       return button
        
    }()
    
    private let billView: UIView = {
            let view = UIView()
                view.layer.borderWidth = 2
                view.layer.borderColor = UIColor.white.cgColor
                view.layer.cornerRadius = 4
            return view
    }()
    
    private let billInput: UITextField = {
            let textField = userInputField()
                textField.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes:[NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 35) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
                textField.textAlignment = .right
                textField.textColor = UIColor.white
        return textField
    }()
    
    private let billTitle: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Your bill", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
            textView.attributedText = attributedText
            textView.textAlignment = .left
            textView.isEditable = false
            textView.backgroundColor = .none
            textView.isScrollEnabled = false
            return textView
        
    }()
    
   private let tenPercentView: UIView = {
            let view = UIView()
                view.backgroundColor = .white
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
    }()
    
    private let fifteenPercentView: UIView = {
        let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    private let twentyPercentView: UIView = {
        let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    private let tenPercentInput: UITextField = {
        let textField = userInputField()
            textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
                textField.textAlignment = .center
        
            return textField
        
    }()
    
    private let fifteenPercentInput: UITextField = {
        let textField = userInputField()
            textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
                textField.textAlignment = .center
                return textField
        
    }()
    
    private let twentyPercentInput: UITextField = {
        let textField = userInputField()
            textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
                textField.textAlignment = .center
            return textField
        
    }()
    
    private let tenPercentTextView: UITextView = {
            let textView = UITextView()
            let attributedText = NSMutableAttributedString(string: "10%", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratAlternates, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
                textView.attributedText = attributedText
                textView.textAlignment = .center
                textView.isEditable = false
                textView.backgroundColor = .none
                textView.isScrollEnabled = false
                return textView
    }()
    
    private let fifteenPercentTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "15%", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratAlternates, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let twentyPercentTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "20%", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratAlternates, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.white])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        return textView
    }()
    
    lazy var callOutStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentView,fifteenPercentView,twentyPercentView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
        }()
    
    lazy var callOutInputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentInput, fifteenPercentInput, twentyPercentInput])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
    
        stackView.distribution = .fillEqually
        return stackView
        
    }()
    
    lazy var percentTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentTextView, fifteenPercentTextView, twentyPercentTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
        
    }()
    
private func constraintsLayout() {
        displayTitle.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: calculateButton.leadingAnchor, trailing: calculateButton.trailingAnchor, padding: .init(top: 70, left: 16, bottom: 0, right: 16))
        calculateButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:0, left: 16, bottom: 30, right: 16), size: .init(width: 0, height: 80))
       billView.anchor(top: nil, bottom: calculateButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 110, right: 16), size: .init(width: 0, height: 80))
       billInput.anchor(top: nil, bottom: calculateButton.bottomAnchor, leading: billView.leadingAnchor, trailing: billView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 130, right: 16))
       billTitle.anchor(top: callOutStackView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:78, left: 16, bottom: 0, right: 16))
        
    callOutStackView.anchor(top: nil, bottom: billView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 110 , right: 32), size: .init(width: 0, height: 2))
        
    callOutInputStackView.anchor(top: nil, bottom: billView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 120, right: 32))
    
    percentTextStackView.anchor(top: callOutStackView.bottomAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 16, bottom: 0, right: 16))
        
       }
    
    
    private func configureUI() {
            view.backgroundColor = Colors.darkPurple
    }
  
    //MARK: Selectors/Actions
    @objc private func calculateTipButtonPressed() {
        hideKeyboard()
        calculateAllTips()
    }
    
    private func errorMessage() {
        // create the alert
        let alert = UIAlertController(title: "UIAlertController", message: "Would you like to continue learning how to use iOS alerts?", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    private func hideKeyboard() {
        billInput.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
      //  buttonConstraint?.constant = -10
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
            isKeyboardAppear = false
        }
    }
    
    private func calculateAllTips() {
        guard let subtotal = convertCurrencyToDouble(input: billInput.text!) else {
            // create the alert
            let alert = UIAlertController(title: "Invalid format", message: "Please type your bill in the format $0.00", preferredStyle: UIAlertController.Style.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
           // print("Not a number! : \(billInput.text!)")
            return
        }
        print("the subtotal is: \(subtotal)")
       
        // Calculate the tips
        let tipOne = calculateTip(subtotal: subtotal, tipPercentage: 10.0)
        let tipTwo = calculateTip(subtotal: subtotal, tipPercentage: 15.0)
        let tipThree = calculateTip(subtotal: subtotal, tipPercentage: 20.0)
        
    
        // Update the UI
        tenPercentInput.text = convertDoubleToCurrency(amount: tipOne)
        fifteenPercentInput.text = convertDoubleToCurrency(amount: tipTwo)
        twentyPercentInput.text = convertDoubleToCurrency(amount: tipThree)
        
        
        //
        
        
    }
    
    private func calculateTip(subtotal: Double, tipPercentage: Double) -> Double {
        return subtotal * (tipPercentage / 100.0)
    }
    
    private func findTotalBill(subtotal: Double, tipPercentage: Double) -> Double {
            return subtotal * (tipPercentage / 100.0) + subtotal
    }
    
    private func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale.current
            return numberFormatter.number(from: input)?.doubleValue
    }
    
    private func convertDoubleToCurrency(amount: Double) -> String {
            let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = Locale.current
                return numberFormatter.string(from: NSNumber(value: amount))!
    }
}

extension HomePageViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return pressed")
        hideKeyboard()
        calculateAllTips()
        return true
    }
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
}
