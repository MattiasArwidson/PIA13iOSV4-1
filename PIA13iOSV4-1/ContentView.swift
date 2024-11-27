//
//  ContentView.swift
//  PIA13iOSV4-1
//
//  Created by Mattias Arwidson on 2024-11-25.
//

import SwiftUI
import Firebase

class Objects {
    var id = ""
    var title = ""
    
    //Todo=Objects
    //todoadd=addData
    //todolist=list
    //todosave=saveData
    //todosnap=snapShot
    //tododict=dictate
    
    
}

struct ContentView: View {
    
    @State var addData = ""
    
    @State var list = [Objects]()
    
    var body: some View {
        VStack {
            HStack {
                TextField("NoData", text: $addData)
                Button(action: {
                    saveData()
                }){
                    Text("Save")
                }
                .disabled(addData.isEmpty)
            }
            
            List(list, id: \.id) { item in
                VStack {
                    //Text(item.id)
                    Text(item.title)
                }
            }
        }
        .padding()
        .onAppear {
            //fbtest()
            //fbtestSave()
        }
        .task {
            //await fbtestLoad()
            await loadData()
        }
    }
    
    func loadData()  async {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        list = []
        
        do {
            let messageData = try await ref.child("list").getData()
            
            print(messageData.childrenCount)
            
            for item in messageData.children {                
                let snapShot = item as! DataSnapshot
                
                let dictate = snapShot.value as? [String: String]
                
                print(dictate!["title"]!)
                
                var testList = Objects()
                testList.id = snapShot.key
                testList.title = dictate!["title"]!
                
                list.append(testList)
            }
            
        } catch {
            print("Error!")
        }
    }
    
    func saveData() {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("list").childByAutoId().child("title").setValue(addData)
        
        Task{
            await loadData()
        }
    }
    
    func fbtestSave() {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Message").setValue("Hello World!")
    }
    func fbtestLoad() async {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        do {
            let messageData = try await ref.child("Message").getData()
            if let data = messageData.value as? String {
                print("Message: \(data)")
            }
            
        } catch {
            print("Error!")
        }
    }
}

#Preview {
    ContentView()
}
