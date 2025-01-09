//
//  ShapesRoot.swift
//  SnackbarDemo
//
//  Created by Brad Angliss on 11/04/2024.
//

import SwiftUI

public struct CircleToggle: View {
    
    private var id: Int
    private var selected: Binding<Int>
    
    public init(
        id: Int,
        selected: Binding<Int>
    ) {
        self.id = id
        self.selected = selected
    }
    
    public var body: some View {
        Circle()
            .stroke(.gray, lineWidth: 2)
            .fill(id == selected.wrappedValue ? .gray : .clear)
    }
}

#Preview {
    HStack(spacing: 40) {
        CircleToggle(id: 1, selected: .constant(1))
        CircleToggle(id: 2, selected: .constant(1))
        CircleToggle(id: 3, selected: .constant(1))
    }
}
