//
//  SUIBookLayoutTesting.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 20/10/21.
//

import SwiftUI

struct SUIBookLayoutTesting: View {
    let colors: [(Color, CGFloat)] = [(.init(white: 0.3), 50), (.init(white: 0.8), 30), (.init(white: 0.5), 75)]
    @State var expanded = true
    var body: some View {
        VStack {
            RectangleWithNotification(count: 1)
                .padding()
            HStack {
                Collapsible(data: colors, expanded: expanded) { (item: (Color, CGFloat)) in
                    Rectangle()
                        .fill(item.0)
                        .frame(width: item.1, height: item.1)
                }
            }
            Button(action: { withAnimation(.default) {
                self.expanded.toggle()
            } }, label: {
                Text(self.expanded ? "Collapse" : "Expand")
            })
        }
    }
}

struct RectangleWithNotification: View {

    @State var count: Int
    var body: some View {
        HStack {
            Button() {
                count += 1
            } label: {
                Text("Add")
            }
            ZStack {
                Rectangle()
                    .frame(width: 100, height: 60)
                    .foregroundColor(Color.green)
                    .overlay(Text("Hello"))
                    .overlay(NotificationModifier(count: count), alignment: .topTrailing)
            }
        }
    }
}

struct NotificationModifier: View {
    @State var count: Int
    var body: some View {
        HStack {
            ZStack {
                if count != 0 {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.red)
                    Text("\(count)")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .offset(x: 12, y: -12)
        }
    }
}

struct Collapsible<Element, Content: View>: View {
    var data: [Element]
    var expanded: Bool = false
    var spacing: CGFloat? = 8
    var alignment: VerticalAlignment = .center
    var collapsedWidth: CGFloat = 10
    var content: (Element) -> Content
    func child(at index: Int) -> some View {
        let showExpanded = expanded || index == data.endIndex - 1
        return content(data[index])
            .frame(width: showExpanded ? nil : collapsedWidth, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }

    var body: some View {
        HStack(alignment: alignment, spacing: expanded ? spacing : 0) {
            ForEach(data.indices, content: {
                self.child(at: $0)
            })
        }
    }
}

struct SUIBookLayoutTesting_Previews: PreviewProvider {
    static var previews: some View {
        SUIBookLayoutTesting()
    }
}
