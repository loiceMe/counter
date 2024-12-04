//
//  ViewController.swift
//  Counter
//
//  Created by   Дмитрий Кривенко on 04.12.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    @IBOutlet weak var addBookButton: UIButton!
    @IBOutlet weak var removeAllBooksButton: UIButton!
    @IBOutlet weak var removeBookButton: UIButton!
    
    private var _booksCounter: Int = 0 {
        didSet {
            updateCounterLabel()
            updateButtonColors()
        }
    }
    
    private var booksCounter: Int {
        set { _booksCounter = newValue < 0 ? 0 : newValue }
        get { _booksCounter }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPressAddBookButton(_ sender: Any) {
        addHistoryItem(historyItemType: .add)
        booksCounter += 1
    }
    
    @IBAction func onPressRemoveBookButton(_ sender: Any) {
        if booksCounter - 1 < 0 {
            addHistoryItem(historyItemType: .negativeValue)
        } else {
            addHistoryItem(historyItemType: .remove)
        }
        booksCounter -= 1
    }
    
    @IBAction func onPressRemoveAllBooksButton(_ sender: Any) {
        let removeAllBooksAlert = UIAlertController(title: "Удаление",
                                      message: "Вы действительно хотите удалить все книги?",
                                      preferredStyle: UIAlertController.Style.alert)

        removeAllBooksAlert.addAction(UIAlertAction(title: "Удалить",
                                                    style: UIAlertAction.Style.destructive,
                                                    handler: { _ in self.removeAllBooks() }))
        removeAllBooksAlert.addAction(UIAlertAction(title: "Отмена",
                                                    style: UIAlertAction.Style.cancel,
                                                    handler: nil))

        self.present(removeAllBooksAlert, animated: true, completion: nil)
    }
    
    private func removeAllBooks() {
        addHistoryItem(historyItemType: .reset)
        booksCounter = 0
    }
    
    private func updateCounterLabel() {
        counterLabel.text = "В вашей библиотеке \(booksCounter == 0 ? "нет" : "\(booksCounter)") книг"
    }
    
    private func updateButtonColors() {
        if booksCounter == 0 {
            removeBookButton.configuration?.baseForegroundColor = .systemGray2
            removeAllBooksButton.configuration?.baseForegroundColor = .systemGray2
            removeAllBooksButton.isEnabled = false
        } else {
            removeBookButton.configuration?.baseForegroundColor = .red
            removeAllBooksButton.configuration?.baseForegroundColor = .red
            removeAllBooksButton.isEnabled = true
        }
    }
    
    private func addHistoryItem(historyItemType: HistoryItemType) {
        historyTextView.text += "\n\(getDateString()): \(historyItemType.rawValue)"
    }
    
    private func getDateString() -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        return formatter.string(from: Date.now)
    }
}

