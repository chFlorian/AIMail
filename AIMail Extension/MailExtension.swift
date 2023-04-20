// Created by Florian Schweizer on 15.02.23

import MailKit

class MailExtension: NSObject, MEExtension {
    
    
    func handler(for session: MEComposeSession) -> MEComposeSessionHandler {
        // Create a unique instance, since each compose window is separate.
        return ComposeSessionHandler()
    }

    
}

