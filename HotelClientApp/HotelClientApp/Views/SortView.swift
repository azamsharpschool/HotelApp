//
//  SortView.swift
//  HotelClientApp
//
//  Created by Mohammad Azam on 10/12/26.
//

import SwiftUI

struct SortView: View {
    
    @State private var selectedSortOption: SortOption?
    @Environment(\.dismiss) private var dismiss
    
    let onDone: (SortOption?) -> Void
    
    init(initialSelection: SortOption? = nil, onDone: @escaping (SortOption?) -> Void) {
        _selectedSortOption = State(initialValue: initialSelection)
        self.onDone = onDone
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button("Close") {
                    dismiss()
                }
                
                Spacer()
                
                Button("Clear") {
                    selectedSortOption = nil
                }
                
            }.padding([.bottom], 10)
            
            ForEach(SortOption.allCases) { sortOption in
                Button {
                    selectedSortOption = sortOption
                } label: {
                    HStack {
                        Image(systemName: selectedSortOption == sortOption
                              ? "largecircle.fill.circle" : "circle")

                        Text(sortOption.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            
            Button("Done") {
                onDone(selectedSortOption)
                dismiss()
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top], 20)
            .buttonStyle(.borderedProminent)
            
        }.padding()
    }
}

#Preview {
    
    @Previewable @State var selectedSortOption: SortOption?
    SortView(initialSelection: selectedSortOption) { _ in }
}
