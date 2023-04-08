//
//  DataProvider.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 15/10/2022.
//

import Foundation

struct DataProvider {
    
    /// Sample data for demo purpose
    private static let serverData = [
        Quote(symbol: "person.2", content: "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.", author: "Martin Fowler"),
        Quote(symbol: "desktopcomputer", content: "First, solve the problem. Then, write the code.", author: "John Johnson"),
        Quote(symbol: "arrow.3.trianglepath", content: "Before software can be reusable it first has to be usable.", author: "Ralph Johnson"),
        Quote(symbol: "exclamationmark.triangle", content: "The best error message is the one that never shows up.", author: "Thomas Fuchs"),
        Quote(symbol: "brain.head.profile", content: "The only way to learn a new programming language is by writing programs in it.", author: "Dennis Ritchie"),
        Quote(symbol: "house", content: "Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live", author: "John Woods"),
        Quote(symbol: "chevron.left.forwardslash.chevron.right", content: "Truth can only be found in one place: the code.", author: " Robert C. Martin"),
        Quote(symbol: "hammer", content: "In some ways, programming is like painting. You start with a blank canvas and certain basic raw materials. You use a combination of science, art, and craft to determine what to do with them.", author: "Andrew Hunt"),
        Quote(symbol: "lightbulb", content: "Testing leads to failure, and failure leads to understanding.", author: "Burt Rutan"),
        Quote(symbol: "snowflake", content: "Walking on water and developing software from a specification are easy if both are frozen.", author: "Edward V. Berard"),
    ]
    
    /// Simulate fetching data from a remote server
    static func fetchData() async -> [Quote] {
        
        // Sleep for 2s to simulate a wait when fetching data from remote server
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        // return `serverData` shuffled
        return serverData.shuffled()
    }
}
