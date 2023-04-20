// Created by Florian Schweizer on 15.02.23

import MailKit
import SwiftUI
import OpenAISwift

class ComposeSessionViewController: MEExtensionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do view setup here.
    
    view = NSHostingView(rootView: MailPopoverView())
  }
  
}

struct MailPopoverView: View {
  @State private var input: String = ""
  @State private var tone: String = "regular"
  @State private var isLoading: Bool = false
  @State private var error: Error? = nil
  @State private var result: String? = nil
  
  var body: some View {
    VStack(alignment: .leading) {
      TextField("Input", text: $input, axis: .vertical)
        .lineLimit(10, reservesSpace: true)
      
      Picker("Tone", selection: $tone) {
        Text("Regular").tag("regular")
        Text("Professional").tag("professional")
        Text("Angry").tag("angry")
      }
      
      Button("Get Reply") {
        isLoading = true
        let prompt = "You're my personal assistant. Please reply to the following message that I received in a \(tone) tone: " + input
        
        OpenAISwift(authToken: apiKey)
          .sendCompletion(with: prompt, maxTokens: 100) { result in
            isLoading = false
            
            switch result {
              case .success(let success):
                self.result = success.choices.first?.text
                self.error = nil
                
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(self.result ?? "", forType: .string)
                
              case .failure(let failure):
                self.error = failure
            }
          }
      }
      .buttonStyle(.borderedProminent)
      
      if isLoading {
        ProgressView()
      } else if error != nil { 
        Text("There was an error with your request. Please try again.")
          .foregroundColor(.red)
      } else if let result {
        Text(result)
          .textSelection(.enabled)
      }
      
      Spacer()
    }
    .padding()
    .frame(width: 500, height: 600)
  }
}

struct MailPopoverView_Previews: PreviewProvider {
  static var previews: some View {
    MailPopoverView()
  }
}

