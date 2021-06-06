//
//  SigninView.swift
//  tvOS-MAD
//
//  Created by user on 06.06.2021.
//

import SwiftUI

struct SigninView: View {
    @State var username = ""
    @State var password = ""
    @StateObject var model = ViewModel ()
    @State var message = ""
    @State var errorAlert = false
    
    var body: some View {
        ZStack (alignment: .top) {
            Image("backgroundimage").resizable() .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            VStack{
                
                ZStack{
                    Rectangle ()
                        .frame(width: 697, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    HStack (spacing:0){
                        Image("username").padding()
                        Divider().frame(width: 1, height: 50, alignment: .center)
               
                        CustomUserName(placeholder: Text ("Ivanov.I"), username: $username).padding(.horizontal,10)
                    }.frame(width: 697, height: 50, alignment: .center)
                    
                }
                ZStack{
                    Rectangle ()
                        .frame(width: 697, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                  
                    HStack (spacing:0){
                        Image("password").padding()
                        Divider().frame(width: 1, height: 50, alignment: .center)
                    
                        CustomPassword (placeholder: Text ("Password"), password: $password).padding(.horizontal,10)
                  
                    }.frame(width: 697, height: 50, alignment: .center)
                   
                }
                Button(action: {
                    if password != "" && username != "" {
                        model.signIN(username: username, password: password)
                    } else {
                        errorAlert.toggle()
                        message = "Заполните все поля"
                    }
                    
                }, label: {
                    ZStack{
                        Rectangle() .frame(width: 697, height: 50, alignment: .center).foregroundColor(.blue)
                        Text("SIGN IN").foregroundColor(.white).font(.custom("", size: 24))
                    }
                }).alert(isPresented: $errorAlert, content: {
                    Alert(title: Text("Ошибка"), message: Text("\(message)"), dismissButton: .default(Text("Закрыть")))
                }).buttonStyle(PlainButtonStyle())
            } .offset(y:400)
            
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

struct CustomUserName: View {
    @State var placeholder: Text
    @State var username: String
    @State var edit: (Bool)-> () = {_ in}
    @State var commit: () -> () = {}
    
    var body: some View {
        ZStack (alignment: .leading)  {
            
            if username.isEmpty {
                placeholder.foregroundColor(.gray).font(.custom("", size: 24))
            }
            TextField ("", text: $username, onEditingChanged: edit, onCommit: commit).frame(width: 630, height: 50, alignment: .center).font(.custom("", size: 24)).foregroundColor(.gray)
            
        }
    }
}
struct CustomPassword: View {
    @State var placeholder: Text
    @State var password: String
    @State var edit: (Bool)-> () = {_ in}
    @State var commit: () -> () = {}
    
    var body: some View {
        ZStack (alignment: .leading)  {
            
            if password.isEmpty {
                placeholder.foregroundColor(.gray).font(.custom("", size: 24))
            }
            SecureField ("", text: $password,  onCommit: commit).frame(width: 630, height: 50, alignment: .center).font(.custom("", size: 24)).foregroundColor(.gray)
            
        }
    }
}

