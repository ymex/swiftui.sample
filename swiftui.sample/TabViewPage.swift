//
//  TabViewPage.swift
//  swiftui.sample
//
//  Created by 一木二小 on 2020/12/7.
//

import SwiftUI
import Introspect

struct Player {
    let name: String
    let surname: String
}

/// 重点：
/// TabView配合 NavigationView、NavigationLink 使用
/// 使用SwiftUi-Introspect 获取UIKit 组件进行隐藏 TabBar 操作。

struct TabViewPage: View {
    
    @State private var selection = 0
    @State private var active = false
    
    private var players = [
        Player(name: "Lionel", surname: "Messi"),
        Player(name: "Diogo", surname: "Jota"),
    ]
    
    var body: some View {
        // NavigationView 要写在TabView外层， 否则跳转的子页面也会带有TabBar
        NavigationView{
            TabView(selection:self.$selection){
                VStack{
                    List(0..<players.count, id: \.self) { index in
                        
                        VStack{
                            NavigationLink(destination:Text("TAB 0 Detail"),isActive:self.$active) {
                                Text("\(index) \(players[index].name)")
                            }
                        }
                    }
                }.tabItem {
                    Image(systemName: "house.fill")
                    Text("Players")
                }.tag(0)
                
                VStack{
                    List(0..<100, id: \.self) { index in
                        Text("#\(index)")
                    }
                }.tabItem {
                    Image(systemName: "book.fill")
                    Text("Players")
                }.tag(1)
                
            }.navigationTitle("HOME")
            .navigationBarTitle("HOME")
            .navigationBarTitleDisplayMode(.inline)
            .introspectTabBarController { tabbar in
                //显示或隐藏tabBar
                tabbar.tabBar.isHidden = false
            }
        }
    }
}

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
