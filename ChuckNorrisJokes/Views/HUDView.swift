//
//  HUDView.swift
//  ChuckNorrisJokes
//
//  Created by User on 9/23/22.
//  Copyright © 2022 Byron Mejia. All rights reserved.
//

import SwiftUI

struct HUDView: View {
    enum ImageType {
        case rofl, thumbDown
    }
    
    let imageType: ImageType
    
    var body: some View {
        image(for: imageType)
            .background(Color.clear)
    }
    
    private func image(for type: ImageType) -> Image {
        let image: UIImage
        switch imageType {
            case .rofl:
                image = ChuckNorrisJokesStyleKit.imageOfROFLIcon
            case .thumbDown:
                image = ChuckNorrisJokesStyleKit.imageOfThumbDownIcon
        }
        
        return Image(uiImage: image)
    }
}

#if DEBUG
struct HUDView_Previews: PreviewProvider {
    static var previews: some View {
        HUDView(imageType: .rofl)
            .previewLayout(.sizeThatFits)
    }
}
#endif
