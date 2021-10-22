//
//  AUIHome.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 23/10/21.
//

import SwiftUI

struct AUIHome: View {
    var body: some View {
        // Home View
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weekly icons")
                            .font(.title.bold())
                        Text("Report available")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    Spacer(minLength: 10)

                    Button {} label: {
                        // Button with badge
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .overlay(
                                Text("2")
                                    .font(.caption2.bold())
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 11, y: -12),
                                alignment: .topTrailing
                            )
                            .padding(15)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }

                // StatsView
                StatsView(downloads: downloads)

                // Users View
                HStack(spacing: 0) {
                    // UserProgress
                    UserProgress(title: "New Users", color: Color("LightBlue"), image: "person", progress: 68)
                    UserProgress(title: "Old Users", color: Color("Pink"), image: "person", progress: 79)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(18)
                .padding(.vertical, 10)

                // Most Downloads
                VStack {
                    HStack {
                        Text("Top downloads")
                            .font(.callout.bold())
                        Spacer()
                        Menu {
                            Button("More") {}
                            Button("Extra") {}

                        } label: {
                            Image("menu")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "flame.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                            .padding(12)
                            .background(
                                Color.gray
                                    .opacity(0.25)
                                    .clipShape(Circle())
                            )
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Fire Flame")
                                .fontWeight(.bold)
                            Text("1289 downloads")
                                .font(.caption2.bold())
                                .foregroundColor(.gray)
                        }
                        
                        Spacer(minLength: 10)
                        
                        Image(systemName: "square.and.arrow.down.on.square.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(18)
            }
            .padding()
        }
    }
}

extension AUIHome {
    struct UserProgress: View {
        var title: String
        var color: Color
        var image: String
        var progress: CGFloat
        var body: some View {
            HStack {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(color)
                    .padding(10)
                    .background(
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            Circle()
                                .trim(from: 0, to: progress / 100)
                                .stroke(color, lineWidth: 2)
                        }
                    )
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(Int(progress))%")
                        .fontWeight(.bold)
                    Text(title)
                        .font(.caption2.bold())
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct AUIHome_Previews: PreviewProvider {
    static var previews: some View {
        AUIHome()
    }
}
