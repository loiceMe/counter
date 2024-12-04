//
//  HistoryItemType.swift
//  Counter
//
//  Created by   Дмитрий Кривенко on 04.12.2024.
//

enum HistoryItemType: String {
    case add = "добавлена книга"
    case remove = "удалена книга"
    case reset = "удалены все книги"
    case negativeValue = "попытка удалить книгу из пустой библиотеки"
}
