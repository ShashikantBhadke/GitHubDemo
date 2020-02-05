//
//  LoginView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    // MARK:- Variables
        
    @State var pushToHome = false
    @State var pushed = false
    @State private var name: String = "ShashikantBhadke"
    @State private var search: String = ""
    // Alert
    @State private var showingAlertTitle = ""
    @State private var showingAlertMessage = "Please enter name."
    @State private var showingAlertBtn = "Ok"
    @State private var showingAlert = false
    
    // MARK:- Main Body
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Text("GitHub")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .fontWeight(Font.Weight.heavy)
                        .padding(.top, -80)
                    TextField("Try your name!", text: self.$name)
                        .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0, trailing: 16.0))
                        .frame(width: geometry.size.width, height: 40)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                    Button(action: {
                        if self.validated {
                            self.pushed = true
                            self.search = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        } else {
                            self.showingAlert = true
                        }
                    }) {
                        Text("Search")
                            .frame(width: geometry.size.width * 0.5, height: 45, alignment: .center)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .cornerRadius(5)
                        
                    }
                    .padding(.top, 30)
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text(self.showingAlertTitle), message: Text(self.showingAlertMessage), dismissButton: .default(Text(self.showingAlertBtn)))
                    }
                    NavigationLink(destination: UserListView(searchName: self.search, pushed: self.$pushed), isActive: self.$pushed) { EmptyView() }
                    Spacer()
                }
            }
        }
    }
    
    // MARK:- Button Actions
    private func btnSearchPressed() {
        pushToHome = true
    }
    
    // MARK:- Custom Methods
    private var validated: Bool {
        !name.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
