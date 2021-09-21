//
//  NewsDetailView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 09/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    
    @ObservedObject private var service = NewsDetailService()
    
    let item: NewsItem
    
    private let width: CGFloat = !Appearance.hasTopNotch ? 320 : 390
    private let height: CGFloat = !Appearance.hasTopNotch ? 240 : 310
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text(service.itemDetail.title)
                            .font(.title)
                            .bold()
                        Text(service.itemDetail.subtitle)
                            .font(.body)
                            .padding(.top, Constant.Measurement.base)
                        Text(service.itemDetail.subCategory)
                            .font(.caption)
                            .padding(.top, Constant.Measurement.base)
                            .foregroundColor(Color.customDarkGreen)
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(service.itemDetail.images) { image in
                                    KFImage.url(URL(string: image.url))
                                        .cacheMemoryOnly()
                                        .fade(duration: 0.25)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: width, minHeight: height, maxHeight: height, alignment: .center)
                                        .background(Color.customDarkBlue)
                                }
                            }
                            .background(Color.customDarkBlue)
                        }
                        .background(Color.customDarkBlue)
                        .padding(.top, Constant.Measurement.base)
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                
                                Text(service.itemDetail.author)
                                    .font(.callout)
                                    .foregroundColor(Color.customDarkGreen)
                                    .bold()
                                
                                Text(service.itemDetail.time)
                                    .font(.callout)
                                    .foregroundColor(Color.customRed)
                                    .padding(.top, Constant.Measurement.base)
                                
                                Text(service.itemDetail.content)
                                    .font(.body)
                                    .padding(.top, Constant.Measurement.base2x)
                            
                            }
                        }.padding(.top, Constant.Measurement.base)
                    }
                    
                }.padding(Constant.Measurement.base2x)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Color.customGray)
        .navigationBarTitle(item.category)
        .onAppear(perform: {
            service.getNewsDetail(ofNewsItem: item)
        })
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NewsDetailView(item: NewsItem(title: "Aristas de la alimentación: un bien común que no ha sido para todos",
                                      url: "https://www.gaceta.unam.mx/aristas-de-la-alimentacion-un-bien-comun-que-no-ha-sido-para-todos/",
                                      image: "https://www.gaceta.unam.mx/wp-content/uploads/2021/09/lalides-750x430.jpeg",
                                      summary: "El objetivo de la obra es apuntalar el diseño de propuestas y soluciones que contribuyan a…",
                                      category: "Destacados",
                                      subCategory: "Academia"))
    }
}
