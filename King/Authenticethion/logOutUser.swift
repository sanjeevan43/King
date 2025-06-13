//
//  logOutUser.swift
//  Gauth
//
//  Created by sanjeev on 6/2/25.
//

import FirebaseAuth

func logOutUser() {
    do {
        try Auth.auth().signOut()
        // Handle post-logout navigation here
    } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
    }
}
