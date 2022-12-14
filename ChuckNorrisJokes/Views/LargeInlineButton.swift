//
//  LargeInlineButton.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI

struct LargeInlineButton: View {
    let title: String
    let color = Color.secondary
    let action: () -> Void
    
    var body: some View {
        Button(title, action: self.action)
            .scaleEffect(0.8)
            .font(.title)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, maxHeight: 60)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 2))
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

#if DEBUG
struct LargeInlineButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeInlineButton(title: "Toggle Language", action: {})
            .previewLayout(.sizeThatFits)
    }
}
#endif
