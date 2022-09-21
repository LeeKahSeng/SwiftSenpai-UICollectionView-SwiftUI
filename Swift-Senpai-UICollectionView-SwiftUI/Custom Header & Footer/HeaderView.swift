//
//  HeaderView.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 21/09/2022.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var showInfo = false
    
    var section: SymbolSection
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(section.title)
                    .font(.title)
                
                Spacer()

                Button {
                    withAnimation {
                        showInfo.toggle()
                    }
                } label: {
                    if showInfo {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.large)
                            .tint(.black)
                    } else {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .tint(.black)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(height: 50.0)
            .background {
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(Color(.systemGreen))
            }
            
            if showInfo {
                Text("This section has \(section.symbols.count) symbols")
                    .font(.footnote)
                    .foregroundColor(Color(.darkGray))
                    .transition(.scale)
            }
        }
    }
}


