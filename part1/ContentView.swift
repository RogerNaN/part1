//
//  ContentView.swift
//  part1
//
//  Created by 賴冠宏 on 2022/5/30.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var mod = false
    @State private var modIn = 2
    @State private var noAlert = false
    
    func signIn(){
        Auth.auth().signIn(withEmail: "\(email)", password: "\(password)") { result, error in
             guard error == nil else {
                mod = false//let everytime wrong try mod can change
                self.noAlert = true
                print(error?.localizedDescription)
                return
             }
            mod = true
            print("success")
        }
    }
    
    func userIn(){
        Auth.auth().addStateDidChangeListener { auth, user in
           if let user = user {
               print("\(user.uid) login")
           } else {
               print("not login")
           }
        }
    }
    
    func signOut(){
        do {
           try Auth.auth().signOut()
            print("signOut_success")
        } catch {
           print(error)
        }
    }
    var body: some View {
        NavigationView{
        VStack{
            
            TextField("帳號(email)", text: $email)
                .frame(width: 300, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
        
            SecureField("密碼", text: $password)
                .frame(width: 300, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            Text("")
                
            HStack{
                NavigationLink(
                    destination: Register(),
                    label: {
                        Text("註冊")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
                
                Button("登錄"){
                    signIn()
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.green)
                .cornerRadius(8)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .alert(isPresented: $noAlert, content: {
                    Alert(title: Text("帳號或密碼錯誤！"), primaryButton: .default(Text("再試一次")), secondaryButton: .default(Text("取消")))
                })
                NavigationLink(
                    destination: Home(emailIn: $email), isActive:$mod){
                }
            }
        }
        .navigationTitle("Hello!")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
