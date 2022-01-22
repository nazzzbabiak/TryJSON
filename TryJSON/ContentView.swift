//
//  ContentView.swift
//  TryJSON
//
//  Created by Nazar Babyak on 22.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var posts: [Post] = []
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                VStack{
                    Text(post.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Text(post.body)
                }
            }
            .onAppear() {
                API().getPost { (posts) in
                    self.posts = posts
                }
            }
            .navigationBarTitle("Hello")
        }
    }
}

struct Post: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
    
}

class API {
    func getPost(completion: @escaping ([Post]) -> ()){
         guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
