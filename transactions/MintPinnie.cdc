// Mint Tokens

import PinnieToken from 0xf8d6e0586b0a20c7

transaction {
    let mintingRef: &PinnieToken.VaultMinter

    var receiver: Capability<&PinnieToken.Vault{PinnieToken.Receiver}>

	prepare(acct: AuthAccount) {
        self.mintingRef = acct.borrow<&PinnieToken.VaultMinter>(from: /storage/MainMinter)
            ?? panic("Could not borrow a reference to the minter")
        
        let recipient = getAccount(0xf8d6e0586b0a20c7)
      
        self.receiver = recipient.getCapability<&PinnieToken.Vault{PinnieToken.Receiver}>
(/public/MainReceiver)

	}

    execute {
        self.mintingRef.mintTokens(amount: 30.0, recipient: self.receiver)

        log("30 tokens minted and deposited to account 0xf8d6e0586b0a20c7")
    }
}
 
