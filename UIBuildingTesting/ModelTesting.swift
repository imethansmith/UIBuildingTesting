//
//  ModelTesting.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 20/10/21.
//

/*
 This file is for testing saving/retreiving data for custom objects.
 */

import Foundation
import SwiftUI

struct Settings: Codable {
    let darkMode: Bool
    let name: String
    let colorHex: String
}

struct ModelTestingView: View {
    @AppStorage("settings")
    private var settingsData = Data()
    @State private var output: String = ""
    @State private var color = Color.black

    var body: some View {
        VStack {
            Text(output)
                .foregroundColor(color)

            Button("Load from App Storage") {
                guard let settings = try? JSONDecoder().decode(Settings.self, from: settingsData) else { return }
                color = Color(hex: settings.colorHex) ?? Color.red
                output = "isDarkMode: \(settings.darkMode), name: \(settings.name)"
            }

            Button("Save in User Defaults") {
                let settings = Settings(darkMode: false, name: "Jack Smith", colorHex: "#0f0f0f")

                guard let settingsData = try? JSONEncoder().encode(settings) else { return }
                self.settingsData = settingsData
            }
        }
    }
}

// Add Color from Hex support
public extension Color {
    init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        return nil
    }
}

struct ModelTestingView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTestingView()
    }
}
