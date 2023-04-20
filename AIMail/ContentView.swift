// Created by Florian Schweizer on 15.02.23

import SwiftUI

extension Date {
  var startOfYear: Date {
     Calendar.current.dateInterval(of: .year, for: self)!.start
  }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Text(Date.now.startOfYear, format: .dateTime)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
