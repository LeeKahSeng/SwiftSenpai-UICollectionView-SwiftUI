//
//  TodoListCell.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 05/09/2022.
//

import SwiftUI

struct TodoListCell: View {

    @ObservedObject var item: TodoItem

    var body: some View {
        HStack {
            Text(item.title)
                .font(Font.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .strikethrough(item.completed)
                .foregroundColor(item.completed ? .gray : .black)

            // Bind `Toggle` to `item`
            Toggle("", isOn: $item.completed.animation())
                .frame(maxWidth: 50)
        }
    }
}
