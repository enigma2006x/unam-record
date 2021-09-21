//
//  NewsRow.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 09/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Kingfisher

struct NewsRow: View {
    
    let item: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        KFImage.url(URL(string: item.image))
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .resizable()
                            .frame(width: 110, height: 80, alignment: .center)
                            .background(Color.customDarkBlue)
                        
                    }.background(Color.customDarkBlue)
                    VStack(alignment: .leading) {
                        ZStack(alignment: .bottom) {
                            Text(item.category)
                                .font(Font.caption)
                                .foregroundColor(Color.customDarkGreen)
                        }
                    }
                }
                Spacer()
                ZStack(alignment: .top) {
                    Text(item.title)
                        .font(Font.mbTitle)
                        .bold()
                        .foregroundColor(Color.customRed)
                    
                }
                Spacer()
                VStack {
                    ZStack(alignment: .bottom) {
                        Image.customRightArrow2.frame(width: 45, height: 45, alignment: .bottom)
                    }
                }
            }
            .padding(.leading, Constant.Measurement.base)
            .padding(.trailing, Constant.Measurement.base)
            .padding(.top, Constant.Measurement.base3x)
            
            ZStack(alignment: .topLeading) {
                VStack {
                    Text(item.summary)
                        .font(.headline)
                        .foregroundColor(Color.customDarkBlue)
                    
                }
                
            }
            .padding(.leading, Constant.Measurement.base)
            .padding(.trailing, Constant.Measurement.base)
            .padding(.bottom, Constant.Measurement.base3x)
            .padding(.top, Constant.Measurement.base)
        }
        .background(Color.customGray)
        .padding(.top, Constant.Measurement.base)
        .padding(.leading, Constant.Measurement.base)
        .padding(.bottom, Constant.Measurement.base)
        .padding(.trailing, Constant.Measurement.base)
    }
}

struct NewsRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NewsRow(item: NewsItem(title: "Aristas de la alimentación: un bien común que no ha sido para todos",
                               url: "https://www.gaceta.unam.mx/aristas-de-la-alimentacion-un-bien-comun-que-no-ha-sido-para-todos/",
                               image: "https://www.gaceta.unam.mx/wp-content/uploads/2021/09/lalides-750x430.jpeg",
                               summary: "El objetivo de la obra es apuntalar el diseño de propuestas y aaaa soluciones que contribuyan a…",
                               category: "Destacados",
                               subCategory: "Humanidades Comunidad"))
    }
}
