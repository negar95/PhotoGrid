//
//  AlertItem.swift
//  Grid
//
//  Created by Negar Moshtaghi on 22/11/1400 AP.
//

import SwiftUI

struct ErrorAlert: Identifiable {
    
    var id = UUID()

    var title: Text
    var message: Text = Text("Please try again later.")
    var dismissButton: Alert.Button = .default(Text("Ok"))


    func getAlert() -> Alert {
        Alert(title: self.title,
              message: self.message,
              dismissButton: self.dismissButton)
    }
}

enum AlertContext {

    static let invalidURL = ErrorAlert(title: Text("invalid URL"))

    static let invalidRequest = ErrorAlert(title: Text("ivalid Request"))

    static let invalidResponse = ErrorAlert(title: Text("invalid Response"))

    static let invalidData = ErrorAlert(title: Text("invalid Data"))


}
