//
//  GuardianFormFirstNameView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormNoteView: View {
    @State private var progress = (100/7)*6.0
    @State private var valid = false
    @State private var note = ""
    
    var body: some View {
        GuardianFormBaseView(title: "Message personnel (facultatif)" ,progress: $progress, valid: $valid, destination: AnyView(GuardianFormConfirmSendView())) {
            TextField("Note", text: $note, onCommit:  {
                valid = true
            })
            .shadow(color: .gray.opacity(0.3), radius: 10)
            .keyboardType(.emailAddress)
        }
    }
}

struct GuardianFormNoteView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormNoteView()
    }
}
