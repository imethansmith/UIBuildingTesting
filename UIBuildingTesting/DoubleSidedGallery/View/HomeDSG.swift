//
//  HomeDSG.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 18/10/21.
//

import SwiftUI

struct HomeDSG: View {
    @State var posts: [Post] = []
    @State var currentPost: String = ""
    @State var menusShown: Bool = true
    
    var body: some View {
        // Double Sided Gallery
        TabView(selection: $currentPost) {
            ForEach(posts) { post in
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(0)
                }
                .tag(post.id)
                .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                menusShown.toggle()
            }
        }
        // Top Detail View
        .overlay(
            HStack {
                Text("Scenario Pics")
                    .font(.title2.bold())
                Spacer(minLength: 0)
                Button {} label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title)
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                .offset(y: menusShown ? 0 : -150),
            alignment: .top
        )
        // Bottom Images View
        .overlay(
            // ScrollView reader navigating to current image
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) { post in
                            Image(post.postImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 60)
                                .cornerRadius(12)
                            
                                // Highlight currently selected post
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.white, lineWidth: 2)
                                        .opacity(currentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame(height: 80)
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                // As currentPost changes, center the selected image in bottom ScrollView.
                .onChange(of: currentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .bottom)
                    }
                }
            }
            .offset(y: menusShown ? 0 : 150),
            alignment: .bottom
        )
        // Load sample images
        .onAppear {
            for index in 1 ... 10 {
                posts.append(Post(postImage: "post\(index)"))
            }
            
            currentPost = posts.first?.id ?? ""
        }
    }
}

struct HomeDSG_Previews: PreviewProvider {
    static var previews: some View {
        HomeDSG()
    }
}
