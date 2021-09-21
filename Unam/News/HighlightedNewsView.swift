//
//  HighlightedNewsView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 16/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Kingfisher

struct HighlightedNewsView: View {
    
    let item: NewsItem
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: Constant.Measurement.base) {
                        Spacer()
                        Text(item.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(.bottom, Constant.Measurement.base)
                        
                        Text(item.category)
                            .font(Font.callout)
                            .foregroundColor(Color.customGold)
                            .padding(.bottom, Constant.Measurement.base)
                        
                        Text(item.summary)
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                    .padding(.bottom, Constant.Measurement.base)
                }
                .padding(.leading, Constant.Measurement.base2x)
                .padding(.trailing, Constant.Measurement.base2x)
                .padding(.top, Constant.Measurement.base2x)
                .padding(.bottom, Constant.Measurement.base2x)
                .frame(maxWidth: .infinity, minHeight: Constant.baseHeight, maxHeight: Constant.baseHeight)
                .background(Color.customDarkBlue.opacity(0.65))
                
            }
            .frame(maxWidth: UIScreen.main.bounds.size.width,
                   minHeight: Constant.baseHeight,
                   maxHeight: Constant.baseHeight)
            .background(
                KFImage.url(URL(string: item.image))
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .resizable()
                    .background(Color.customDarkBlue)
            )
    }
}

struct HighlightedNewsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HighlightedNewsView(item: NewsItem(title: "Aristas de la alimentación: un bien común que no ha sido para todos",
                                           url: "https://www.gaceta.unam.mx/aristas-de-la-alimentacion-un-bien-comun-que-no-ha-sido-para-todos/",
                                           image: "https://www.gaceta.unam.mx/wp-content/uploads/2021/09/lalides-750x430.jpeg",
                                           summary: "El objetivo de la obra es apuntalar el diseño de propuestas y aaaa soluciones que contribuyan a…",
                                           category: "Destacados",
                                           subCategory: "Humanidades Comunidad"))
    }
}

