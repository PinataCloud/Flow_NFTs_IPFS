import PinnieToken from 0xf8d6e0586b0a20c7

transaction {
	prepare(acct: AuthAccount) {
		let vaultA <- PinnieToken.createEmptyVault()
			
		acct.save<@PinnieToken.Vault>(<-vaultA, to: /storage/MainVault)

    log("Empty Vault stored")

		let ReceiverRef = acct.link<&PinnieToken.Vault{PinnieToken.Receiver, PinnieToken.Balance}>(/public/MainReceiver, target: /storage/MainVault)

    log("References created")
	}

    post {
        getAccount(0xf8d6e0586b0a20c7).getCapability<&PinnieToken.Vault{PinnieToken.Receiver}>(/public/MainReceiver)
                        .check():  
                        "Vault Receiver Reference was not created correctly"
    }
}
 