//
//  QRCodeScanView.swift
//  StampCardAdmin
//
//  Created by KazukiNakano on 2020/05/08.
//  Copyright © 2020 kazudmb. All rights reserved.
//

import SwiftUI
import CodeScanner
import Firebase

struct QRCodeScanView: View {
    @State private var uid = ""
    @State private var isShowingScanner = false
    @State private var isShowAlert = false
    
    var alert: Alert{
        Alert(title: Text("確認"),
              message: Text("スタンプを押しますか？"),
              primaryButton:
            .default(Text("キャンセル"), action: {
                print("cancel tapped")
            }),
              secondaryButton:
            .default(Text("OK"), action: {
                print("OK tapped")})
        )
    }
    
    var body: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr], simulatedData: "", completion: self.handleScan)
            VStack() {
                Spacer()
                Text("QRコードを画面に写すとスキャンします。")
                    .padding()
                    .padding(.bottom)
            }
        }
        .alert(isPresented: $isShowAlert, content: {self.alert})
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            self.uid = code
            print("Scanning success")
            self.isShowAlert.toggle()
            
        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    private func getNumberOfVisits() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists {
                let numberOfVisits = document.data()?["NumberOfVisits"] as? Int ?? 0
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView()
    }
}
