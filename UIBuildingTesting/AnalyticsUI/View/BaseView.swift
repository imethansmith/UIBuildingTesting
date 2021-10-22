//
//  BaseView.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 23/10/21.
//

import SwiftUI

struct BaseView: View {
    // Use image names as Tab reference
    @State var currentTab = "home"

    // Hide Native TabBar
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        // Tab View
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                AUIHome()
                    .modifier(BGModifier())
                    .tag("home")
                Text("Graph")
                    .modifier(BGModifier())
                    .tag("graph")
                Text("Chat")
                    .modifier(BGModifier())
                    .tag("chat")
                Text("Settings")
                    .modifier(BGModifier())
                    .tag("settings")
            }

            // Custom Tab Bar
            HStack(spacing: 40) {
                // Tab Buttons
                TabButton(image: "home", currentTab: $currentTab)
                TabButton(image: "graph", currentTab: $currentTab)
                // Centered 'Add' button
                Button {} label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(22)
                        .background(
                            Circle()
                                .fill(Color("Tab"))
                                // Shadow
                                .shadow(color: Color("Tab").opacity(0.15), radius: 5, x: 0, y: 0)
                        )
                }
                .offset(y: -10)
                .padding(.horizontal, -15)

                TabButton(image: "chat", currentTab: $currentTab)
                TabButton(image: "settings", currentTab: $currentTab)
            }
            .padding(.top, -10)
            .frame(maxWidth: .infinity)
            .background(
                Color("BG")
                    .ignoresSafeArea()
            )
        }
    }
}

// MARK: - BaseView

extension BaseView {
    struct TabButton: View {
        var image: String
        @Binding var currentTab: String
        var body: some View {
            Button {
                withAnimation {
                    currentTab = image
                }

            } label: {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(
                        currentTab == image ? Color.black : Color.gray.opacity(0.8)
                    )
            }
        }
    }
}

//MARK: - BGModifier
extension BaseView {
    struct BGModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
