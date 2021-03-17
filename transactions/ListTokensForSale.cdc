import PinataPartyContract from 0xf8d6e0586b0a20c7
import PinnieToken from 0xf8d6e0586b0a20c7
import MarketplaceContract from 0xf8d6e0586b0a20c7

transaction {

    prepare(acct: AuthAccount) {
        let receiver = acct.getCapability<&{PinnieToken.Receiver}>(/public/MainReceiver)
        let sale <- MarketplaceContract.createSaleCollection(ownerVault: receiver)

        let collectionRef = acct.borrow<&PinataPartyContract.Collection>(from: /storage/NFTCollection)
            ?? panic("Could not borrow owner's nft collection reference")

        let token <- collectionRef.withdraw(withdrawID: 1)

        sale.listForSale(token: <-token, price: 10.0)

        acct.save(<-sale, to: /storage/NFTSale)

        acct.link<&MarketplaceContract.SaleCollection{MarketplaceContract.SalePublic}>(/public/NFTSale, target: /storage/NFTSale)

        log("Sale Created for account 1. Selling NFT 1 for 10 tokens")
    }
}
 
