//
//  NewsView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 24/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject private var service = NewsService()
    @State var isLinkActive = false
    @State var showHighlightedNewsView = false
    
    var body: some View {
        NavigationView {
            List {
                if showHighlightedNewsView {
                    VStack(spacing: 0) {
                        UIScrollViewWrapper {
                            HStack(spacing: 0) {
                                ForEach(service.highlightedItems, id: \.id) { item in
                                    
                                    HighlightedNewsView(item: item).onTapGesture {
                                        service.selectedItem = item
                                        isLinkActive = true
                                    }.frame(minWidth: UIScreen.main.bounds.size.width,
                                            maxWidth: UIScreen.main.bounds.size.width,
                                            minHeight: Constant.baseHeight,
                                            maxHeight: Constant.baseHeight)
                                    
                                }
                            }.frame(
                                minWidth: service.minWidth,
                                maxWidth: service.minWidth,
                                minHeight: Constant.baseHeight,
                                maxHeight: Constant.baseHeight)
                        }
                        .frame(minWidth: UIScreen.main.bounds.size.width,
                               maxWidth: UIScreen.main.bounds.size.width,
                               minHeight: Constant.baseHeight,
                               maxHeight: Constant.baseHeight)
                        .background(Color.customDarkBlue)
                    }
                    .frame(minWidth: UIScreen.main.bounds.size.width,
                           maxWidth: UIScreen.main.bounds.size.width,
                           minHeight: Constant.baseHeight,
                           maxHeight: Constant.baseHeight)
                    .background(Color.customDarkBlue)
                    .listRowInsets(.init())
                }
                ForEach(service.items, id: \.id) { item in
                    ZStack {
                        NewsRow(item: item).listRowInsets(EdgeInsets())
                        NavigationLink(destination: NewsDetailView(item: item)) {
                        }.buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                    }.hideRowSeparator(background: .white)
                }
            }
            .listStyle(PlainListStyle())
            .background(NavigationLink(destination: NewsDetailView(item: service.selectedItem ?? NewsItem()), isActive: $isLinkActive) {})
            .navigationBarTitle("Noticias", displayMode: Appearance.hasTopNotch ? .large : .inline)
        }
        .onAppear(perform: {
            service.getHomeNews({
                self.showHighlightedNewsView = true
            })
        })
        
    }
}

struct NewsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NewsView()
    }
}
