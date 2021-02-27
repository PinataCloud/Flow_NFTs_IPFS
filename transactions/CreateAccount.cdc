transaction (pubKey: String) {
    prepare( admin: AuthAccount) {
        let newAccount = AuthAccount(payer:admin)
        newAccount.addPublicKey(pubKey.decodeHex())
        
        // Emit an 'account created' event
    }
}