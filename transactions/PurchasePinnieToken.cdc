import PinataPartyContract from 0xf8d6e0586b0a20c7
import PinnieToken from 0xf8d6e0586b0a20c7
import MarketplaceContract from 0xf8d6e0586b0a20c7

transaction {
    let collectionRef: &AnyResource{PinataPartyContract.NFTReceiver}
    let temporaryVault: @PinnieToken.Vault

    prepare(acct: AuthAccount) {
        self.collectionRef = acct.borrow<&AnyResource{PinataPartyContract.NFTReceiver}>(from: /storage/NFTCollection)!
        let vaultRef = acct.borrow<&PinnieToken.Vault>(from: /storage/MainVault)
            ?? panic("Could not borrow owner's vault reference")

        self.temporaryVault <- vaultRef.withdraw(amount: 10.0)
    }

    execute {
        let seller = getAccount(0xf8d6e0586b0a20c7)
        let saleRef = seller.getCapability<&AnyResource{MarketplaceContract.SalePublic}>(/public/NFTSale)
            .borrow()
            ?? panic("Could not borrow seller's sale reference")

        saleRef.purchase(tokenID: 1, recipient: self.collectionRef, buyTokens: <-self.temporaryVault)
    }
}
 
