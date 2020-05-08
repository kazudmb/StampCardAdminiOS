//
//  ContentView.swift
//  StampCardAdmin
//
//  Created by KazukiNakano on 2020/05/08.
//  Copyright © 2020 kazudmb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isShowQRCodeScanView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isShowQRCodeScanView.toggle()
                }) {
                    Text("QRコードを読み取る")
                }
                NavigationLink(destination: QRCodeScanView(isShowQRCodeScanView: $isShowQRCodeScanView), isActive:  $isShowQRCodeScanView) {
                    EmptyView()
                }
            }
            .navigationBarTitle(Text("Stamp Card Admin"), displayMode:.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
