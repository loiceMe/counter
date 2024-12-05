//
//  ViewController.swift
//  Counter
//
//  Created by   Дмитрий Кривенко on 04.12.2024.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var historyTextView: UITextView!
    @IBOutlet private weak var addBookButton: UIButton!
    @IBOutlet private weak var removeAllBooksButton: UIButton!
    @IBOutlet private weak var removeBookButton: UIButton!
    
    private var booksCounter: Int = 0 {
        didSet {
            updateCounterLabel()
            updateButtonColors()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setBooksCounter(_ counter: Int) {
        booksCounter = counter < 0 ? 0 : counter
    }
    
    private func removeAllBooks() {
        addHistoryItem(historyItemType: .reset)
        setBooksCounter(0)
    }
    
    private func updateCounterLabel() {
        counterLabel.text = "В вашей библиотеке \(booksCounter == 0 ? "нет" : "\(booksCounter)") книг"
    }
    
    private func updateButtonColors() {
        let isEmptyCounter = booksCounter == 0
        
        removeBookButton.configuration?.baseForegroundColor = isEmptyCounter ? .systemGray2 : .red
        removeAllBooksButton.configuration?.baseForegroundColor = isEmptyCounter ? .systemGray2 : .red
        removeAllBooksButton.isEnabled = !isEmptyCounter
    }
    
    private func addHistoryItem(historyItemType: HistoryItemType) {
        historyTextView.text += "\n\(getDateString()): \(historyItemType.rawValue)"
    }
    
    private func getDateString() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        return formatter.string(from: Date.now)
    }
    
    @IBAction private func onPressAddBookButton(_ sender: Any) {
        addHistoryItem(historyItemType: .add)
        setBooksCounter(booksCounter + 1)
    }
    
    @IBAction private func onPressRemoveBookButton(_ sender: Any) {
        if booksCounter - 1 < 0 {
            addHistoryItem(historyItemType: .negativeValue)
        } else {
            addHistoryItem(historyItemType: .remove)
        }
        setBooksCounter(booksCounter - 1)
    }
    
    @IBAction private func onPressRemoveAllBooksButton(_ sender: Any) {
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
}

